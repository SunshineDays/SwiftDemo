//
//  UserOrderPayLogTableViewCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 交易日志cell
class UserOrderPayLogTableViewCell: UITableViewCell {

    @IBOutlet weak var lotteryLabel: UILabel!
    @IBOutlet weak var payCodeLabel: UILabel!
    @IBOutlet weak var tradeTypeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var rowImageView: UIImageView!
    
    func configCell(payLogCellModel: UserPayLogCellModel) {
        lotteryLabel.text = payLogCellModel.remark
        payCodeLabel.text = payLogCellModel.payCode
        tradeTypeLabel.text = payLogCellModel.tradeName
        timeLabel.text = TSUtils.timestampToString(payLogCellModel.createdTime)
        if payLogCellModel.inOut == InOutType.tradeIn {
            moneyLabel.text = "+\(payLogCellModel.payMoney.decimal(2))"
            moneyLabel.textColor = UIColor.logo
        } else {
            moneyLabel.text = "-\(payLogCellModel.payMoney.decimal(2))"
            moneyLabel.textColor = UIColor(hex: 0x7bb9ed)
        }
       if getCanOpenDetail(tradeId: payLogCellModel.tradeId) {
//           self.accessoryView = nil
//           self.accessoryType = .disclosureIndicator
        rowImageView.isHidden = false
       } else {
//            self.accessoryView = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        rowImageView.isHidden = true

       }


    }

    private func getCanOpenDetail(tradeId: TradeIdType) -> Bool {
        let tradeIdArr: [TradeIdType] = [.puTongGouMaiCaipiao, .zhuiHaoGouMaiCaiPiao, .yongHuTiKuanZhiChu, .tikuanFailureMoney]
        return tradeIdArr.contains(tradeId)
    }

}
