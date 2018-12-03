//
//  NewsOrdinaryCell.swift
//  HuaXia
//
//  Created by tianshui on 15/10/12.
//  Copyright © 2015年 fenlan. All rights reserved.
//

import UIKit

/// 资讯 普通列表cell
class NewsOrdinaryCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    func configCell(news: NewsModel) {
        titleLabel.text = news.title
        timeLabel.text = news.time
        let tags = news.tags
        tagLabel.text = tags[0..<(min(tags.count, 3))].joined(separator: "  ")
        
        let imgUrl = TSImageURLHelper(string: news.img, size: listImageSize).chop()

        imgView.sd_setImage(with: URL(string: imgUrl.urlString), placeholderImage: R.image.empty.image120x90(), options: [.retryFailed, .progressiveDownload])
        tag = news.id
    }
}
