//
//  FBMatchNewsTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 爆料 相关新闻
class FBMatchNewsTableCell: UITableViewCell {

    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configView(news: NewsBriefModel) {
        titleLabel.text = news.title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backgroundColor = TSColor.cellHighlightedBackground
        } else {
            backgroundColor = UIColor.white
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            backgroundColor = TSColor.cellHighlightedBackground
        } else {
            UIView.animate(
                withDuration: 0.1,
                delay: 0.1,
                options: .curveEaseInOut,
                animations: {
                    self.backgroundColor = UIColor.white
            },
                completion: nil
            )
        }
    }
}
