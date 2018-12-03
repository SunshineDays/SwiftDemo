//
//  CopyOrderDetailBottomView.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/23.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 复制跟单详情底部view
class CopyOrderDetailBottomView: UIView {

    @IBOutlet weak var inputStepper: TSInputStepper!
    @IBOutlet weak var multiple10: UserRechargeMoneyView!
    @IBOutlet weak var multiple20: UserRechargeMoneyView!
    @IBOutlet weak var multiple50: UserRechargeMoneyView!
    @IBOutlet weak var multiple100: UserRechargeMoneyView!

    @IBOutlet weak var inputViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var multipleLabel: UILabel!
    @IBOutlet weak var nextBtn: UIButton!

    /// 单笔金额
    var oneMoney: Double = 0
    /// 立即跟单block
    var followClickBlock: ((_ sender: UIButton) -> Void)?

    private var viewList = [UserRechargeMoneyView]()
    var multiple = 10 {
        didSet {
            let attrStr = NSMutableAttributedString()
            attrStr.append(NSAttributedString(string: "共", attributes: nil))
            attrStr.append(NSAttributedString(string: "\((Double(multiple) * oneMoney).moneyText())", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
            attrStr.append(NSAttributedString(string: "元", attributes: nil))
            multipleLabel.attributedText = attrStr
            switch multiple {
            case 10:
                resetView(multipleView: multiple10)
            case 20:
                resetView(multipleView: multiple20)
            case 50:
                resetView(multipleView: multiple50)
            case 100:
                resetView(multipleView: multiple100)
            default:
                resetView(multipleView: nil)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        viewList.append(multiple10)
        viewList.append(multiple20)
        viewList.append(multiple50)
        viewList.append(multiple100)

        multiple10.serialBtnClickBlock = {
            [weak self]  btn, isChecked in
            self?.inputStepper.value = 10
            self?.resetView(multipleView: self?.multiple10)
        }

        multiple20.serialBtnClickBlock = {
            [weak self]  btn, isChecked in
            self?.inputStepper.value = 20
            self?.resetView(multipleView: self?.multiple20)
        }
        multiple50.serialBtnClickBlock = {
            [weak self]  btn, isChecked in
            self?.inputStepper.value = 50
            self?.resetView(multipleView: self?.multiple50)
        }
        multiple100.serialBtnClickBlock = {
            [weak self]  btn, isChecked in
            self?.inputStepper.value = 100
            self?.resetView(multipleView: self?.multiple100)
        }
        
        inputStepper.maximumValue = 99999
        inputStepper.minimumValue = 1
        
        inputStepper.valueChangedBlock = {
            [weak self] value in
            self?.multiple = value
        }
        inputStepper.value = 10
        
        if TSScreen.currentWidth <= TSScreen.iPhone5Width {
            
            inputViewConstraint.constant = 110
            nextButtonConstraint.constant =  80
        }else{
            inputViewConstraint.constant = 134 
            nextButtonConstraint.constant =  TSScreen.currentWidth/4
        }
    }

    @IBAction func followAction(_ sender: UIButton) {
        followClickBlock?(sender)

    }

    private func resetView(multipleView: UserRechargeMoneyView?) {
        viewList.forEach { view in
            view.isChecked = view == multipleView
        }
    }


    /// 串关显示规则
    func getSeriesString(oneMoney: Double) {
        self.oneMoney = oneMoney
        multiple = 10
    }

}
