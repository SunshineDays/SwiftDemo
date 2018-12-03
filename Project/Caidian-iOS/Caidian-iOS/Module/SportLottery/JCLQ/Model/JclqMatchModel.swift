//
// Created by tianshui on 2018/5/11.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 竞彩篮球对阵
struct JclqMatchModel: SLMatchModelProtocol {

    var json: JSON

    var id: Int
    var home: String
    var away: String
    var xid: Int
    var issue: String
    var matchTime: TimeInterval
    var color: UIColor
    var leagueName: String
    var score: String?
    var halfScore: String? = ""
    var letBall: Double
    var saleStatus: SLMatchSaleStatusType

    var recommendId: Int
    /// 竞彩序号
    var serial: String

    /// 销售截止时间
    var saleEndTime: TimeInterval

    /// 销售截止时间
    var saleEndTimeString: String
    
    /// 大小分
    var dxfNum: Double

    /// 胜负固定过关
    var sfFixed: Bool

    /// 让分胜负固定过关
    var rfsfFixed: Bool

    /// 大小分固定过关
    var dxfFixed: Bool

    /// 胜负差固定过关
    var sfcFixed: Bool

    /// 胜负单关
    var sfSingle: Bool

    /// 让分胜负单关
    var rfsfSingle: Bool

    /// 大小分单关
    var dxfSingle: Bool

    /// 胜分差单关
    var sfcSingle: Bool

    /// 胜负赔率
    var sf_sp3: JclqBetKeyType
    var sf_sp0: JclqBetKeyType

    /// 让分胜负赔率
    var rfsf_sp3: JclqBetKeyType
    var rfsf_sp0: JclqBetKeyType

    /// 大小分赔率
    var dxf_sp3: JclqBetKeyType
    var dxf_sp0: JclqBetKeyType

    /// 胜分差 0主1客
    var sfc_sp11: JclqBetKeyType
    var sfc_sp12: JclqBetKeyType
    var sfc_sp13: JclqBetKeyType
    var sfc_sp14: JclqBetKeyType
    var sfc_sp15: JclqBetKeyType
    var sfc_sp16: JclqBetKeyType
    var sfc_sp01: JclqBetKeyType
    var sfc_sp02: JclqBetKeyType
    var sfc_sp03: JclqBetKeyType
    var sfc_sp04: JclqBetKeyType
    var sfc_sp05: JclqBetKeyType
    var sfc_sp06: JclqBetKeyType

    init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        home = json["home3"].stringValue
        away = json["away3"].stringValue
        recommendId = 0
        xid = json["xid"].intValue
        issue = json["issue"].stringValue
        matchTime = json["match_time"].doubleValue
        color = UIColor(rgba: json["color"].stringValue)
        leagueName = json["league_name"].stringValue
        saleStatus = SLMatchSaleStatusType(rawValue: json["status"].intValue) ?? .normal
        let score = json["score"].stringValue
        // 108:92
        if score.split(separator: ":").count == 2 {
            self.score = score
        }

        serial = json["serial"].stringValue
        letBall = json["let_ball"].doubleValue
        saleEndTime = json["sale_end_time"].doubleValue
        saleEndTimeString = "\(Date(timeIntervalSince1970: saleEndTime).string(format: "HH:mm"))"
        dxfNum = json["dxf_num"].doubleValue

        sfFixed = json["sf_fixed"].boolValue
        rfsfFixed = json["rfsf_fixed"].boolValue
        dxfFixed = json["dxf_fixed"].boolValue
        sfcFixed = json["sfc_fixed"].boolValue
        sfSingle = json["sf_single"].boolValue
        rfsfSingle = json["rfsf_single"].boolValue
        dxfSingle = json["dxf_single"].boolValue
        sfcSingle = json["sfc_single"].boolValue

        sf_sp3 = JclqBetKeyType.sf_sp3(sp: json["sf_sp3"].doubleValue)
        sf_sp0 = JclqBetKeyType.sf_sp0(sp: json["sf_sp0"].doubleValue)
        rfsf_sp3 = JclqBetKeyType.rfsf_sp3(sp: json["rfsf_sp3"].doubleValue)
        rfsf_sp0 = JclqBetKeyType.rfsf_sp0(sp: json["rfsf_sp0"].doubleValue)
        dxf_sp3 = JclqBetKeyType.dxf_sp3(sp: json["dxf_sp3"].doubleValue)
        dxf_sp0 = JclqBetKeyType.dxf_sp0(sp: json["dxf_sp0"].doubleValue)
        sfc_sp11 = JclqBetKeyType.sfc_sp11(sp: json["sfc_sp11"].doubleValue)
        sfc_sp12 = JclqBetKeyType.sfc_sp12(sp: json["sfc_sp12"].doubleValue)
        sfc_sp13 = JclqBetKeyType.sfc_sp13(sp: json["sfc_sp13"].doubleValue)
        sfc_sp14 = JclqBetKeyType.sfc_sp14(sp: json["sfc_sp14"].doubleValue)
        sfc_sp15 = JclqBetKeyType.sfc_sp15(sp: json["sfc_sp15"].doubleValue)
        sfc_sp16 = JclqBetKeyType.sfc_sp16(sp: json["sfc_sp16"].doubleValue)
        sfc_sp01 = JclqBetKeyType.sfc_sp01(sp: json["sfc_sp01"].doubleValue)
        sfc_sp02 = JclqBetKeyType.sfc_sp02(sp: json["sfc_sp02"].doubleValue)
        sfc_sp03 = JclqBetKeyType.sfc_sp03(sp: json["sfc_sp03"].doubleValue)
        sfc_sp04 = JclqBetKeyType.sfc_sp04(sp: json["sfc_sp04"].doubleValue)
        sfc_sp05 = JclqBetKeyType.sfc_sp05(sp: json["sfc_sp05"].doubleValue)
        sfc_sp06 = JclqBetKeyType.sfc_sp06(sp: json["sfc_sp06"].doubleValue)
    }
}
