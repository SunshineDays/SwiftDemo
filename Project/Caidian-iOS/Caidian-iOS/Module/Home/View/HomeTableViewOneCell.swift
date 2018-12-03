//
//  HomeTableViewOneCell.swift
//  Caidian-iOS
//
//  Created by levine on 2018/4/19.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 购彩大厅 新闻单图cell
class HomeTableViewOneCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!



    func configCell(news: NewsModel) {
        let imgURL = TSImageURLHelper(string: news.img, size: CGSize(width: 200, height: 150)).chop()
        img.sd_setImage(with: URL(string: imgURL.urlString), placeholderImage: R.image.empty.image150x100(), options: [.retryFailed, .progressiveDownload])
        titleLabel.text = news.title

        timeLabel.text = news.createTime
        tagLabel.isHidden = true

    }

}
