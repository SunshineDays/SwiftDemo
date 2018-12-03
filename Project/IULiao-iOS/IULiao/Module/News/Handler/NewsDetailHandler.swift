//
//  NewsDetailHandler.swift
//  HuaXia
//
//  Created by tianshui on 15/11/23.
//  Copyright © 2015年 fenlanmed. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 资讯详情
class NewsDetailHandler: BaseHandler {

    /// 获取资讯详情
    func executeFetchNewsDetail(_ id: Int, success: @escaping ((NewsModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.newsDetail(newsId: id)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 3600,
            success: {
                (json) -> Void in
                let news = NewsModel(json: json)
                success(news)
            },
            failed: {
                (error) -> Bool in
                failed(error)
                return false
        })
    }
    
}
