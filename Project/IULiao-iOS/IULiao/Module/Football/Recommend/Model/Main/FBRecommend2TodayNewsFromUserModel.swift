//
//  FBRecommend2TodayNewsFromUserModel.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/25.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

///推荐 今日推荐 按人找
class FBRecommend2TodayNewsFromUserModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var mid: Int
    
    var userId: Int
    
    var oddsType: RecommendDetailOddsType
    
    var mTime: Int
    
    var match: FBRecommendDetailMatchModel
    
    var user: FBRecommend2UserModel
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        mid = json["mid"].intValue
        userId = json["userid"].intValue
        oddsType = RecommendDetailOddsType(rawValue: json["oddstype"].intValue)!
        mTime = json["mtime"].intValue
        match = FBRecommendDetailMatchModel.init(json: json["match"])
        user = FBRecommend2UserModel.init(json: json["user"])
    }
}

struct FBRecommend2UserModel {
    var userId : Int
    ///昵称
    var nickName : String
    ///头像
    var avatar : String
    ///连赢次数
    var keepWin : Int
    ///竞彩达人称号 0:未获得 1:获得
    var guessHonor :  Int
    ///盈利达人称号 0:未获得 1:获得
    var payOffHonor : Int
    ///关注 人数
    var follow : Int
    ///用户自我评价信息
    var intro: String
    var isAttention: Bool
    ///近10单盈利率
    var order10PayoffPercent: Double
    ///近7天结果
    var day7: String
    
    
    init(json:JSON){
        userId = json["id"].intValue
        nickName = json["nickname"].stringValue
        avatar = json["avatar"].stringValue
        keepWin = json["keepwin"].intValue
        intro = json["intro"].stringValue
        guessHonor = json["jingcaihonor"].intValue
        payOffHonor = json["payoffhonor"].intValue
        follow = json["follow"].intValue
        isAttention = json["isattention"].boolValue
        order10PayoffPercent = json["order10payoffpercent"].doubleValue
        day7 = json["day7"].stringValue
    }
}


