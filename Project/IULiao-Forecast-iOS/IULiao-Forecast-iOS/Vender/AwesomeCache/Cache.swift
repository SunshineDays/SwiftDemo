import Foundation

/// Represents the expiry of a cached object
public enum CacheExpiry {
	case never
	case seconds(TimeInterval)
	case date(Foundation.Date)
}

/// A generic cache that persists objects to disk and is backed by a NSCache.
/// Supports an expiry date for every cached object. Expired objects are automatically deleted upon their next access via `objectForKey:`.
/// If you want to delete expired objects, call `removeAllExpiredObjects`.
///
/// Subclassing notes: This class fully supports subclassing.
/// The easiest way to implement a subclass is to override `objectForKey` and `setObject:forKey:expires:`, 
/// e.g. to modify values prior to reading/writing to the cache.
open class Cache<T: NSCoding> {
    public let name: String
    public let cacheDirectory: URL
	
	internal let cache = NSCache<AnyObject, AnyObject>() // marked internal for testing
	private let fileManager = FileManager()
	private let diskWriteQueue: DispatchQueue = DispatchQueue(label: "com.aschuch.cache.diskWriteQueue", attributes: [])
	private let diskReadQueue: DispatchQueue = DispatchQueue(label: "com.aschuch.cache.diskReadQueue", attributes: [])
	
	
	// MARK: Initializers
	
	/// Designated initializer.
	///
	/// - parameter name: Name of this cache
	///	- parameter directory:  Objects in this cache are persisted to this directory.
	///                         If no directory is specified, a new directory is created in the system's Caches directory
	///
	///  - returns:	A new cache with the given name and directory
	public init(name: String, directory: URL?) throws {
		self.name = name
		cache.name = name
		
		if let d = directory {
			cacheDirectory = d
		} else {
            let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
			cacheDirectory = url.appendingPathComponent("com.aschuch.cache/\(name)")
		}
		
		// Create directory on disk if needed
        try fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
	}
	
    /// Convenience Initializer
    ///
    /// - parameter name: Name of this cache
    ///
	/// - returns	A new cache with the given name and the default cache directory
	public convenience init(name: String) throws {
		try self.init(name: name, directory: nil)
	}
	
	
	// MARK: Awesome caching
	
	/// Returns a cached object immediately or evaluates a cacheBlock.
    /// The cacheBlock will not be re-evaluated until the object is expired or manually deleted.
	/// If the cache already contains an object, the completion block is called with the cached object immediately.
    ///
	/// If no object is found or the cached object is already expired, the `cacheBlock` is called.
	/// You might perform any tasks (e.g. network calls) within this block. Upon completion of these tasks, 
    /// make sure to call the `success` or `failure` block that is passed to the `cacheBlock`.
	/// The completion block is invoked as soon as the cacheBlock is finished and the object is cached.
	///
	/// - parameter key:			The key to lookup the cached object
	/// - parameter cacheBlock:	This block gets called if there is no cached object or the cached object is already expired.
	///                         The supplied success or failure blocks must be called upon completion.
	///                         If the error block is called, the object is not cached and the completion block is invoked with this error.
    /// - parameter completion: Called as soon as a cached object is available to use. The second parameter is true if the object was already cached.
	open func setObjectForKey(_ key: String, cacheBlock: ((T, CacheExpiry) -> (), (NSError?) -> ()) -> (), completion: @escaping (T?, Bool, NSError?) -> ()) {
		if let object = objectForKey(key) {
			completion(object, true, nil)
		} else {
			let successBlock: (T, CacheExpiry) -> () = { (obj, expires) in
				self.setObject(obj, forKey: key, expires: expires)
				completion(obj, false, nil)
			}
			
			let failureBlock: (NSError?) -> () = { (error) in
				completion(nil, false, error)
			}
			
			cacheBlock(successBlock, failureBlock)
		}
	}
	
	
	// MARK: Get object
	
    /// Looks up and returns an object with the specified name if it exists.
    /// If an object is already expired, it is automatically deleted and `nil` will be returned.
    ///
    /// - parameter key: The name of the object that should be returned
    ///
    /// - returns: The cached object for the given name, or nil
	open func objectForKey(_ key: String) -> T? {
		var possibleObject: CacheObject?
				
		// Check if object exists in local cache
		possibleObject = cache.object(forKey: key as AnyObject) as? CacheObject
		
		if possibleObject == nil {
			// Try to load object from disk (synchronously)
			diskReadQueue.sync {
				let path = self.urlForKey(key).path
				if self.fileManager.fileExists(atPath: path) {
					possibleObject = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? CacheObject
				}
			}
		}
		
		// Check if object is not already expired and return
		// Delete object if expired
		if let object = possibleObject {
			if !object.isExpired() {
				return object.value as? T
			} else {
				removeObjectForKey(key)
			}
		}
		
		return nil
	}
	
	
	// MARK: Set object
	
	/// Adds a given object to the cache.
	/// The object is automatically marked as expired as soon as its expiry date is reached.
	///
	/// - parameter object:	The object that should be cached
	/// - parameter forKey:	A key that represents this object in the cache
    /// - parameter expires: The CacheExpiry that indicates when the given object should be expired
    open func setObject(_ object: T, forKey key: String, expires: CacheExpiry = .never) {
        setObject(object, forKey: key, expires: expires, completion: { })
    }
    
    /// For internal testing only, might add this to the public API if needed
    internal func setObject(_ object: T, forKey key: String, expires: CacheExpiry = .never, completion: @escaping () -> ()) {
        let expiryDate = expiryDateForCacheExpiry(expires)
        let cacheObject = CacheObject(value: object, expiryDate: expiryDate)
        
        // Set object in local cache
        cache.setObject(cacheObject, forKey: key as AnyObject)
        
        // Write object to disk (asyncronously)
        diskWriteQueue.async {
            let path = self.urlForKey(key).path
            NSKeyedArchiver.archiveRootObject(cacheObject, toFile: path)
            completion()
        }
    }
	
	
	// MARK: Remove objects
	
	/// Removes an object from the cache.
	///
	/// - parameter key: The key of the object that should be removed
	open func removeObjectForKey(_ key: String) {
		cache.removeObject(forKey: key as AnyObject)
		
		diskWriteQueue.async {
			let url = self.urlForKey(key)
			do {
				try self.fileManager.removeItem(at: url)
			} catch _ {}
		}
	}
	
	/// Removes all objects from the cache.
	///
	/// - parameter completion:	Called as soon as all cached objects are removed from disk.
	open func removeAllObjects(_ completion: (() -> Void)? = nil) {
		cache.removeAllObjects()
		
		diskWriteQueue.async {
            let keys = self.allKeys()
			
            for key in keys {
				let url = self.urlForKey(key)
				do {
					try self.fileManager.removeItem(at: url)
				} catch _ {}
			}

			DispatchQueue.main.async {
				completion?()
			}
		}
	}
	
	
	// MARK: Remove Expired Objects
	
	/// Removes all expired objects from the cache.
	open func removeExpiredObjects() {
		diskWriteQueue.async {
            let keys = self.allKeys()
			
			for key in keys {
				// `objectForKey:` deletes the object if it is expired
				let _ = self.objectForKey(key)
			}
		}
	}
	
	
	// MARK: Subscripting
	
	open subscript(key: String) -> T? {
		get {
			return objectForKey(key)
		}
		set(newValue) {
			if let value = newValue {
				setObject(value, forKey: key)
			} else {
				removeObjectForKey(key)
			}
		}
	}
	
	
	// MARK: Private Helper
    
    private func allKeys() -> [String] {
        let urls = try? self.fileManager.contentsOfDirectory(at: self.cacheDirectory, includingPropertiesForKeys: nil, options: [])
        return urls?.compactMap { $0.deletingPathExtension().lastPathComponent } ?? []
    }
	
	private func urlForKey(_ key: String) -> URL {
		let k = sanitizedKey(key)
		return cacheDirectory
                .appendingPathComponent(k)
                .appendingPathExtension("cache")
	}
	
	private func sanitizedKey(_ key: String) -> String {
		let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9_]+", options: NSRegularExpression.Options())
		let range = NSRange(location: 0, length: key.count)
		return regex.stringByReplacingMatches(in: key, options: NSRegularExpression.MatchingOptions(), range: range, withTemplate: "-")
	}

	private func expiryDateForCacheExpiry(_ expiry: CacheExpiry) -> Foundation.Date {
		switch expiry {
		case .never:
			return Foundation.Date.distantFuture 
		case .seconds(let seconds):
			return Foundation.Date().addingTimeInterval(seconds)
		case .date(let date):
			return date
		}
	}

}
