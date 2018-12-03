//
//  NewsTopHandler.swift
//  HuaXia
//
//  Created by tianshui on 15/11/23.
//  Copyright © 2015年 fenlanmed. All rights reserved.
//

import SwiftyJSON

protocol NewsTopHandlerDelegate: class {
    func newsTopHandler(_ handler: NewsTopHandler, didFetchedList list: [NewsModel])
    
    func newsTopHandler(_ handler: NewsTopHandler, didError error: NSError)
}

extension NewsTopHandlerDelegate {
    func newsTopHandler(_ handler: NewsTopHandler, didError error: NSError) {
        
    }
}

/// 资讯焦点图
class NewsTopHandler: BaseHandler {
    
    weak var delegate: NewsTopHandlerDelegate?
    
    /// 获取资讯详情  服务器交互
    func executeFetchNewsTop(_ success: (([NewsModel]) -> Void)? = nil, failed: FailedBlock? = nil) {
        let router = TSRouter.newsTopList(limit: 6)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 600,
            success: {
                (json) -> Void in
                
                var list = [NewsModel]()
                
                for newsJson in json.arrayValue {
                    list.append(NewsModel(json: newsJson))
                }
                if let success = success {
                    success(list)
                } else {
                    self.delegate?.newsTopHandler(self, didFetchedList: list)
                }
            },
            failed: {
                (error) -> Bool in
                if let failed = failed {
                    failed(error)
                } else {
                    self.delegate?.newsTopHandler(self, didError: error)
                }
                return false
        })
    }
    
}
