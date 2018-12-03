//
//  FBRecommendDetailCommentTitleView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/9.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 推荐详情 评论头视图
class FBRecommendDetailCommentTitleView: UIView {

    @IBOutlet weak var avaterImageView: UIImageView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var inputButton: UIButton!
    
    @IBOutlet weak var pollUpButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: 100)
    }
    
    @IBAction func inputButtonAction(_ sender: UIButton) {
    
    }
    
    @IBAction func pollUpButtonAction(_ sender: UIButton) {
        
    }
    
    var model: CommonTopicModel! = nil {
        didSet {
            if let url = TSImageURLHelper.init(string: model.user.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
                avaterImageView.sd_setImage(with: url, placeholderImage: R.image.fbRecommend2.avatar60x60(), completed: nil)
            }
            else {
                avaterImageView.image = R.image.fbRecommend2.avatar60x60()
            }
            nicknameLabel.text = model.user.nickName
            
            timeLabel.text = TSUtils.timestampToString(model.created)
            
            contentLabel.text = model.content
            
            inputButton.setTitle(String(format: "%d", model.children.count), for: .normal)
            pollUpButton.setTitle(String(format: "%d", model.pollUp), for: .normal)
            if model.pollScore == 1 {
                pollUpButton.setImage(R.image.common.pollupSelect(), for: .normal)
            }
            else {
                pollUpButton.setImage(R.image.common.pollupNormal(), for: .normal)
            }
        }
    }
    
}
