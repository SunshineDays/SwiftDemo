//
//  URLExt.swift
//  HuaXia
//
//  Created by tianshui on 16/3/1.
// 
//

import Foundation

extension URL {
    
    /// 包含中文字符串的String
    init?(zhString: String) {
        let allowedSet =  CharacterSet(charactersIn:"`#%^{}\"[]|\\<> ").inverted
        let str = zhString.addingPercentEncoding(withAllowedCharacters: allowedSet) ?? ""
        self.init(string: str)
    }
    
    /// 查询字典
    var querys: [String: String]? {
        guard let queryString = query else {
            return nil
        }
        var result: [String: String] = [:]
        //分割 Url参数
        let querys = queryString.components(separatedBy: "&")
        
        for q in querys {
            if q.isEmpty {
                continue
            }
            let pairs = q.components(separatedBy: "=")
            let key = pairs.first!
            let value = pairs.count == 2 ? pairs[1] : ""
            result.updateValue(value, forKey: key)
        }
        return result
    }
        
    
}
