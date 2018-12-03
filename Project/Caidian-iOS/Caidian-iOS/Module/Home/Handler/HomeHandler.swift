//
//  HomeHandler.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/23.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeHandler: BaseHandler {
    

    ///新闻列表
    func getNewsList(categoryId: Int?, page: Int, pageSize: Int, success: @escaping ((_ data: HomeNewsListModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.newsList(categoryId: categoryId, page: page, pageSize: pageSize)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    DispatchQueue.global().async {
                        let list = json["list"].arrayValue.map {
                            subJson in
                            return NewsModel(json: subJson)
                        }
                        let pageInfo = PageInfoModel(json: json["page_info"])
                        var data = HomeNewsListModel()
                        data.list = list
                        data.pageInfo = pageInfo
                        DispatchQueue.main.async {
                            success(data)
                        }
                    }
                },
                failed: {
                    error in
                    failed(error)
                    return false
                })
    }

    ///彩种接口和轮播图
    func getMainHome(success: @escaping((_ data: HomeMainModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.mainHome
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    DispatchQueue.global().async {
                        let model = HomeMainModel(json: json)
//                        let topicList = json["topic_list"].arrayValue.map {
//                            return NewsModel(json: $0)
//                        }
//                        let noticeList = json["notice_list"].arrayValue.map {
//                            return NewsModel(json: $0)
//                        }
//                        let lotterySale = LotterySaleModel(json: json["lottery_sale"])
//                        let newsBonusList = json["new_bonus_list"].arrayValue.map {  NewsBonusCellModel(json: $0)  }
//                        var data = HomeMainModel()
//                        data.topicList = topicList
//                        data.lotterySale = lotterySale
//                        data.noticeList = noticeList
//                        data.newsBonusList = newsBonusList
                        DispatchQueue.main.async {
                            success(model)
                        }
                    }
                },
                failed: {
                    error in
                    failed(error)
                    return false
                })
    }

    /// 竞彩单关列表
    func getJcSingleMatchList(success: @escaping((_ matchList: [JczqMatchModel]) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.saleJcspfSingleMatchList
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    let matchList = json["list"].arrayValue.map {
                        return JczqMatchModel(json: $0)
                    }
                    success(matchList)
                },
                failed: {
                    error in
                    failed(error)
                    return false
                })
    }

    /// 今日热单
    func getCopyHotOrderList(page: Int, pageSize: Int, success: @escaping ((_ copyOrderList: [CopyOrderModel], _ pageInfo: TSPageInfoModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.copyHotOrderList(page: page, pageSize: pageSize)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    let copyOrderList = json["list"].arrayValue.map {
                        return CopyOrderModel(json: $0)
                    }
                    let pageInfo = TSPageInfoModel(json: json["page_info"])
                    success(copyOrderList, pageInfo)
                },
                failed: {
                    error in
                    return false
                })

    }
    
    ///新闻详情
    func detail(newsId: Int, success: @escaping ((_ newsDetailModel: HomeNewsDetailModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.newsDetail(newsId: newsId)
        defaultRequestManager.request(
            router: router,
            expires: 0,
            success: {
                json in
                success(HomeNewsDetailModel(json: json))
        },
            failed: {
                error in
                failed(error)
                return false
        })
    }
}
