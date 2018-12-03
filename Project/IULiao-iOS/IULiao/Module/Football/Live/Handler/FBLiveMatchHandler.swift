//
//  FBLiveMatchHandler.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FBLiveMatchHandlerDelegate: class {
    
    func liveMatchHandler(_ handler: FBLiveMatchHandler, didFetchedData data: FBLiveDataModel2)
    
    func liveMatchHandler(_ handler: FBLiveMatchHandler, didError error: NSError)
}

/// 足球比分对阵列表
class FBLiveMatchHandler: BaseHandler {

    weak var delegate: FBLiveMatchHandlerDelegate?

    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }

    /// 对阵列表
    func getMatchList(issue: String? = nil, lottery: Lottery? = nil) {
        let router = TSRouter.fbLiveMatchList2(issue: issue, lottery: lottery)
        defaultRequestManager.requestWithRouter(router)
    }

    /// 关注列表
    func getAttentionList() {
        let router = TSRouter.fbLiveAttentionList
        defaultRequestManager.requestWithRouter(router)
    }
    

    func getMatchDetail(success: @escaping (FBRecommendModel2) -> Void, failed: @escaping FailedBlock) {
        
    }
}

extension FBLiveMatchHandler: TSRequestManagerDelegate {
    
    func requestManager(_ manager: TSRequestManager, didReceiveData json: SwiftyJSON.JSON) {
        
        DispatchQueue.global().async {
            [weak self] in
            
            guard let me = self else {
                return
            }

            var data = FBLiveDataModel2()
            data.serverTime   = json["server_time"].doubleValue
            data.serverTimeGap = Date().timeInterval - data.serverTime
            data.allMatchList  = json["matchs"].arrayValue.map { FBLiveMatchModel2(json: $0) }
            data.leagueList = json["leagues"].arrayValue.map { FBLiveLeagueModel(json: $0) }
            
            data.issueList  = json["issues"].arrayValue.map { $0.stringValue }
            data.currentIssue = json["current_issue"].stringValue
            data.selectIssue  = json["select_issue"].stringValue
            data.liveNum      = json["live_num"].intValue
            data.lottery      = Lottery(lotyid: json["lotyid"].intValue)
            
            DispatchQueue.main.async(execute: {
                me.delegate?.liveMatchHandler(me, didFetchedData: data)
            })
        }
        
    }
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.liveMatchHandler(self, didError: error)
        return true
    }
}
