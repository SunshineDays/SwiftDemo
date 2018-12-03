//
//  PiazzaLiveMactHandle.swift
//  IULiao
//
//  Created by levine on 2017/7/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol PiazzaLiveMactHandleDelegate : class {
    
    func liveMatchListHandler(_ handler:PiazzaLiveMactHandle, didFetchDataList listData: FBLiveDataModel, hotDataList hotData: FBLiveMatchModel?, animationUrl url: String?, andBirefList birefList: [PiazzaBirefModel]?, hotLiveMatchType:PiazzaHotMarchType)
    
    func liveMatchListHandler(_ handler: PiazzaLiveMactHandle, didError error: NSError)
}
class PiazzaLiveMactHandle: BaseHandler {

    weak var delegate : PiazzaLiveMactHandleDelegate?
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    func executeFetchMatchList() {
       let router = TSRouter.piazzaList
        defaultRequestManager.requestWithRouter(router, expires: 0)
    }
}
extension PiazzaLiveMactHandle:TSRequestManagerDelegate {
    //
    func requestManager(_ manager: TSRequestManager, didReceiveData json: JSON) {
        //Alamofire 自身异步请求 返回数据 ， 无需在开分线程
        var data = FBLiveDataModel()
        data.allMatchList  = json["livematchlist"].arrayValue.map { FBLiveMatchModel(json: $0) }//尾随闭包
        data.liveNum = json["livenum"].intValue
        // 
        if PiazzaHotMarchType(rawValue: json["hotmatch"]["type"].stringValue) == PiazzaHotMarchType.animation {
            
            delegate?.liveMatchListHandler(self, didFetchDataList: data, hotDataList: FBLiveMatchModel(json: json["hotmatch"]["match"]), animationUrl: json["hotmatch"]["animationurl"].stringValue, andBirefList: nil, hotLiveMatchType: PiazzaHotMarchType.animation)
        }
        else if PiazzaHotMarchType(rawValue: json["hotmatch"]["type"].stringValue) == PiazzaHotMarchType.brief {
            let birefList = json["hotmatch"]["brieflist"].arrayValue.map({ (json) -> PiazzaBirefModel in
                return PiazzaBirefModel(json: json)
            })
            delegate?.liveMatchListHandler(self, didFetchDataList: data, hotDataList: FBLiveMatchModel(json: json["hotmatch"]["match"]), animationUrl: nil, andBirefList: birefList, hotLiveMatchType: PiazzaHotMarchType.brief)
        }else {
            delegate?.liveMatchListHandler(self, didFetchDataList: data, hotDataList: nil, animationUrl: nil, andBirefList: nil, hotLiveMatchType: PiazzaHotMarchType.noMatch)
        }
        
    }
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.liveMatchListHandler(self, didError: error)
        return false
    }
}
