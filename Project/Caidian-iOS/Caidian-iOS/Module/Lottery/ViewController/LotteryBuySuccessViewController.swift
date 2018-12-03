//
//  LotteryBuySuccessViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/2.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 购买成功
class LotteryBuySuccessViewController: BaseViewController {
    
    @IBOutlet weak var lotteryLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var orderNumLabel: UILabel!
    
    @IBOutlet weak var continueBuyBtn: UIButton!
    @IBOutlet weak var buyLogBtn: UIButton!
    
    var account: UserAccountModel!
    var order: OrderModel!
    var buy: UserBuyModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK:- method
extension LotteryBuySuccessViewController {
    
    private func initView() {
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = []
        
        var play = ""
        if order.play != .none {
            play = " - \(order.play.name)"
        }
        lotteryLabel.text = "\(order.lottery.name)\(play)"
        
        balanceLabel.text = "\(account.balance.decimal(2))元"
        rewardLabel.text = "\(account.reward.decimal(2))元"
        
        orderNumLabel.text = order.orderNum
    }
    
    
}

// MARK:- action
extension LotteryBuySuccessViewController {
    @IBAction func continueBuyBtnAction(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func buyLogBtnAction(_ sender: UIButton) {
        
        let ctrl = TSEntryViewControllerHelper.orderDetailViewController(buyId: buy.id)
        navigationController?.pushViewController(ctrl, animated: true)
        
        if let ctrls = navigationController?.viewControllers,
            let first = ctrls.first,
            let last = ctrls.last {
            navigationController?.setViewControllers([first, last], animated: true)
        }
    }

}
