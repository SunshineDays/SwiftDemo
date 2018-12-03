//
//  FBTeamLinupModel.swift
//  IULiao
//
//  Created by tianshui on 2017/11/8.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队 阵容
struct FBTeamLinupModel {
    
    /// 位置
    var point: Int
    
    /// 位置描述
    var pointName: String
    
    /// 此位置的球员
    var playerList: [FBPlayerModel]
}
