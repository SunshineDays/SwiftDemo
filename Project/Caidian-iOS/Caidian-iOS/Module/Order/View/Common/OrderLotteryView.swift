//
//  OrderLotteryView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/5.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 订单彩种信息
class OrderLotteryView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lotteryImageView: UIImageView!
    @IBOutlet weak var lotteryLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var multipleLabel: UILabel!
    @IBOutlet weak var bonusLabel: UILabel!
    @IBOutlet weak var hitImageView: UIImageView!
    
    static let defaultHeight: CGFloat = 140
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {
        contentView = R.nib.orderLotteryView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    func configView(orderDetail: OrderDetailModel) {
        let play = orderDetail.order.play == .none ? "" : " - \(orderDetail.order.play.name)"
        lotteryLabel.text = "\(orderDetail.order.lottery.name)\(play)"
        issueLabel.text = orderDetail.order.issue
        lotteryImageView.image = orderDetail.order.lottery.logo
        
        totalMoneyLabel.text = orderDetail.buy.buyMoney.moneyText()
        multipleLabel.text = "\(orderDetail.order.multiple)"
        
        if orderDetail.order.revokeStatus == OrderRevokeStatusType.normal  && orderDetail.order.winStatus == OrderWinStatusType.win{
            if orderDetail.order.winStatus == .notOpen {
                bonusLabel.text = "待开奖"
            } else if orderDetail.order.winStatus == .lost {
                bonusLabel.text = "未中奖"
            } else {
                bonusLabel.text = "\(orderDetail.buy.bonus.decimal(2))"
                bonusLabel.textColor = UIColor.logo
                hitImageView.isHidden = false
            }
            
        }
        
    }

}
