//
//  FBTeamDetailHistoryMatchView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队 近期走势(历史交锋)
class FBTeamDetailHistoryMatchView: UIView {

    @IBOutlet weak var stackView: UIStackView!
 
    func configView(teamId: Int, matchList: [FBLiveMatchModel]) {
        
        for match in matchList {
            let v = R.nib.fbTeamDetailHistoryMatchItemView.firstView(owner: nil)!
            v.configView(teamId: teamId, match: match)
            stackView.addArrangedSubview(v)
        }
    }
    

}
