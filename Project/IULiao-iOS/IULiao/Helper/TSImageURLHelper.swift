//
//  TSImageURLHelper.swift
//  HuaXia
//
//  Created by tianshui on 15/10/13.
// 
//

import Foundation
import CoreGraphics

/// 图片url帮助 注意 只适用于 图片服务器的url
class TSImageURLHelper {
    
    /// 裁剪模式
    enum CropModeType: Int {
    
        /// 只缩放 不裁剪
        case none = 0
        
        /// 等比不裁剪
        case onlyResize = 1
        
        /// 总是裁剪
        case alwayCrop = 2
        
        /// 填充裁剪 (建议png的logo使用)
        case fillCrop = 3
    }
        
    private var params: [String: String] = [:]
    private var string: String?
    
    /// 最终图片url string
    var urlString: String {
        guard let string = string else {
            return ""
        }
        if string.isEmpty {
            return ""
        }
        
        var str = string.trimmingCharacters(in: CharacterSet(charactersIn: "?"))
        if params.count > 0 {
            if str.contains("?") {
                str += "&"
            } else {
                str += "?"
            }
            for (key, val) in params {
                str += "\(key)=\(val)&"
            }
        }
        str = str.trimmingCharacters(in: CharacterSet(charactersIn: "&"))
        // 中文字符无法直接生成NSURL
        let allowedSet =  CharacterSet(charactersIn:"`#%^{}\"[]|\\<> ").inverted
        str = str.addingPercentEncoding(withAllowedCharacters: allowedSet) ?? ""
        return str
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
    
    init(string: String?) {
        self.string = string
    }
    
    init(string: String?, w: Int, h: Int) {
        self.string = string
        self.size(w: w, h: h)
    }
    
    convenience init(string: String, size: CGSize) {
        self.init(string: string, w: Int(size.width), h: Int(size.height))
    }
    
    /// 尺寸
    @discardableResult
    func size(w: Int, h: Int) -> TSImageURLHelper {
        params.updateValue("\(w)", forKey: "w")
        params.updateValue("\(h)", forKey: "h")
        return self
    }
    
    /// 尺寸
    func size(_ size: CGSize) -> TSImageURLHelper {
        return self.size(w: Int(size.width), h: Int(size.height))
    }
    
    /// 裁剪
    func chop(mode: CropModeType = .alwayCrop) -> TSImageURLHelper {
        params.updateValue("\(mode.rawValue)", forKey: "crop")
        return self
    }
    
    /// 质量
    func quality(number: Int = 75) -> TSImageURLHelper {
        params.updateValue("\(number)", forKey: "q")
        return self
    }
    
    /// 图片格式
    func format(ofType: String = "jpg") -> TSImageURLHelper {
        params.updateValue(ofType, forKey: "format")
        return self
    }
    
    /// 原始大小
    func originSize() -> TSImageURLHelper {
        params = [:]
        return self
    }
    
    var description: String {
        return urlString
    }
}
