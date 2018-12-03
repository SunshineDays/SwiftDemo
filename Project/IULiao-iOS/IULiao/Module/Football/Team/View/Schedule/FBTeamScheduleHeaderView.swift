//
//  FBTeamScheduleHeaderView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/9.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球队赛程
class FBTeamScheduleHeaderView: UIView {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configView(isShowFutureMatch: Bool) {
        if isShowFutureMatch {
            arrowImageView.image = R.image.fbTeam.futureArrowUp()
            titleLabel.text = "隐藏部分未来赛事"
        } else {
            arrowImageView.image = R.image.fbTeam.futureArrowDown()
            titleLabel.text = "显示更多未来赛事"
        }
    }
}
