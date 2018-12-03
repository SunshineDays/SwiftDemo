//
//  FBPlayerStatisticTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/11/17.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 球员统计 条目
class FBPlayerStatisticTableCell: UITableViewCell {

    @IBOutlet weak var statisticNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func configCell(statisticName: String, value: String) {
        statisticNameLabel.text = statisticName
        valueLabel.text = value
    }
}
