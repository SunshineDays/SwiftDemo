//
//  TodayRecommendModel.swift
//  IULiao
//
//  Created by levine on 2017/8/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
//今日最新列表
struct FBRecommendTodayNewsModel: BaseModelProtocol {

    var json: JSON
    
    var id: Int//
    
    var mid: String//
    
    var userId: Int//
    
    var oddsType: OddStype//玩法类型
    
    var beton: String//投注项	  ：输赢
    
    var betodds: String//	投注赔率
    
    var reason: String//	推荐理由
    
    var resultType: GuessResultType// 推荐结果 0:比赛未开始 1:输 2:输半 3:走 4:赢半 5:赢
    
    var expertOdd: ExpertHistoryOdds //专家历时推荐用到的参数
    
    var pollup: String//赞总数
    
    var polldown: String//踩总数
    
    var isShow: String//
    
   // var created:TimeInterval
    //创建时间
    var created: String? {
        let created = self.json["created"].doubleValue
        if created <= 0 {
            return nil
        }
        return TSUtils.timesAftertampToString(created,isIntelligent: false)
    }
    
    var day7:String//最近7天发单情况
    
    var user : FBRecommendUserModel
    var match:FBLiveMatchModel//赛事信息
    init(json:JSON) {
        
        self.json = json
        
        id = json["id"].intValue
        mid  = json["mid"].stringValue
        userId = json["userid"].intValue
        oddsType = OddStype(rawValue: json["oddstype"].intValue)
        beton = json["beton"].stringValue
        betodds = json["betodds"].stringValue
        reason = json["reason"].stringValue
        resultType = GuessResultType(rawValue: json["result"].intValue)
        
        //专家历时推荐用到的参数
        expertOdd = ExpertHistoryOdds(json: json["odds"])
        
        pollup = json["pollup"].stringValue
        polldown = json["polldown"].stringValue
        isShow = json["isshow"].stringValue
        day7 = json["day7"].stringValue
        user = FBRecommendUserModel(json: json["user"])
        match = FBLiveMatchModel(json: json["match"])
    }
}
struct FBRecommendUserModel {
    var userId : Int
    var nickName : String//昵称
    var avatar : String //头像
    var keepWin : Int//连赢次数
    var guessHonor :  Int//竞彩达人称号 0:未获得 1:获得
    var payOffHonor : Int//盈利达人称号 0:未获得 1:获得
    var follow : Int //关注 人数
    var intro: String //用户自我评价信息
    var isAttention: Bool
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

    }
}
struct ExpertHistoryOdds {
    var letBall : String//让球
    var win : String//赢
    var draw : String //走
    var lost : String//输
  

    init(json:JSON){
        letBall = json["letball"].stringValue
        win = json["win"].stringValue
        draw = json["draw"].stringValue
        lost = json["lost"].stringValue
    }

}
//玩法类型 赔率
enum OddStype: Int {
    case all = 0 //全部类型
    case asiaPlate = 3  //亚盘
    case bigSmallPlate = 4   //  大小盘
    case europe = 5  // 欧赔
    case guess = 11  //竞彩(包含1&2)
    case unknow //未知结果
    init(rawValue:Int) {
        switch rawValue {
        case 0: self = .all
        case 3: self = .asiaPlate
        case 4: self = .bigSmallPlate
        case 5: self = .europe
        case 11: self = .guess
        default:
            self = .unknow
        }
    }
    var oddsName: String {
        switch self {
        case .all: return "全部玩法"
        case .asiaPlate: return "亚盘"
        case .bigSmallPlate: return "大小球"
        case .europe: return "欧赔"
        case .guess: return "竞彩"
        case .unknow: return "未知"
        }
    }
    var oddsColor: UIColor {
        switch self {
        case .all: return UIColor(r: 255, g: 151, b: 75)
        case .asiaPlate: return UIColor(r: 255, g: 151, b: 75)
        case .bigSmallPlate: return UIColor(r: 74, g: 189, b: 255)
        case .europe: return UIColor(r: 235, g: 111, b: 98)
        case .guess: return UIColor(r: 255, g: 96, b: 75)
        case .unknow: return UIColor(r: 255, g: 96, b: 75)
        }
    }
}
//竞猜结果
enum GuessResultType: Int {
    case noOpen = 0// 未开
    case lost = 1 // 输
    case lostHalf = 2// 输半
    case draw = 3 //走
    case winHalf = 4// 赢半
    case win = 5// 赢
    case unknow = 6 // 未知
    init(rawValue: Int)  {
        switch rawValue {
        case 0: self = .noOpen
        case 1: self = .lost
        case 2: self = .lostHalf
        case 3: self = .draw
        case 4: self = .winHalf
        case 5: self = .win
        default: self = .unknow
      }
    }
    var jingCaiImage: UIImage {
        switch self {
        case .noOpen: return R.image.fbRecommend.jingcaihonorHistorywin()!
            
        case .win: return R.image.fbRecommend.jingcaihonorHistorywin()!
            
        case .draw: return R.image.fbRecommend.jingcaihonorHistorydraw()!
            
        case .lost:  return R.image.fbRecommend.jingcaihonorHistorylost()!
           
        case .winHalf: return R.image.fbRecommend.jingcaihonorHistoryWinhalf()!
            
        case .lostHalf: return R.image.fbRecommend.jingcaihonorHistorylosthalf()!
            
        case .unknow: return R.image.fbRecommend.jingcaihonorHistorylosthalf()!
      }
      
    }
}
enum RankType: String {
    case keepWin = "keepwin"
    case keepLost = "keeplost"
    case newBest = "newbest"
    case payOff = "payoff"
}



enum OddsTypeString: String {
    case letWin = "letwin"
    case letDraw = "letdraw"
    case letLost = "letlost"
    case win = "win"
    case draw = "draw"
    case lost = "lost"
    case above = "above"
    case below = "below"
    case big = "big"
    case small = "small"
}

