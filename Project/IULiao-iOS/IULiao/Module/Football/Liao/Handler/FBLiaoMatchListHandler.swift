//
//  FBLiaoMatchListHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/7/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FBLiaoMatchListHandlerDelegate: class {
    
    func liaoMatchListHandler(_ handler: FBLiaoMatchListHandler, didFetchedData data: FBLiaoDataModel)
    
    func liaoMatchListHandler(_ handler: FBLiaoMatchListHandler, didError error: NSError)
}

/// 足球料对阵列表
class FBLiaoMatchListHandler: BaseHandler {
    
    weak var delegate: FBLiaoMatchListHandlerDelegate?
    
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    
    func executeFetchMatchList(_ issue: String? = nil) {
        let router = TSRouter.fbLiaoMatchList(issue: issue)
        defaultRequestManager.requestWithRouter(router, expires: 120)
    }
}

extension FBLiaoMatchListHandler: TSRequestManagerDelegate {
    
    func requestManager(_ manager: TSRequestManager, didReceiveData json: SwiftyJSON.JSON) {
        
        DispatchQueue.global().async {
            [weak self] in
            
            guard let me = self else {
                return
            }
            
            var data = FBLiaoDataModel()
            var matchList = [FBMatchModel]()
            var briefDict = [Int: [FBLiaoBriefModel]]()
            
            for matchJson in json["matchs"].arrayValue {
                let match = FBMatchModel(json: matchJson)
                let briefList = matchJson["brieflist"].arrayValue.map { FBLiaoBriefModel(json: $0) }
                matchList.append(match)
                briefDict[match.mid] = briefList
            }
            
            data.allMatchList = matchList
            data.briefDict = briefDict
            
            data.leagueList = json["leagues"].arrayValue.map { FBLiveLeagueModel(json: $0) }
            data.issueList  = json["issues"].arrayValue.map { $0.stringValue }
            data.currentIssue = json["currentissue"].stringValue
            data.selectIssue  = json["selectissue"].stringValue
            
            DispatchQueue.main.async(execute: {
                me.delegate?.liaoMatchListHandler(me, didFetchedData: data)
            })
        }
        
    }
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.liaoMatchListHandler(self, didError: error)
        return false
    }
}
