//
//  OrderSendViewController.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
class OrderSendViewController : BaseViewController{
    

    let  describerStringOne = "允许他人复制方案(方案公开无复制佣金)"
    let  describerFollowString = "允许他人复制方案(跟单后可见方案详情)"
    let  describerStringTwo = "允许他人复制"

    @IBOutlet weak var orderMoneyLabel: UILabel!
    @IBOutlet weak var multipleMoneyLabel: UILabel!
    @IBOutlet weak var choseMatchNameLabel: UILabel!
    @IBOutlet weak var describeLable: UILabel!
    
    
    var buyModel : SLBuyModel<JczqMatchModel,JczqBetKeyType>!
    
    override func viewDidLoad() {
        
        /// 单倍金额
        multipleMoneyLabel.text = buyModel.singleMoney.moneyText()
        
        /// 方案金额
        orderMoneyLabel.text = buyModel.totalMoney.moneyText()
   
        
        /// 所有的联赛名
        let attrStr = NSMutableAttributedString()
//        buyModel.matchList.forEach{
//            jczqMatchModel  in
//            attrStr.append(NSAttributedString(string: "\(jczqMatchModel.match.leagueName)", attributes: [NSAttributedStringKey.foregroundColor: jczqMatchModel.match.color]))
//            attrStr.append(NSAttributedString(string: ",", attributes: [:]))
//        }
//
        for (index, model) in buyModel.matchList.enumerated() {
            attrStr.append(NSAttributedString(string: "\(model.match.leagueName)", attributes: [.foregroundColor: model.match.color]))
            if index < buyModel.matchList.count - 1 {
                attrStr.append(NSAttributedString(string: ", ", attributes: [:]))
            }
        }
        
        choseMatchNameLabel.attributedText = attrStr

    }
    
    
  
    
    ///发单
    @IBAction func sendOrderClick(_ sender: UIButton) {
        
        TSToast.showLoading(view: view, text: "提交彩店中...")
        sender.isEnabled = false
    
        buyModel.orderBuyType = OrderBuyType.sponsor
    
        LotteryBuyHandler().buy(
            buyModel: buyModel,
            success: {
                account, order, buy in
                
                TSToast.hideHud(for: self.view)
                sender.isEnabled = true
                
                let ctrl = R.storyboard.lotteryBuySuccess.lotteryBuySuccessViewController()!
                ctrl.account = account
                ctrl.buy = buy
                ctrl.order = order
                
                self.navigationController?.pushViewController(ctrl, animated: true)
        },
            failed: {
                error in
                TSToast.hideHud(for: self.view)
                sender.isEnabled = true
                TSToast.showText(view: self.view, text: error.localizedDescription)
        })
        
    }
    
    /// 公开|| 截止后公开
    @IBAction func statueSegmentedControlClick(_ sender: UISegmentedControl) {
        
        if  sender.selectedSegmentIndex == 0 {
            describeLable.text = describerStringOne
            buyModel.isSecret =  0
        }else if sender.selectedSegmentIndex == 1{
            describeLable.text = describerFollowString
            buyModel.isSecret =  2
        }else{
            describeLable.text = describerStringTwo
            buyModel.isSecret =  1
        }
        
    }
}
