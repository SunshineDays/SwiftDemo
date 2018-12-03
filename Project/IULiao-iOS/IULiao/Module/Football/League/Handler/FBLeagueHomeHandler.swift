//
//  FBLeagueHomeHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol FBLeagueHomeHandlerDelegate: class {
    
    func leagueHomeHandler(_ handler: FBLeagueHomeHandler, didFetchedData data: FBLeagueHomeDataModel)
    
    func leagueHomeHandler(_ handler: FBLeagueHomeHandler, didError error: NSError)
}

/// 资料库首页
class FBLeagueHomeHandler: BaseHandler {
    
    weak var delegate: FBLeagueHomeHandlerDelegate?
    
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    
    /// 获取首页数据
    func getHomeData() {
        let router = TSRouter.fbLeagueCountryList
        defaultRequestManager.requestWithRouter(router, expires: 7200)
    }
    
}

extension FBLeagueHomeHandler: TSRequestManagerDelegate {
    
    func requestManager(_ manager: TSRequestManager, didReceiveData json: JSON) {
        DispatchQueue.global().async {
            [weak self] in
            
            guard let me = self else {
                return
            }
            let data = FBLeagueHomeDataModel(json: json)
            
            DispatchQueue.main.async {
                me.delegate?.leagueHomeHandler(me, didFetchedData: data)
            }
        }
    }
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.leagueHomeHandler(self, didError: error)
        return false
    }
}
