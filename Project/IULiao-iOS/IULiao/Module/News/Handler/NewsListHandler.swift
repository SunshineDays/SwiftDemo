//
//  NewsListHandler.swift
//  HuaXia
//
//  Created by tianshui on 15/11/23.
//  Copyright © 2015年 fenlanmed. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol NewsListHandlerDelegate: class {
    func newsListHandler(_ handler: NewsListHandler, didFetchedList list: [NewsModel], andPageInfo pageInfo: TSPageInfoModel)
    
    func newsListHandler(_ handler: NewsListHandler, didError error: NSError)
}

/// 新闻列表页
class NewsListHandler: BaseHandler {
    
    weak var delegate: NewsListHandlerDelegate?
    
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    //执行网路请求
    func executeFetchNewsList(page: Int, pageSize: Int, taxonomyId:Int?, sport:Int?) {
        let router = TSRouter.newsList(taxonomyId: taxonomyId, sport: sport, page: page, pageSize: pageSize)
        if page < 3 {
            defaultRequestManager.requestWithRouter(router, expires: 0)
        } else {
            defaultRequestManager.requestWithRouter(router, expires: 600)
        }
    }
    
    /// 搜索会议列表
    func searchNewsListWithKeyword(_ keyword: String, type: NewsSearchType, page: Int, pageSize: Int) {
        let router = TSRouter.newsSearch(keyword: keyword, type: type, page: page, pageSize: pageSize)
        cancel()
        defaultRequestManager.requestWithRouter(router, expires: 600)
    }
}


extension NewsListHandler: TSRequestManagerDelegate {
    
    func requestManager(_ manager: TSRequestManager, didReceiveData json: SwiftyJSON.JSON) {
        var list = [NewsModel]()
        for subJson in json["list"].arrayValue {
            let obj = NewsModel(json: subJson)
            list.append(obj)
        }
        let pageInfo = TSPageInfoModel(json: json["pageinfo"])
        self.delegate?.newsListHandler(self, didFetchedList: list, andPageInfo: pageInfo)
    }
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        self.delegate?.newsListHandler(self, didError: error)
        return false
    }
}
