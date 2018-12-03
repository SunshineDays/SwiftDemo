//
//  FBLiveSettingModel.swift
//  IULiao
//
//  Created by DaiZhengChuan on 2018/5/16.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 推送设置
class FBLiveSettingModel: BaseModelProtocol {
    var json: JSON
    
    var liveStart: Int
    
    var liveHalf: Int
    
    var liveOver: Int
    
    var liveGoal: Int
    
    var liveRed: Int
    
    required init(json: JSON) {
        self.json = json
        liveStart = json["live_start"].intValue
        liveHalf = json["live_half"].intValue
        liveOver = json["live_over"].intValue
        liveGoal = json["live_goal"].intValue
        liveRed = json["live_red"].intValue
    }
    
}


class FBLiveSettingLocalModel: NSObject {
    
    var goal = GoalModel()
    
    var content = ContentModel()
    
    struct GoalModel {
        ///声音
        var sound = true
        ///震动
        var shake =  false
    }
    
    struct ContentModel {
        ///红牌
        var red =  true
        ///黄牌
        var yellow = true
        ///爆料信息
        var liao = true
        ///赛中信息
        var show = true
    }
}

