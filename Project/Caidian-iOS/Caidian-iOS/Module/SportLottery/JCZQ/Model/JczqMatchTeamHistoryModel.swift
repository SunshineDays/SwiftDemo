//
//  JczqMatchTeamHistoryModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/25.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 主客队历史战绩
class JczqMatchTeamHistoryModel: BaseModelProtocol {

    var json: JSON
    
    var matchId: Int
    
    var home: String
    
    var away: String
    
    /// 主队排名
    var homeRank: String
    
    
    //// 主队排名所在的联赛
    var homeRankName: String

    //// 客队排名所在的联赛
    var awayRankName: String

    //// 主队排名所在的联赛的排名
    var homeRankNumber: String

    //// 客队排名所在的联赛的排名
    var awayRankNumber: String
    
    
    /// 客队排名
    var awayRank: String
    
    /// 主队近期
    var homeMatchs: MatchsModel
    
    /// 客队近期
    var awayMatchs: MatchsModel
    
    /// 交锋信息
    var wars: MatchsModel
    
    /// 投注比例
    var betRatio: BetRatioModel
    
    /// 跳转的url
    var url: String
    
    required init(json: JSON) {
        self.json = json
        
        matchId = json["match_id"].intValue
        home = json["home"].stringValue
        away = json["away"].stringValue
        homeRank = json["home_rank"].stringValue
        awayRank = json["away_rank"].stringValue
        
        homeMatchs = MatchsModel(json: json["home_matchs"])
        awayMatchs = MatchsModel(json: json["away_matchs"])
        wars = MatchsModel(json: json["wars"])
        betRatio = BetRatioModel(json: json["bet_ratio"])
    
        homeRankNumber = homeRank.pregFindChar(pattern: "[0-9]")
        awayRankNumber = awayRank.pregFindChar(pattern: "[0-9]")
        
        homeRankName = homeRank.replacingOccurrences(of: homeRankNumber, with: "")
        awayRankName = awayRank.replacingOccurrences(of: awayRankNumber, with: "")

        url = json["url"].stringValue
    }
    


    struct MatchsModel {
        var json: JSON
        
        /// 最近6场
        var info = [String]()
        
        init(json: JSON) {
            self.json = json
            
            let infoJson = json["info"].arrayValue
            var info = [String]()
            for (index, i) in infoJson.enumerated() {
                if index < 6 {
                    info.append(i.stringValue)
                }
            }
            self.info = info
        }
    }
    
    /// 投注信息
    struct BetRatioModel {
        var json: JSON
        /// 让球胜平负
        var rqspf: BetRatioResultModel
        /// 胜平负
        var spf: BetRatioResultModel
        
        init(json: JSON) {
            self.json = json
            rqspf = BetRatioResultModel(json: json["rqspf"])
            spf = BetRatioResultModel(json: json["spf"])
        }
        
        /// 投注比例
        struct BetRatioResultModel {
            var json: JSON
            var win: String
            var draw: String
            var lost: String
            
            init(json: JSON) {
                self.json = json
                win = (json["win"].doubleValue * 100).decimal(0) + "%"
                draw = (json["draw"].doubleValue * 100).decimal(0) + "%"
                lost = (json["lost"].doubleValue * 100).decimal(0) + "%"
            }
        }
    }
}

enum HistoryWinStatusType: String {
    case win = "W"
    case draw = "D"
    case lost = "L"
    case none = ""
    
    var color: UIColor {
        switch self {
        case .win: return UIColor(hex: 0xFF3333)
        case .draw: return UIColor(hex: 0x009933)
        case .lost: return UIColor(hex: 0x00AAFF)
        default: return UIColor(hex: 0x00AAFF)
        }
    }
    
    var name: String {
        switch self {
        case .win: return "胜"
        case .draw: return "平"
        case .lost: return "负"
        default : return ""
        }
    }
}


