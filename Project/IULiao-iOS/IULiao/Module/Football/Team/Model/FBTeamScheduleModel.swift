//
//  FBTeamScheduleModel.swift
//  IULiao
//
//  Created by tianshui on 2017/11/9.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队赛程
struct FBTeamScheduleModel {

    
    /// 结束比赛
    var overMatchList: [FBLiveMatchModel]
    
    /// 未来比赛
    var futureMatchList: [FBLiveMatchModel]
}
