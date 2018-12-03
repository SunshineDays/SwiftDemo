//
//  FBLiaoH1ImageTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/7/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 料 第一条 图片
class FBLiaoH1ImageTableCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(brief: FBLiaoBriefModel, match: FBMatchModel) {
        titleLabel.text = brief.title
        let team = brief.tid == match.homeTid ? "主队" : "客队"
        categoryLabel.text = "\(team)·\(brief.taxonomy.name)"
        
        if brief.imgUrl != nil {
            let url = TSImageURLHelper(string: brief.img, w: 800, h: 400).chop().url
            coverImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image400x200())
        }
    }

}
