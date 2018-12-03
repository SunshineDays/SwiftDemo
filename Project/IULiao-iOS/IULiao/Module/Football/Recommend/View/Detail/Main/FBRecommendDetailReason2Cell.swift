//
//  FBRecommendDetailReason2Cell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/20.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 推荐详情 推荐理由
class FBRecommendDetailReason2Cell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var pollUpButton: UIButton!
    
    @IBOutlet weak var pollDownButton: UIButton!
    
    @IBOutlet weak var pollUpLabel: UILabel!
    
    @IBOutlet weak var pollDownLabel: UILabel!
    
    @IBOutlet weak var reasonLabel: UILabel!
    
    func setupConfigView(model: FBRecommendDetailModel) {
        
        reasonLabel.text = model.reason == "" ? "这家伙很懒，什么都没留下..." : model.reason
        
        pollUpLabel.text = String(format: "%d", model.pollUp)
        pollDownLabel.text = String(format: "%d", model.pollDown)
        
        pollUpButton.setBackgroundColor(model.pollScore == 1 ? UIColor(hex: 0xFF4444) : UIColor(hex: 0xCCCCCC), forState: .normal)
        pollDownButton.setBackgroundColor(model.pollScore == -1 ? UIColor(hex: 0x3366CC) : UIColor(hex: 0xCCCCCC), forState: .normal)
        
        pollUpButton.isUserInteractionEnabled = model.pollScore == 0
        pollDownButton.isUserInteractionEnabled = model.pollScore == 0
        
    }
    
}
