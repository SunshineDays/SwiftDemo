//
//  UserPutForwardViewController.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/28.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 申请提现
class UserPutForwardViewController: BaseViewController {


    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var cardNumLabel: UILabel!
    @IBOutlet weak var moneyText: UITextField!

    private var isFirst = true
    private var rangePoint: NSRange!
    private var bankList = [BankModel]()

    private let handler = UserWithdrawHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        moneyText.delegate = self
        requestBankList()
        TSToast.showLoading(view: view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


    @IBAction func applyBtnAction(_ sender: UIButton) {
//        TSToast.
        let moneyString = moneyText.text
        if moneyString == nil || moneyString!.isEmpty {
            TSToast.showText(view: view, text: "请输入提现金额！")
            return
        }
        let money = Double(moneyString!)!
        if money == 0.0 {
            TSToast.showText(view: view, text: "请输入提现金额！")
            return
        }
        sender.isEnabled = false
        handler.apply(money: money, success: {
            data in
            sender.isEnabled = true
            TSToast.showText(view: self.view, text: "提现申请成功", color: .success,position: .center)

        }, failed: {
            error in
            sender.isEnabled = true
            TSToast.showText(view: self.view, text: error.localizedDescription, color: .error,position: .center)
        })

    }

    /**
    * 银行列表网络请求
    **/
    func requestBankList() {
        UserLoginHandler().requestBankList(
                success: {
                    (it) in
                    self.bankList = it
                    self.requestRealNameInfo()
                },
                failed: {
                    (error) in
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                })
    }

    /// 实名认证信息
    func requestRealNameInfo() {
        UserRealNameHandler().requestRealNameDetail(
                success: {
                    (it) in
                    self.setBankInfo(bankId: it.bankId, bankCardCode: it.bankCode)
                    TSToast.hideHud(for: self.view)

                },
                failed: {
                    (error) in
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                }
        )

    }

    /// 设置银行卡信息

    func setBankInfo(bankId: Int, bankCardCode: String) {
        cardNumLabel.text = "尾号\(bankCardCode[(bankCardCode.count - 4)..<(bankCardCode.count)])"
        bankLabel.text = bankList.first {
            $0.id == bankId
        }?.name
    }
}

extension UserPutForwardViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if string == "" || string == "\n" {
            if rangePoint != nil {
                if range.location == rangePoint.location {
                    isFirst = true
                }
            }
            return true
        }
        if (string == "." || Int(string)! <= 9 && Int(string)! >= 0) {
            if isFirst == true {
                if string == "." {
                    isFirst = false
                    rangePoint = range
                    return true
                }
            } else if isFirst == false {
                if string == "." {
                    return false
                } else if range.location - rangePoint.location > 2 {
                    return false
                }
            }
        } else {
            return false
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
