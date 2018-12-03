//
//  FBRecommendPostMatchDetialModel.swift
//  IULiao
//
//  Created by levine on 2017/8/23.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
//发起推荐详情
struct FBRecommendPostMatchDetialModel: BaseModelProtocol {
    var json: JSON
    
    var match: FBLiveMatchModel//赛事
    
    var jc: FBRecommendPostDetialJCModel//竞彩
    
    var asia: FBRecommendPostDetialAsiaModel//亚盘
    
    var daxiao: FBRecommendPostDetialDXModel//大小盘
    
    init(json: JSON) {
        self.json = json
        match = FBLiveMatchModel(json: json["match"])
        
        jc = FBRecommendPostDetialJCModel(json: json["jc"])
        
        asia = FBRecommendPostDetialAsiaModel(json: json["asia"])
        
        daxiao = FBRecommendPostDetialDXModel(json: json["daxiao"])
    }

}
//竞彩
struct FBRecommendPostDetialJCModel {
    var win: Float//
    
    var draw: Float//
    
    var lost: Float//
    
    var letWin: Float//
    
    var letDraw: Float//
    
    var letLost: Float//
    
    var letBall: Int//
    
    var openSale: OpenSaleType//竞彩开售 1:非让 2:让球 3:非让和让

    init(json: JSON) {
        
         win = json["win"].floatValue//
        
         draw = json["draw"].floatValue//
        
         lost = json["lost"].floatValue//
        
         letWin = json["letwin"].floatValue//玩法类型
        
         letDraw = json["letdraw"].floatValue//
        
         letLost = json["letlost"].floatValue//
        
         letBall = json["letball"].intValue//
        
         openSale = OpenSaleType(rawValue: json["opensale"].intValue) //
        
    }
}
//亚盘
struct FBRecommendPostDetialAsiaModel {
    var above: Float//
    
    var bet: Float//赔率
    
    var below: Float//
    
    var type: String//玩法类型
    
    var handicap: String//描述

    init(json: JSON) {
        above = json["above"].floatValue
        
        bet = json["bet"].floatValue
        
        below = json["below"].floatValue
        
        type = json["type"].stringValue
        
        handicap = json["handicap"].stringValue
    }
}
//大小盘
struct FBRecommendPostDetialDXModel {
    var small: Float//
    
    var bet: Float//
    
    var big: Float//
    
    var handicap: String//

    init(json: JSON) {
        small = json["small"].floatValue
        
        bet = json["bet"].floatValue
        
        big = json["big"].floatValue
        
        handicap = json["handicap"].stringValue
    }
}
//竞猜结果
enum OpenSaleType: Int {

    case noLetBall = 1 //输
    case letBall = 2//输半
    case all = 3//走
    case unknow //未知结果
    init(rawValue:Int) {
        switch rawValue {
        case 1: self = .noLetBall
        case 2: self = .letBall
        case 3: self = .all
        default:
            self = .unknow
        }
    }

}
