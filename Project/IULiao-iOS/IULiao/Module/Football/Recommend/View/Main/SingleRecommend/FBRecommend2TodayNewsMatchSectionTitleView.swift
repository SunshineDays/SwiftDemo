//
//  FBRecommend2TodayNewsMatchSectionTitleView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/19.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 今日推荐 按比赛找 SectionHeaderView
class FBRecommend2TodayNewsMatchSectionTitleView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var allButton: UIButton!
    
    @IBOutlet weak var jingCaiButton: UIButton!
    
    @IBOutlet weak var beiDanButton: UIButton!
    
    @IBOutlet weak var selectButton: UIButton!
    
    /// 根据选中的类型确定颜色
    var lotteryType: Lottery = .all {
        didSet {
            allButton.setTitleColor(lotteryType == .all ? UIColor(hex: 0xF49900) : UIColor(hex: 0x333333), for: .normal)
            allButton.layer.borderColor = lotteryType == .all ? UIColor(hex: 0xF49900).cgColor : UIColor.clear.cgColor
            
            jingCaiButton.setTitleColor(lotteryType == .jingcai ? UIColor(hex: 0xF49900) : UIColor(hex: 0x333333), for: .normal)
            jingCaiButton.layer.borderColor = lotteryType == .jingcai ? UIColor(hex: 0xF49900).cgColor : UIColor.clear.cgColor
            
            beiDanButton.setTitleColor(lotteryType == .beidan ? UIColor(hex: 0xF49900) : UIColor(hex: 0x333333), for: .normal)
            beiDanButton.layer.borderColor = lotteryType == .beidan ? UIColor(hex: 0xF49900).cgColor : UIColor.clear.cgColor
        }
    }
    
}
