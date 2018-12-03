//
//  RankTopView.swift
//  IULiao
//
//  Created by 李来伟 on 2017/8/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 顶部四个按钮view
class FBRecommendTopView: UIView {

    @IBAction func KeepWinAction(_ sender: UIButton) {
        pushNextVc(rankType: .keepWin)
    }
    
    @IBAction func ProfitAction(_ sender: UIButton) {
        pushNextVc(rankType: .payoff)
    }
    
    @IBAction func newsAction(_ sender: UIButton) {
        pushNextVc(rankType: .hitPercent)
    }

    @IBAction func beaconAction(_ sender: UIButton) {
        pushNextVc(rankType: .keepLost)
    }
    private func pushNextVc(rankType: RecommendRankType) {
        let vc = FBRecommendRankBaseViewController()
        vc.initWith(title: .football, footballRankType: rankType)
        vc.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
