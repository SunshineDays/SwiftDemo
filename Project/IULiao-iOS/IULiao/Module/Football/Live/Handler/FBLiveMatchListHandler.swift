//
//  FBLiveMatchListHandler.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FBLiveMatchListHandlerDelegate: class {
    
    func liveMatchListHandler(_ handler: FBLiveMatchListHandler, didFetchedData data: FBLiveDataModel2)
    
    func liveMatchListHandler(_ handler: FBLiveMatchListHandler, didError error: NSError)
}

/// 足球比分对阵列表
class FBLiveMatchListHandler: BaseHandler {
    
    weak var delegate: FBLiveMatchListHandlerDelegate?
    
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    
    func executeFetchMatchList(_ issue: String? = nil, lottery: Lottery? = nil) {
        let router = TSRouter.fbLiveMatchList(issue: issue, lottery: lottery)
        defaultRequestManager.requestWithRouter(router, expires: 60)
    }
}

extension FBLiveMatchListHandler: TSRequestManagerDelegate {
    
    func requestManager(_ manager: TSRequestManager, didReceiveData json: SwiftyJSON.JSON) {
        
        DispatchQueue.global().async {
            [weak self] in
            
            guard let me = self else {
                return
            }

            var data = FBLiveDataModel2()
            data.allMatchList  = json["matchs"].arrayValue.map { FBLiveMatchModel2(json: $0) }
            data.leagueList = json["leagues"].arrayValue.map { FBLiveLeagueModel(json: $0) }
            
            data.issueList  = json["issues"].arrayValue.map { $0.stringValue }
            data.currentIssue = json["currentissue"].stringValue
            data.selectIssue  = json["selectissue"].stringValue
            data.liveNum      = json["livenum"].intValue
            data.lottery      = Lottery(lotyid: json["lotyid"].intValue)
            
            DispatchQueue.main.async(execute: {
                me.delegate?.liveMatchListHandler(me, didFetchedData: data)
            })
        }
        
    }
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.liveMatchListHandler(self, didError: error)
        return false
    }
}
