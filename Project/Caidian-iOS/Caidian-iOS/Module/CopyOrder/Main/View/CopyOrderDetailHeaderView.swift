//
//  CopyOrderDetailHeaderView.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/22.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class CopyOrderDetailHeaderView: UIView {
    @IBOutlet weak var avatarBackgroundViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDescribeLabel: UILabel!
    @IBOutlet weak var lotteryLabel: UILabel!
    @IBOutlet weak var serialLabel: UILabel!
    @IBOutlet weak var multipleLabel: UILabel!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var oneMoneyLabel: UILabel!
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var followMoneyLabel: UILabel!
    @IBOutlet weak var moreImageView: UIImageView!
    var serialList: [SLSerialType] = []

    /// 头像
    var avatarBlock: ((_ btn: UIButton) -> Void)?

    @IBAction func avatarAction(_ sender: UIButton) {
        avatarBlock?(sender)
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        if #available(iOS 11.0, *) {
            avatarBackgroundViewHeightConstraint.constant = 140
            avatarButtonTopConstraint.constant = 10
            height = 244
        } else {
            avatarBackgroundViewHeightConstraint.constant = 140 + 44 + TSScreen.statusBarHeight
            avatarButtonTopConstraint.constant = 10 + 44 + TSScreen.statusBarHeight
            height = 244 + 44 + TSScreen.statusBarHeight
            frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: 244 + 44 + TSScreen.statusBarHeight)
        }
        avatarButton.layer.cornerRadius = avatarButton.width / 2
        avatarButton.layer.masksToBounds = true
    }

    func configView(orderDetail: OrderDetailModel) {

        let copy = orderDetail.copy
        let order = orderDetail.order
        self.serialList = order.serialList

        if let url = TSImageURLHelper.init(string: copy.userAvatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
            avatarButton.sd_setImage(with: url, for: .normal)
        } else {
            avatarButton.setImage(R.image.empty.image60x60(), for: .normal)
        }
        userNameLabel.text = copy.userName


        /// 盈利率
        if orderDetail.rankOrder10 != nil {
            var win: String = "0.00"
            if orderDetail.rankOrder10?.selfMoney == 0 {
                win = "0.00"
            } else {
                win = "\((Double(orderDetail.rankOrder10!.selfBonus) / Double(orderDetail.rankOrder10!.selfMoney) * 100).decimal(2))"
            }
            let attrStr = NSMutableAttributedString()
            attrStr.append(NSAttributedString(string: "\(orderDetail.rankOrder10!.orderCount)中\(orderDetail.rankOrder10!.win) | \(orderDetail.rankOrder10!.orderCount)单盈利率 | ", attributes: [:]))
            attrStr.append(NSAttributedString(string: "\(win)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
            attrStr.append(NSAttributedString(string: "%", attributes: [:]))
            userDescribeLabel.attributedText = attrStr
        }


        let attrOneMoneyStr = NSMutableAttributedString()
        attrOneMoneyStr.append(NSAttributedString(string: "\(copy.oneMoney.decimal(0))", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
        attrOneMoneyStr.append(NSAttributedString(string: " 元起投", attributes: [:]))
        oneMoneyLabel.attributedText = attrOneMoneyStr


        let attrTotalMoneyStr = NSMutableAttributedString()
        attrTotalMoneyStr.append(NSAttributedString(string: "自购: ", attributes: [:]))
        attrTotalMoneyStr.append(NSAttributedString(string: "\(copy.totalMoney.decimal(0))", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
        attrTotalMoneyStr.append(NSAttributedString(string: " 元", attributes: [:]))
        totalMoneyLabel.attributedText = attrTotalMoneyStr


        /// 跟单金额
        let attrFollowMoneyStr = NSMutableAttributedString()
        attrFollowMoneyStr.append(NSAttributedString(string: "跟单: ", attributes: [:]))
        attrFollowMoneyStr.append(NSAttributedString(string: "\(copy.followMoney.decimal(0))", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
        attrFollowMoneyStr.append(NSAttributedString(string: " 元", attributes: [:]))
        followMoneyLabel.attributedText = attrFollowMoneyStr

        lotteryLabel.text = order.lottery.description
    
        
        var serialString = ""
        for (index, value) in self.serialList.enumerated() {
            
            if index < 3 {
                 serialString += value.displayName
                if index != 2 && index != serialList.count-1{
                     serialString += "、"
                }
                
            }else{
                serialString += "..."
                break
            }

        }
        serialLabel.text = serialString
        if self.serialList.count > 3 {
            moreImageView.isHidden = false
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDialog))
            serialLabel.addGestureRecognizer(tapGesture)
        } else {
            moreImageView.isHidden = true

        }
        multipleLabel.text = copy.rate.decimal(2)
        orderNumLabel.text = order.orderNum
        timeLabel.text = "发单时间：\(TSUtils.timestampToString(order.createTime, withFormat: "MM-dd HH:mm"))"


    }

    /**
    *弹窗
    */
    @objc  func showDialog() {
        var titleString = "已选择过关方式："
        for (index, value) in serialList.enumerated() {
            if index != 0 {
                titleString += "、"
            }
            titleString += value.displayName
        }
        Alert().alertView(controller: self.viewContainingController()!, message: titleString, cancelAction: {}, okAction: {}, messageColor: UIColor.logo)
    }


}
