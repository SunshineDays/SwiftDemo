//
//  StringExt.swift
//  
//
//  Created by tianshui on 15/5/12.
//
//

import Foundation

extension String {
    
    /// MD5 加密操作
    var md5: String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate(capacity: digestLen)
        
        return String(format: hash as String)
    }
    
}

/// subscript
private
extension String {
    
    func validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.encodedOffset : return startIndex
        case endIndex.encodedOffset...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }
    
    func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else {
            return nil
        }
        return validIndex(original:original)
    }
    
    func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else {
            return nil
        }
        return validIndex(original:original)
    }
}

/// subscript string下标截取类似切片
/// 与原生接口相比直接使用数字并且不会发生越界
extension String {
    
    subscript(_ range: Range<Int>) -> String {
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound),
            startIndex < endIndex
            else {
                return ""
        }
        
        return String(self[startIndex..<endIndex])
    }
    
//    subscript(_ range: CountableRange<Int>) -> String {
//        guard
//            let startIndex = validStartIndex(original: range.lowerBound),
//            let endIndex   = validEndIndex(original: range.upperBound),
//            startIndex < endIndex
//            else {
//                return ""
//        }
//
//        return String(self[startIndex..<endIndex])
//    }
    
    subscript(_ range: ClosedRange<Int>) -> String {
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound)
            else {
                return ""
        }
        
        return String(self[startIndex...endIndex])
    }
    
//    subscript(_ range: CountableClosedRange<Int>) -> String {
//        guard
//            let startIndex = validStartIndex(original: range.lowerBound),
//            let endIndex   = validEndIndex(original: range.upperBound)
//            else {
//                return ""
//        }
//        
//        return String(self[startIndex...endIndex])
//    }
    
    subscript(_ range: PartialRangeFrom<Int>) -> String {
        guard let startIndex = validStartIndex(original: range.lowerBound) else {
            return ""
        }
        
        return String(self[startIndex...])
    }
    
//    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
//        guard let startIndex = validStartIndex(original: range.lowerBound) else {
//            return ""
//        }
//        
//        return String(self[startIndex...])
//    }
    
    subscript(_ range: PartialRangeThrough<Int>) -> String {
        guard let endIndex = validEndIndex(original: range.upperBound) else {
            return ""
        }
        
        return String(self[...endIndex])
    }
    
    subscript(_ range: PartialRangeUpTo<Int>) -> String {
        guard
            let endIndex = validEndIndex(original: range.upperBound),
            endIndex > startIndex
            else {
                return ""
        }
        
        return String(self[..<endIndex])
    }
}
