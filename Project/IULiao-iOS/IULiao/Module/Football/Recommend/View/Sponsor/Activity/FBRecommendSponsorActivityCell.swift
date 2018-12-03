//
//  FBRecommendSponsorActivityCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 精彩活动
class FBRecommendSponsorActivityCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setupConfigView(model: FBRecommendSponsorActivityNewsModel) {
        titleLabel.text = model.title
    }
    
}
