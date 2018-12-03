//
//  FBRecommendDetailCommentContentCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/9.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 推荐详情 评论 UITableViewCell
class FBRecommendDetailCommentContentCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model: CommonTopicModel! = nil {
        didSet {
            contentLabel.text = String(format: "%@：%@", model.user.nickName, model.content)
        }
    }
    
}
