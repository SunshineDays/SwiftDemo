//
//  FBLiveMsgModel.swift
//  IULiao
//
//  Created by tianshui on 16/8/2.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 比分消息
struct FBLiveMsgModel: BaseModelProtocol {
    
    var json: JSON
    
    var matchList: [FBLiveMatchModel2]
    
    var nextLiveNum: Int
    
    var refreshFlag: Int
    
    init(json: JSON) {
        self.json = json
        matchList = json["matchs"].arrayValue.map { FBLiveMatchModel2(json: $0) }
      //  matchList = json["matchs_test"].arrayValue.map { FBLiveMatchModel2(json: $0) }
        nextLiveNum = json["livenum"].intValue
        refreshFlag = json["refresh"].intValue
    }
    
}

func ==(lhs: FBLiveMsgModel, rhs: FBLiveMsgModel) -> Bool {
    return lhs.json == rhs.json
}

func !=(lhs: FBLiveMsgModel, rhs: FBLiveMsgModel) -> Bool {
    return !(lhs == rhs)
}
