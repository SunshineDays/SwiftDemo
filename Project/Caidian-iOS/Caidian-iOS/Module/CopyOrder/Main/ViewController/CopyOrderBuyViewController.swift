//
//  CopyOrderBuyViewController.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/24.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

class CopyOrderBuyViewController: BaseViewController {


    @IBOutlet weak var userTotalMoneyLabel: UILabel!
    @IBOutlet weak var waitPayMoneyLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var lotteryLabel: UILabel!

    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var lackMoneyLabel: UILabel!
    @IBOutlet weak var rechargeBtn: UIButton!

    var orderDetailModel: OrderDetailModel!
    var multiple: Int!
    var totalMoney: Double!


    private var userAccount: UserAccountModel? {
        didSet {
            configView()
        }
    }


    @IBOutlet weak var lackView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        getAccountDetail()
    }
}

extension CopyOrderBuyViewController {


    private func initView() {
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = []

        let play = " - \(orderDetailModel.order.play.name)"
        lotteryLabel.text = "\(orderDetailModel.order.lottery.name)\(play)"
        totalMoneyLabel.text = totalMoney.moneyText() + "元"
        waitPayMoneyLabel.text = totalMoney.moneyText() + "元"
    }

    private func configView() {
        guard let userAccount = userAccount else {
            return
        }
        userTotalMoneyLabel.text = "\((userAccount.balance + userAccount.reward).decimal(2))元"

        // 差额
        let lackMoney = userAccount.balance + userAccount.reward - totalMoney

        if lackMoney >= 0 {
            lackView.isHidden = true
            rechargeBtn.isHidden = true
            buyBtn.isHidden = false
        } else {
            lackView.isHidden = false
            rechargeBtn.isHidden = false
            buyBtn.isHidden = true
            lackMoneyLabel.text = "\(abs(lackMoney).decimal(2))元"
        }
    }


    private func getAccountDetail() {
        if let account = UserToken.shared.userAccount {
            userAccount = account
            return
        }

        TSToast.showLoading(view: view)

        UserAccountHandler().getAccountDetail(
                success: {
                    account in
                    self.userAccount = account
                    TSToast.hideHud(for: self.view)
                },
                failed: {
                    error in
                    TSToast.hideHud(for: self.view)
                })
    }

}

// MARK: - action
extension CopyOrderBuyViewController {
    @IBAction func rechargeBtnAction(_ sender: UIButton) {
        guard let userAccount = userAccount else {
            return
        }
        let lackMoney = abs(userAccount.balance + userAccount.reward - totalMoney)
        let ctrl = TSEntryViewControllerHelper.rechargeViewController(money: lackMoney)
        navigationController?.pushViewController(ctrl, animated: true)
    }

    // 跟单提交
    @IBAction func buyBtnClick(_ sender: UIButton) {

        TSToast.showLoading(view: view, text: "提交彩店中...")
        buyBtn.isEnabled = false


        CopyOrderHandler().orderBuy(
                orderId: orderDetailModel.order.id,
                multiple: multiple,
                totalMoney: totalMoney,
                success: {
                    account, order, buy in
                    TSToast.hideHud(for: self.view)
                    self.buyBtn.isEnabled = true
                    
                    
                    /// 购买成功
                    NotificationCenter.default.post(name: TSNotification.buySuccess.notification, object: self)
                    
                    let ctrl = R.storyboard.lotteryBuySuccess.lotteryBuySuccessViewController()!
                    ctrl.account = account
                    ctrl.buy = buy
                    ctrl.order = order
                
                    self.navigationController?.pushViewController(ctrl, animated: true)
                },
                failed: {
                    error in
                    TSToast.hideHud(for: self.view)
                    self.buyBtn.isEnabled = true
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                })


    }
}
