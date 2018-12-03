//
//  FBMatchRecommendHeaderView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 推荐 头部
class FBMatchRecommendHeaderView: UIView {

    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    @IBOutlet weak var playTypeButton: UIButton!

    @IBOutlet weak var playTypeButtonLeftConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if TSScreen.currentWidth < TSScreen.iPhone6Width {
            playTypeButtonLeftConstraint.constant = 0
        }
        
        segmentedControl.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: TSColor.gray.gamut333333,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
        ]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: TSColor.logo,
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
        ]
        
        segmentedControl.isUserDraggable = false
        segmentedControl.selectionIndicatorLocation = .none
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.segmentWidthStyle = .dynamic
        
        playTypeButton.layoutImageViewPosition(.right, withOffset: 6)
    }
    
}
