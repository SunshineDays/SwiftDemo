//
//  PlanOrderDetailBottomView.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 计划跟单 详情 底部跟单View
class PlanOrderDetailBottomView: UIView {
    
    @IBOutlet weak var inputViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var planOrderButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var betInputStepper: TSInputStepper!
    @IBOutlet weak var planOrderBtn: UIButton!
    var multiple = 10{
        didSet{
            let attrStr = NSMutableAttributedString()
            attrStr.append(NSAttributedString(string: "共 ", attributes: [:]))
            let total = self.multiple * 2
            attrStr.append(NSAttributedString(string: total.moneyText(), attributes: [NSAttributedStringKey.foregroundColor: UIColor.matchResult.win]))
            attrStr.append(NSAttributedString(string: " 元 ", attributes: [:]))
            
            self.moneyLabel.attributedText = attrStr
        }
    }

    var bottomViewHeight : CGFloat = 50

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        betInputStepper.maximumValue = 99999
        betInputStepper.minimumValue = 1
      
        betInputStepper.valueChangedBlock = {
            value  in
            self.multiple = value
        }
        
         betInputStepper.value = 10
        
         if TSScreen.currentWidth <= TSScreen.iPhone5Width {
           
            inputViewConstraint.constant = 100
            planOrderButtonWidthConstraint.constant =  80
        }else{
             inputViewConstraint.constant = 134
             planOrderButtonWidthConstraint.constant =  TSScreen.currentWidth/4
        }
    }
  

    func configView() {
    }
}
