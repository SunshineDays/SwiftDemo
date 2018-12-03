//
//  FBRecommend2Model.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/26.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

class FBRecommend2Model: NSObject {

}

/// 亚盘
class FBRecommend2AsianPlateModel: BaseModelProtocol {
    var json: JSON
    var type: String
    var bet : String
    /// 主胜
    var above: Double
    /// 平
    var handicap: String //大小球/亚盘
    /// 客负
    var below: Double
    /// 让球数
    var letBall: Int
    
    required init(json: JSON) {
        self.json = json
        type = json["type"].stringValue
        bet = json["bet"].stringValue
        above = json["above"].doubleValue
        handicap = json["handicap"].stringValue
        below = json["below"].doubleValue
        letBall = json["letball"].intValue
    }
}

/// 大小球
class FBRecommend2SizePlateModel: BaseModelProtocol {
    var json: JSON
    var type: String
    var bet : String
    /// 大球
    var big: Double
    /// 平
    var handicap: String
    /// 小球
    var small: Double
    /// 让球数
    var letBall: Int
    
    required init(json: JSON) {
        self.json = json
        bet = json["bet"].stringValue
        type = json["type"].stringValue
        big = json["big"].doubleValue
        handicap = json["handicap"].stringValue
        small = json["small"].doubleValue
        letBall = json["letball"].intValue
    }
}

/// 欧赔
class FBRecommend2EuropeModel: BaseModelProtocol {
    var json: JSON
    var type: String
    var bet : String
    /// 赢
    var win: Double
    /// 走
    var draw: Double
    /// 输
    var lost: Double
    /// 让球数
    var letBall: Int
    
    required init(json: JSON) {
        self.json = json
        bet = json["bet"].stringValue
        type = json["type"].stringValue
        win = json["win"].doubleValue
        draw = json["draw"].doubleValue
        lost = json["lost"].doubleValue
        letBall = json["letball"].intValue
    }
}

/// 竞彩
class FBRecommend2JingCaiModel: BaseModelProtocol {
    var json: JSON
    var type: String
    var bet : String
    /// 让胜
    var letWin: Double
    /// 让平
    var letDraw: String
    /// 让负
    var letLost: Double
    /// 让球数
    var letBall: Int
    
    required init(json: JSON) {
        self.json = json
        bet = json["bet"].stringValue
        type = json["type"].stringValue
        letWin = json["letwin"].doubleValue
        letDraw = json["letdraw"].stringValue
        letLost = json["letlost"].doubleValue
        letBall = json["letball"].intValue
    }
}


