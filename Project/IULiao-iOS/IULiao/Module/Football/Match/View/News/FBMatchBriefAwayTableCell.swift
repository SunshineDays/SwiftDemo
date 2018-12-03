//
//  FBMatchBriefAwayTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 爆料 客队
class FBMatchBriefAwayTableCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var preponderantLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    func configCell(news: NewsBriefModel, teamLogo: String?) {
        if let logo = TSImageURLHelper(string: teamLogo, w: 80, h: 80).chop(mode: .fillCrop).url {
            logoImageView.sd_setImage(with: logo, placeholderImage: R.image.empty.image40x40())
        }
        titleLabel.text = news.title
        contentLabel.text = news.content
        
        if let cover = TSImageURLHelper(string: news.img, w: 600, h: 400).chop(mode: .alwayCrop).url {
            coverImageView.isHidden = false
            coverImageView.sd_setImage(with: cover, placeholderImage: R.image.empty.image375x225())
            titleLabelTopConstraint.constant = coverImageView.height + 8
        } else {
            coverImageView.isHidden = true
            titleLabelTopConstraint.constant = 0
        }
        
        // 主客队的优势颜色不同
        var color = TSColor.gray.gamut666666
        if news.compare == .preponderant {
            color = TSColor.matchResult.lost
        }
        let attrString1 = NSAttributedString(string: news.compare.description, attributes: [.foregroundColor: color])
        let attrString2 = NSAttributedString(string: "·", attributes: [.foregroundColor: TSColor.gray.gamut666666])
        let attrString3 = NSAttributedString(string: news.taxonomy.name, attributes: [.foregroundColor: TSColor.gray.gamut333333])
        
        let attrString = NSMutableAttributedString()
        attrString.append(attrString1)
        attrString.append(attrString2)
        attrString.append(attrString3)
        preponderantLabel.attributedText = attrString
        
    }
}

