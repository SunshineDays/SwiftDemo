//
//  FBMatchAnalyzeEvent.swift
//  IULiao
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 赛事分析 比赛时间与数据
struct FBMatchAnalyzeEventModel: BaseModelProtocol {

    var json: JSON

    /// 进球事件
    var eventList: [Event]

    /// 主队统计
    var homeStatistics: Statistics

    /// 客队统计
    var awayStatistics: Statistics

    init(json: JSON) {
        self.json = json
        eventList = json["events"].arrayValue.map { Event(json: $0) }
        homeStatistics = Statistics(json: json["home"])
        awayStatistics = Statistics(json: json["away"])
    }

    /// 进球事件
    struct Event {
        /// 球队
        var team: TeamType
        
        /// 事件发生时间
        var time: String
        
        var timeInt: Int {
            return Int(time.trimmingCharacters(in: CharacterSet(charactersIn: "+"))) ?? 0
        }
        
        /// 描述
        var text: String
        
        /// 入场球员 (仅换人)
        var enterPlayer: String {
            let arr = text.split(separator: "|")
            if arr.count != 2 {
                return ""
            }
            return String(arr[0])
        }
        
        /// 离场球员 (仅换人)
        var leavePlayer: String {
            let arr = text.split(separator: "|")
            if arr.count != 2 {
                return ""
            }
            return String(arr[1])
        }
        
        /// 类型
        var type: Type
        
        init(json: JSON) {
            team = TeamType(rawValue: json["team"].stringValue)
            time = json["time"].stringValue
            text = json["text"].stringValue
            type = Type(rawValue: json["type"].stringValue) ?? .none
        }
        
        init(team: TeamType, time: String, text: String, type: Type) {
            self.team = team
            self.time = time
            self.text = text
            self.type = type
        }
        
        enum `Type`: String {
            /// 进球
            case goal = "goal"
            /// 点球,罚球
            case penalty = "penalty"
            /// 乌龙
            case ownGoal = "own_goal"
            /// 黄牌
            case yellowCard = "yellow_card"
            /// 红牌
            case redCard = "red_card"
            // 两黄变红
            case yellowRed = "yellow_red"
            /// 换人
            case substitute = "substitute"
            /// 阶段 中场
            case stage = "stage_half"

            case none
            
            /// 配图
            var image: UIImage? {
                switch self {
                case .goal:
                    return R.image.fbMatch.eventGoal()
                case .penalty:
                    return R.image.fbMatch.eventPenalty()
                case .ownGoal:
                    return R.image.fbMatch.eventOwnGoal()
                case .yellowCard:
                    return R.image.fbMatch.eventYellowCard()
                case .redCard:
                    return R.image.fbMatch.eventRedCard()
                case .yellowRed:
                    return R.image.fbMatch.eventYellowRed()
                case .substitute:
                    return R.image.fbMatch.eventSubstitute()
                default:
                    return nil
                }
            }
            
            /// 进球球颜色
            var goalColor: UIColor? {
                switch self {
                case .goal:
                    return UIColor(hex: 0x2C2C2C)
                case .penalty:
                    return UIColor(hex: 0x0E932E)
                case .ownGoal:
                    return UIColor(hex: 0xD81E06)
                default:
                    return nil
                }
            }
            
            /// 进球描述
            var goalDescription: String? {
                switch self {
                case .goal:
                    return "入球"
                case .penalty:
                    return "点球"
                case .ownGoal:
                    return "乌龙"
                default:
                    return nil
                }
            }
        }
    }

    /// 事件统计
    struct Statistics {
        /// 犯规
        var foul: Int
        /// 黄牌
        var yellowCard: Int
        /// 扑救
        var save: Int
        /// 角球
        var corner: Int
        /// 控球时间
        var ballTime: Int
        /// 射正
        var shootTarget: Int
        /// 射门
        var shoot: Int
        /// 越位
        var offside: Int
        /// 进球
        var goal: Int

        init(json: JSON) {
            foul = json["foul"].intValue
            yellowCard = json["yellow_card"].intValue
            save = json["save"].intValue
            corner = json["corner"].intValue
            ballTime = json["ball_time"].intValue
            shootTarget = json["shoot_target"].intValue
            shoot = json["shoot"].intValue
            offside = json["offside"].intValue
            goal = json["goal"].intValue
        }
    }
}
