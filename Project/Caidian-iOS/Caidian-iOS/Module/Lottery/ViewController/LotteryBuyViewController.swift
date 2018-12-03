//
//  LotteryBuyViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 购买确认
class LotteryBuyViewController: BaseViewController {

    @IBOutlet weak var lotteryLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var waitPayMoneyLabel: UILabel!
    @IBOutlet weak var userTotalMoneyLabel: UILabel!
    @IBOutlet weak var lackMoneyLabel: UILabel!
    @IBOutlet weak var lackView: UIView!
    
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var rechargeBtn: UIButton!
    @IBOutlet weak var recommendBtn: UIButton!

    
    var buyModel: BuyModelProtocol!
    private var userAccount: UserAccountModel? {
        didSet {
            configView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        getAccountDetail()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK:- method
extension LotteryBuyViewController {

    private func initView() {
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = []
        
        var play = ""
        if buyModel.play != .none {
            play = " - \(buyModel.play.name)"
        }
        lotteryLabel.text = "\(buyModel.lottery.name)\(play)"
        recommendBtn.isHidden = buyModel.lottery != LotteryType.jczq
    }
    
    private func configView() {
        totalMoneyLabel.text = "\(buyModel.totalMoney.moneyText())元"
        waitPayMoneyLabel.text = "\(buyModel.totalMoney.moneyText())元"
        guard let userAccount = userAccount else {
            return
        }
        userTotalMoneyLabel.text = "\((userAccount.balance + userAccount.reward).decimal(2))元"
        
        // 差额
        let lackMoney = userAccount.balance + userAccount.reward - buyModel.totalMoney
        
        if lackMoney >= 0 {
            lackView.isHidden = true
            buyBtn.isHidden = false
            rechargeBtn.isHidden = true
            recommendBtn.isHidden = false
        } else {
            lackView.isHidden = false
            buyBtn.isHidden = true
            rechargeBtn.isHidden = false
            recommendBtn.isHidden = true
            lackMoneyLabel.text = "\(abs(lackMoney).decimal(2))元"
        }
        recommendBtn.isHidden = buyModel.lottery != LotteryType.jczq
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

// MARK:- action
extension LotteryBuyViewController {
    @IBAction func rechargeBtnAction(_ sender: UIButton) {
        guard let userAccount = userAccount else {
            return
        }
        let lackMoney = abs(userAccount.balance + userAccount.reward - buyModel.totalMoney)
        let ctrl = TSEntryViewControllerHelper.rechargeViewController(money: lackMoney)
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    @IBAction func buyBtnAction(_ sender: UIButton) {
        TSToast.showLoading(view: view, text: "提交彩店中...")
        buyBtn.isEnabled = false
        LotteryBuyHandler().buy(
                buyModel: buyModel,

                success: {
                    account, order, buy in

                    TSToast.hideHud(for: self.view)
                    self.buyBtn.isEnabled = true
                    let ctrl = R.storyboard.lotteryBuySuccess.lotteryBuySuccessViewController()!
                    ctrl.account = account
                    ctrl.buy = buy
                    ctrl.order = order

                    /// 购买成功
                    NotificationCenter.default.post(name: TSNotification.buySuccess.notification, object: self)


                    self.navigationController?.pushViewController(ctrl, animated: true)
                },
                failed: {
                    error in
                    TSToast.hideHud(for: self.view)
                    self.buyBtn.isEnabled = true
                    TSToast.showText(view: self.view, text: error.localizedDescription)
                })
    }
    

    
    
    //// 我要发单
    @IBAction func recommendButtonClick(_ sender: UIButton) {
        
        let ctrl = R.storyboard.orderSend.orderSendViewController()!
        ctrl.buyModel = buyModel as? SLBuyModel<JczqMatchModel,JczqBetKeyType>
        self.navigationController?.pushViewController(ctrl, animated: true)
        
    }
}
