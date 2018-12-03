//
//  FBMatchRecommendSelectHeaderView.swift
//  IULiao
//
//  Created by bin zhang on 2018/5/7.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias MatchSelectedOddsType = (_ oddsType: RecommendDetailOddsType) -> Void

class FBMatchRecommendSelectHeaderView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        clipsToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 1)
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
        let buttons = [footballButton, jingcaiButton]
        for button in buttons {
            button?.setTitleColor(UIColor(hex: 0x333333), for: .normal)
            button?.setTitleColor(UIColor.white, for: .selected)
            button?.setBackgroundColor(UIColor.clear, forState: .normal)
            button?.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
        }
        
        footballButton.addTarget(self, action: #selector(selectAction(_:)), for: .touchUpInside)
        jingcaiButton.addTarget(self, action: #selector(selectAction(_:)), for: .touchUpInside)

    }
    
    
    @IBOutlet weak var footballButton: UIButton!
    
    @IBOutlet weak var jingcaiButton: UIButton!
    
    private var selectedType: MatchSelectedOddsType!
    
    public func setupConfigView(oddsType: RecommendDetailOddsType, selectedType: @escaping MatchSelectedOddsType) {
        footballButton.isSelected = oddsType == .football
        jingcaiButton.isSelected = oddsType == .jingcai
        self.selectedType = selectedType
    }
    
    
    @objc private func selectAction(_ sender: UIButton) {
        footballButton.isSelected = sender == footballButton
        jingcaiButton.isSelected = sender == jingcaiButton
        selectedType(sender == footballButton ? .football : .jingcai)
    }
    
    
}
