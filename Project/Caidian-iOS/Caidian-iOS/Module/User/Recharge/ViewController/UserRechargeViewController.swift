//
//  UserRechargeViewController.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/27.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 充值
class UserRechargeViewController: BaseViewController {

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var rechargeText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var money100: UserRechargeMoneyView!
    @IBOutlet weak var money200: UserRechargeMoneyView!
    @IBOutlet weak var money300: UserRechargeMoneyView!
    @IBOutlet weak var money500: UserRechargeMoneyView!

    private var isFirst = true
    private var rangePoint: NSRange!
    var money: Double = 100

    private var moneyArr = [UserRechargeMoneyView: String]()
    private let handler = UserRechargeHandler()
    private var key: String?
    private var maxMoney: Double = 100


    private var rechargeList = [UserRechargeModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = footerView
        rechargeText.delegate = self
        initData()
        money100.text = "100元"
        money200.text = "200元"
        money300.text = "300元"
        money500.text = "500元"
        moneyArr[money100] = "100"
        moneyArr[money200] = "200"
        moneyArr[money300] = "300"
        moneyArr[money500] = "500"
        /// 初始设置
        switch money {
        case 100: self.setMoneyView(rechargeView: self.money100)
        case 200: self.setMoneyView(rechargeView: money200)
        case 300: self.setMoneyView(rechargeView: money300)
        case 500: self.setMoneyView(rechargeView: money500)
        default:  self.setMoneyView(rechargeView: nil)
        }
        if money == Double(Int(money)) {
            rechargeText.text = "\(money.decimal(0))"
        } else {
            rechargeText.text = "\(money.decimal(2))"
        }

        moneyArr.forEach { moneyView, moneyString in
            moneyView.serialBtnClickBlock = {
                [weak self] btn, isChecked in
                self?.rechargeText.text = moneyString
                self?.setMoneyView(rechargeView: moneyView)
            }

        }
        nicknameLabel.text = UserToken.shared.userInfo?.nickname
        balanceLabel.text = "\(UserToken.shared.userAccount!.balance + UserToken.shared.userAccount!.reward)元"

    }

    lazy var footerView: UIView = {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120))
        backView.backgroundColor = UIColor.clear
        let payButton = UIButton(frame: CGRect(x: 10, y: 20, width: UIScreen.main.bounds.width - 20, height: 40))
        payButton.backgroundColor = UIColor(hex: 0xff4444)
        payButton.setTitle("立即支付", for: .normal)
        payButton.setTitleColor(UIColor.white, for: .normal)
        payButton.setCornerRadius(radius: 5)
        payButton.addTarget(self, action: #selector(postPayoff), for: .touchUpInside)

        backView.addSubview(payButton)

        let mindLabel = UILabel(frame: CGRect(x: payButton.x, y: payButton.y + payButton.height + 20, width: payButton.width, height: payButton.height))
        mindLabel.text = "  为防止恶意套现、洗钱，单笔充值后需消费30%方可提现。"
        mindLabel.textColor = UIColor(hex: 0x333333)
        mindLabel.backgroundColor = UIColor(hex: 0xffe9e5)
        mindLabel.borderWidth = 1
        mindLabel.borderColor = UIColor(hex: 0xff4422)
        mindLabel.font = UIFont.systemFont(ofSize: 12)
        mindLabel.cornerRadius = 5
        backView.addSubview(mindLabel)
        return backView
    }()

/// 获取充值方式列表
    func initData() {
        handler.rechargeList(success: {
            list in
            self.rechargeList = list
            let recommendRecharge = self.rechargeList.first {
                $0.isRecommend
            }
            self.key = recommendRecharge?.key
            self.maxMoney = recommendRecharge?.maxAmount ?? 0
            self.tableView.reloadData()

        }, failed: {
            error in
            TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        })


    }

///提交 立即支付
    @objc func postPayoff() {
        if key == nil {
            TSToast.showText(view: view, text: "请选择充值方式！")
            return
        }
        var text: String? = self.rechargeText.text
        if (text == nil) {
            TSToast.showText(view: view, text: "请输入充值金额！")
            return
        } else if (text!.isEmpty) {
            text = "100"
        }

//        let money: Double = Double(text!)!
//        if money < 10 {
//            TSToast.showText(view: view, text: "充值金额不能小于10元！")
//            return
//        }
//        if money > 10000 {
//            TSToast.showText(view: view, text: "超出最大充值金额！")
//            return
//        }
        TSToast.showLoading(view: view)
        /// 发起充值请求
        handler.rechargeApply(
                key: key!,
                money: money,
                success: {
                    url in
                    self.openUrl(urlString: url)
                    TSToast.hideHud(for: self.view)
                },
                failed: {
                    error in
                    TSToast.hideHud(for: self.view)
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                })
    }

    func setMoneyView(rechargeView: UserRechargeMoneyView?) {
        moneyArr.keys.forEach { it in
            it.isChecked = it == rechargeView
        }
    }

    @IBAction func rechargeTextAction(_ sender: UITextField) {
        let moneyString = sender.text
        switch moneyString {
        case "100": setMoneyView(rechargeView: money100)
        case "200": setMoneyView(rechargeView: money200)
        case "300": setMoneyView(rechargeView: money300)
        case "500": setMoneyView(rechargeView: money500)
        case "": setMoneyView(rechargeView: money100)
        default: setMoneyView(rechargeView: nil)
        }
    }

/// 跳转浏览器
    func openUrl(urlString: String) {
        let url = URL(string: urlString)
        if url == nil {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }

}

/// 充值方式
extension UserRechargeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userRechargeTableViewCell, for: indexPath)!
        cell.configCell(rechargeModel: rechargeList[indexPath.row])
        return cell

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rechargeList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0...rechargeList.count - 1 {
            rechargeList[i].isRecommend = false
        }
        rechargeList[indexPath.row].isRecommend = true
        key = rechargeList[indexPath.row].key
        maxMoney = rechargeList[indexPath.row].maxAmount

        tableView.reloadData()
    }
}

/// 金额输入限制
extension UserRechargeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("range:\(range) rangeLenght:\(range.length)  rangeLocation:\(range.location)  string:\(string)")

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
        print(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
}
