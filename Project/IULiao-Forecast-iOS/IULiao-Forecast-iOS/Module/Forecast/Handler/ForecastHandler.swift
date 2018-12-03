//
//  ForecastHandler.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 专家预测首页
class ForecastHandler:  BaseHandler {
    /// 预测首页数据
    func getForecastData(type: Int, page: Int, success: @escaping (_ model: ForecastModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.forecastAll(type: type, page: page, pageSize: 20)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = ForecastModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 专家个人信息
    func getExpertInfo(userId: Int, success: @escaping (_ infoModel: ForecastExpertModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.forecastExpertDetail(userId: userId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = ForecastExpertModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 专家历史
    func getExpertHistory(userId: Int, page: Int, success: @escaping (_ historyModel: ForecastExpertHistoryModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.forecastExpertHistory(userId: userId, page: page, pageSize: 20)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = ForecastExpertHistoryModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
    
    /// 购买预测
    func postBuyData(forecastId: Int, success: @escaping (_ json: JSON) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.forecastBuy(forecastId: forecastId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
    
    /// 关注
    func postCommentAttentionFollow(userId: Int, success: @escaping (_ json: JSON) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.commonAttentionFollow(userId: userId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
    
    /// 取消关注
    func postCommentAttentionUnFollow(userId: Int, success: @escaping (_ json: JSON) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.commonAttentionUnFollow(userId: userId)
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            success(json)
        }) { (error) -> Bool in
            failed(error)
            return true
        }
    }
    
    /// 预测单场详情
    func getForecastDetail(forecastId: Int, success: @escaping (_ historyModel: ForecastDetailModel) -> Void, failed: @escaping FailedBlock) {
        let route = TSRouter.forecastDetail(forecastId: forecastId)
        defaultRequestManager.requestWithRouter(route, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                let model = ForecastDetailModel(json: json)
                DispatchQueue.main.async {
                    success(model)
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
}
