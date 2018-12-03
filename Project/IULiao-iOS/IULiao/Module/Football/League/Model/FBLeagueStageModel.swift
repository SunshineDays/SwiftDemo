//
//  FBLeagueStageModel.swift
//  IULiao
//
//  Created by tianshui on 2017/10/23.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 联赛 阶段
struct FBLeagueStageModel: BaseModelProtocol {
    
    var json: JSON
    
    var id: Int
    
    /// 阶段名
    var name: String
    
    /// 是否进行到当前阶段
    var isCurrent: Bool
    
    /// 类型
    var type: StageType
    
    /// 此阶段下的分组或圈
    var groups: [GroupModel]
    
    init(json: JSON) {
        self.json = json
        id  = json["id"].intValue
        name = json["name"].stringValue
        isCurrent = json["iscurrent"].boolValue
        type = StageType(rawValue: json["type"].stringValue) ?? .normal
        groups = json["groups"].arrayValue.map { GroupModel(json: $0) }
    }
    
    /// 阶段类型
    enum StageType: String {
        /// 普通
        case normal
        
        /// 圈
        case round
        
        /// 小组
        case group
    }
    
    /// 小组或圈 model
    struct GroupModel: BaseModelProtocol {
        var json: JSON
        
        var id: Int
        
        /// 分组名
        var name: String
        
        /// 是否进行到当前分组
        var isCurrent: Bool
        
        init(json: JSON) {
            self.json = json
            id  = json["id"].intValue
            name = json["name"].stringValue
            isCurrent = json["iscurrent"].boolValue
        }
    }
}

