//
//  ForecastDetailModel.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 专家预测详情
class ForecastDetailModel: BaseModelProtocol {
    
    var json: JSON
    
    var user: ForecastExpertUserModel
    
    var forecast: ForecastDetailForecastModel
    /// 赛事对阵
    var detailList = [ForecastMatchModel]()
    
    var order: ForecastOrderModel?
    
    required init(json: JSON) {
        self.json = json
        user = ForecastExpertUserModel(json: json["user"])
        forecast = ForecastDetailForecastModel(json: json["forecast"])
        detailList = json["detail_list"].arrayValue.map({ return ForecastMatchModel(json: $0) })
        order = ForecastOrderModel(json: json["order"])
    }
}

/// 专家预测帖子信息
class ForecastDetailForecastModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var userId: Int
    
    var title: String
    /// 本预测总场次
    var num: Int
    /// 命中场次
    var winNum: Int
    /// 定价
    var price: Double
    /// 折扣后价格
    var discount: Double
    /// 命中情况
    var winStatus: ForecastResultType
    /// 销售截止时间
    var saleEndTime: TimeInterval
    /// 收费类型
    var chargeType: ForecastChargeType
    
    var createTime: TimeInterval
    /// 点击数
    var hit: Int
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        userId = json["user_id"].intValue
        title = json["title"].stringValue
        num = json["num"].intValue
        winNum = json["win_num"].intValue
        price = json["price"].doubleValue
        discount = json["discount"].doubleValue
        winStatus = ForecastResultType(rawValue: json["win_status"].intValue) ?? .notOpen
        saleEndTime = json["sale_end_time"].doubleValue
        chargeType = ForecastChargeType(rawValue: json["charge_type"].intValue) ?? .lostWithDraw
        createTime = json["create_time"].doubleValue
        hit = json["hit"].intValue
    }
    
    
}

/// 专家预测球队对阵信息
class ForecastMatchModel: BaseModelProtocol {
    
    var json: JSON
    
    var id: Int
    
    var mid: Int
    
    var forecastId: Int
    
    /// 投注内容
    var beton = [JczqBetonModel]()
    
    var reason: String
    /// 是否是胆
    var isMustBet: Bool
    /// 预测结果
    var result: ForecastResultType
    
    var xid: Int
    /// 联赛名
    var leagueName: String
    /// 主队
    var home: String
    var homeLogo: String
    /// 客队
    var away: String
    var awayLogo: String
    /// 比赛时间
    var matchTime: Double
    /// 让球数
    var letBall: Int
    /// 联赛名字体颜色
    var color: String
    /// 总比分
    var score: String
    
    /// 比赛期号
    var serial: String
    /// 胜平负是否开了
    var isSpfFixed: Bool
    /// 让球胜平负是否开了
    var isRqspfFixed: Bool
    
    var spfSingle: Int
    
    var rqspfSingle: Int

    var spfSp3: Double
    
    var spfSp1: Double
    
    var spfSp0: Double
    
    var rqspfSp3: Double
    
    var rqspfSp1: Double
    
    var rqspfSp0: Double
    
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        mid = json["mid"].intValue
        forecastId = json["forecast_id"].intValue
        beton = json["beton"].arrayValue.map({ return JczqBetonModel(json: $0) })
        reason = json["reason"].stringValue
        isMustBet = json["must_bet"].intValue == 0 ? false : true
        result = ForecastResultType(rawValue: json["result"].intValue) ?? .notOpen
        xid = json["xid"].intValue
        leagueName = json["league_name"].stringValue
        home = json["home3"].stringValue
        homeLogo = json["home_logo"].stringValue
        away = json["away3"].stringValue
        awayLogo = json["away_logo"].stringValue
        matchTime = json["match_time"].doubleValue
        letBall = json["let_ball"].intValue
        color = json["color"].stringValue
        score = json["score"].stringValue
        serial = json["serial"].stringValue
        isSpfFixed = json["spf_fixed"].intValue == 0 ? false : true
        isRqspfFixed = json["rqspf_fixed"].intValue == 0 ? false : true
        spfSingle = json["spf_single"].intValue
        rqspfSingle = json["rqspf_single"].intValue
        spfSp3 = json["spf_sp3"].doubleValue
        spfSp1 = json["spf_sp1"].doubleValue
        spfSp0 = json["spf_sp0"].doubleValue
        rqspfSp3 = json["rqspf_sp3"].doubleValue
        rqspfSp1 = json["rqspf_sp1"].doubleValue
        rqspfSp0 = json["rqspf_sp0"].doubleValue
    }
}


