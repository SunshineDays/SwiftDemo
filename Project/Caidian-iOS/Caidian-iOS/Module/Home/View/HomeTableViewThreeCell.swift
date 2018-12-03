//
//  HomeTableViewThreeCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/17.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SDWebImage


/// 今日热单 的cell
class HomeTableViewThreeCell: UITableViewCell {

    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var todayHotImageView: UIImageView!
    @IBOutlet weak var payOffLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    /// 跟单回调
    var followOrderBlock: ((_ btn: UIButton) -> Void)?
    /// 头像
    var avatarBlock: ((_ btn: UIButton) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarButton.layer.cornerRadius = 20
        avatarButton.layer.masksToBounds = true
        
        // 选择器的颜色值
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10)], for: .normal)
    }

    @IBAction func avatarAction(_ sender: UIButton) {
        avatarBlock?(sender)
    }
    /// 立即跟单
    @IBAction func followOrderAction(_ sender: UIButton) {
        followOrderBlock?(sender)
    }

    func configCell(copyOrderModel: CopyOrderModel, isHideHotImage: Bool = true) {
        if isHideHotImage {
            self.backgroundColor = UIColor.white
        }
        
        if let url = TSImageURLHelper.init(string: copyOrderModel.userAvatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
            avatarButton.sd_setImage(with: url, for: .normal)
        } else {
            avatarButton.setImage(R.image.empty.image50x50(), for: .normal)
        }
        
        userNameLabel.text = copyOrderModel.userName
        payOffLabel.text = "\(copyOrderModel.rate.decimal(2))倍"
        moneyLabel.text = "\(copyOrderModel.totalMoney.moneyText())"
        countLabel.text = "\(copyOrderModel.follow)"
        todayHotImageView.isHidden = isHideHotImage
        segmentedControl.setTitle("近\(copyOrderModel.weekStatistics.orderCount)单", forSegmentAt: 0)
        segmentedControl.setTitle("\(copyOrderModel.weekStatistics.orderCount)中\(copyOrderModel.weekStatistics.winCount)", forSegmentAt: 1)
        timeLabel.text = "截止：\(TSUtils.timestampToString(copyOrderModel.endTime, withFormat: "MM-dd HH:mm", isIntelligent: false))"
    }

}
