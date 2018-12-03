import Foundation

/// This class is a wrapper around an objects that should be cached to disk.
/// 
/// NOTE: It is currently not possible to use generics with a subclass of NSObject
/// 	 However, NSKeyedArchiver needs a concrete subclass of NSObject to work correctly
class CacheObject : NSObject, NSCoding {
	let value: AnyObject
	let expiryDate: Foundation.Date
	
    /// Designated initializer.
    ///
    /// - parameter value:      An object that should be cached
    /// - parameter expiryDate: The expiry date of the given value
	init(value: AnyObject, expiryDate: Foundation.Date) {
		self.value = value
		self.expiryDate = expiryDate
	}
	
    /// Determines if cached object is expired
    ///
    /// - returns: True If objects expiry date has passed
    func isExpired() -> Bool {
        return expiryDate.isInThePast
    }
	
	
	/// NSCoding

	required init?(coder aDecoder: NSCoder) {
		value = aDecoder.decodeObject(forKey: "value") as AnyObject
		expiryDate = aDecoder.decodeObject(forKey: "expiryDate") as! Foundation.Date

		super.init()
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(value, forKey: "value")
		aCoder.encode(expiryDate, forKey: "expiryDate")
	}
}

extension Foundation.Date {
    var isInThePast: Bool {
        return self.timeIntervalSinceNow < 0
    }
}
