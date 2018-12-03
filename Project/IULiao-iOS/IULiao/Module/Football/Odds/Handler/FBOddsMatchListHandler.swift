//
//  FBOddsMatchListHandler.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FBOddsMatchListHandlerDelegate: class {
    
    func oddsMatchListHandler(_ handler: FBOddsMatchListHandler, didFetchedData data: FBOddsDataModel)
    
    func oddsMatchListHandler(_ handler: FBOddsMatchListHandler, didError error: NSError)
}

/// 足球比分对阵列表
class FBOddsMatchListHandler: BaseHandler {
    
    weak var delegate: FBOddsMatchListHandlerDelegate?
    
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    
    func executeFetchMatchList(_ issue: String? = nil, lottery: Lottery? = nil) {
        let router = TSRouter.fbOddsMatchList(issue: issue, lottery: lottery)
        defaultRequestManager.requestWithRouter(router, expires: 120)
    }
}

extension FBOddsMatchListHandler: TSRequestManagerDelegate {
    
    func requestManager(_ manager: TSRequestManager, didReceiveData json: SwiftyJSON.JSON) {
        
        DispatchQueue.global().async {
            [weak self] in
            
            guard let me = self else {
                return
            }

            var data = FBOddsDataModel()
            data.allMatchList  = json["matchs"].arrayValue.map { FBOddsMatchModel(json: $0) }
            data.leagueList = json["leagues"].arrayValue.map { FBLiveLeagueModel(json: $0) }
            
            data.issueList  = json["issues"].arrayValue.map { $0.stringValue }
            data.currentIssue = json["currentissue"].stringValue
            data.selectIssue  = json["selectissue"].stringValue
            data.lottery      = Lottery(lotyid: json["lotyid"].intValue)

            DispatchQueue.main.async(execute: {
                me.delegate?.oddsMatchListHandler(me, didFetchedData: data)
            })
        }
        
    }
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.oddsMatchListHandler(self, didError: error)
        return false
    }
}
