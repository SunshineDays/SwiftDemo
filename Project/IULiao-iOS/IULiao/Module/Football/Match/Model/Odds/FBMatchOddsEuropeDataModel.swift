//
//  FBMatchOddsEuropeDataModel.swift
//  IULiao
//
//  Created by tianshui on 2017/12/11.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

/// 赛事分析 欧赔列表数据
struct FBMatchOddsEuropeDataModel {
    var oddsList = [FBOddsEuropeSetModel]()
    var europe99Odds = FBOddsEuropeModel(win: 0, draw: 0, lost: 0)
    var minOdds = FBOddsEuropeModel(win: 0, draw: 0, lost: 0)
    var maxOdds = FBOddsEuropeModel(win: 0, draw: 0, lost: 0)
    var jingcaiOdds = FBOddsEuropeModel(win: 0, draw: 0, lost: 0)
}
