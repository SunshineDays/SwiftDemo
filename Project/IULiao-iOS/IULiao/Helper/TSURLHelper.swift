//
//  TSURLHelper.swift
//  HuaXia
//
//  Created by tianshui on 16/3/10.
// 
//

import Foundation

/// 网站以及app链接
class TSURLHelper: NSObject {



    /**
     构建一个app url
     - parameter path:      路径
     - parameter paramters: 参数
     - returns:
     */
    static func appURLString(_ path: String, paramters: [String: AnyObject?]?) -> String {
        var url = "iuliao://iuliao.com/\(path)"
        
        guard let paramters = paramters else {
            return url
        }
        url += "?"
        for (key, val) in paramters {
            if let val = val {
                url += "\(key)=\(val)"
            }
        }
        return url.trimmingCharacters(in: CharacterSet(charactersIn: "?"))
    }
    
    /// 网站的链接转为app内链接
    static func webURLToAppURL(_ webURL: String) -> String? {
        
        if webURL.isEmpty {
            return nil
        }
    
        func replace(_ string: String, pattern: String, withTemplate: String) -> String {
            let range = NSMakeRange(0, string.count)
            let regexp = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regexp.stringByReplacingMatches(in: string, options: .reportProgress, range: range, withTemplate: withTemplate)
        }
        
        var appURL = webURL
        
        // 资讯
        do {
            // 替换news等链接 href="http://www.iuliao.com/article/4641.html" 结果变为 news://4641
            let pattern = "^https?://(www|m)\\.iuliao\\.\\w+/news/(\\d+)(\\.html)?$"
            appURL = replace(appURL, pattern: pattern, withTemplate: "iuliao://iuliao.com/news?id=$2")
        }
        
        // 相同欧赔,亚盘
        do {
            let pattern = "^https?://m\\.iuliao\\.\\w+/single/football2/(\\d+)/(sameasia|sameeurope)\\?cid=(\\d+)"
            appURL = replace(appURL, pattern: pattern, withTemplate: "iuliao://iuliao.com/$2?mid=$1&cid=$3")
        }
        
        // 赔率历史
        do {
            let pattern = "^https?://m\\.iuliao\\.\\w+/single/football2/oddshistory1/(\\d+)\\?cid=(\\d+)&type=(\\w+)"
            appURL = replace(appURL, pattern: pattern, withTemplate: "iuliao://iuliao.com/oddshistory?mid=$1&cid=$2&type=$3")
        }
        
        return appURL

    }
    
    /// appURL(news://1100)链接转ViewController
    static func appURLToViewController(_ appURLString: String) -> UIViewController? {
        
        guard let appURL = URL(string: appURLString) else {
            return nil
        }
        // 删除 path 字符 前后的"/"（字符串中间的"/"保留）
        let path = appURL.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))


        // 存储 URL参数的字典
        let queryDict = appURL.querys ?? [:]
        
        var ctrl: UIViewController? = nil
        
        switch path {
        case "news":
            if let id = Int(queryDict["id"] ?? "") {
                ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: id)
            }

        default:
            ctrl = nil
        }
        
        return ctrl
    }
    
    /// 网站链接转viewcontroller 无对应时候会跳到浏览器
    static func webURLToViewController(_ webURL: String) -> UIViewController? {
        
        if webURL.isEmpty {
            return nil
        }
        
        if let appURL = webURLToAppURL(webURL) {
            return appURLToViewController(appURL)
        }
        
        if let url = URL(zhString: webURL) {
            let ctrl = BaseWebBrowserController()
            ctrl.url = url
            return ctrl
        }
        
        return nil
    }
    
    /// 任意链接转为viewcontroller
    static func urlToViewController(_ url: String) -> UIViewController? {
        if let appCtrl = appURLToViewController(url) {
            return appCtrl
        } else if let webCtrl = webURLToViewController(url) {
            return webCtrl
        }
        return nil
    }
}
