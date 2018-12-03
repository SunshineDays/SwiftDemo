//
//  FBLeagueHomeDataModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 联赛首页数据结构
struct FBLeagueHomeDataModel: BaseModelProtocol {
    
    var json: JSON
    
    /// 热门联赛
    var hotLeagues: [FBLeagueModel]
    
    /// 洲际
    var continents: [Continent]
    
    /// 洲际
    enum Continent {
        
        /// 欧洲
        case europe(countries: [FBLeagueCountryModel], regions: [FBLeagueModel])
        
        /// 亚洲
        case asia(countries: [FBLeagueCountryModel], regions: [FBLeagueModel])
        
        /// 美洲
        case america(countries: [FBLeagueCountryModel], regions: [FBLeagueModel])
        
        /// 大洋洲
        case oceania(countries: [FBLeagueCountryModel], regions: [FBLeagueModel])
        
        /// 非洲
        case africa(countries: [FBLeagueCountryModel], regions: [FBLeagueModel])
        
        /// 国际赛
        case worldLeagues(leagues: [FBLeagueModel])
        
        /// 名称
        var name: String {
            switch self {
            case .europe(_, _): return "欧洲"
            case .asia(_, _): return "亚洲"
            case .america(_, _): return "美洲"
            case .oceania(_, _): return "大洋洲"
            case .africa(_, _): return "非洲"
            case .worldLeagues(_): return "国际赛"
            }
        }
        
        /// 下属国家
        var countries: [FBLeagueCountryModel]? {
            switch self {
            case let .europe(countries, _),
                 let .asia(countries, _),
                 let .america(countries, _),
                 let .oceania(countries, _),
                 let .africa(countries, _):
                return countries
            case .worldLeagues(_):
                return nil
            }
        }
        
        /// 下属洲际联赛(国际赛)
        var regionLeagues: [FBLeagueModel] {
            switch self {
            case let .europe(_, regions),
                 let .asia(_, regions),
                 let .america(_, regions),
                 let .oceania(_, regions),
                 let .africa(_, regions):
                return regions
            case let .worldLeagues(leagues):
                return leagues
            }
        }
        
    }
    
    init(json: JSON) {
        self.json = json
        
        hotLeagues = json["hotleagues"].arrayValue.map { FBLeagueModel(json: $0) }
        
        continents = [
            Continent.europe(
                countries: json["europe"]["countries"].arrayValue.map { FBLeagueCountryModel(json: $0)},
                regions: json["europe"]["regions"].arrayValue.map { FBLeagueModel(json: $0) }
            ),
            Continent.america(
                countries: json["america"]["countries"].arrayValue.map { FBLeagueCountryModel(json: $0)},
                regions: json["america"]["regions"].arrayValue.map { FBLeagueModel(json: $0) }
            ),
            Continent.asia(
                countries: json["asia"]["countries"].arrayValue.map { FBLeagueCountryModel(json: $0)},
                regions: json["asia"]["regions"].arrayValue.map { FBLeagueModel(json: $0) }
            ),
            Continent.oceania(
                countries: json["oceania"]["countries"].arrayValue.map { FBLeagueCountryModel(json: $0)},
                regions: json["oceania"]["regions"].arrayValue.map { FBLeagueModel(json: $0) }
            ),
            Continent.africa(
                countries: json["africa"]["countries"].arrayValue.map { FBLeagueCountryModel(json: $0)},
                regions: json["africa"]["regions"].arrayValue.map { FBLeagueModel(json: $0) }
            ),
            Continent.worldLeagues(
                leagues: json["worldleagues"].arrayValue.map { FBLeagueModel(json: $0) }
            ),
        ]

    }
}
