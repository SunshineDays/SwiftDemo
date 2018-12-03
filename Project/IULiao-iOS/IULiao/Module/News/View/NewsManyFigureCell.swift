//
//  NewsManyFigureCell.swift
//  IULiao
//
//  Created by levine on 2017/7/26.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class NewsManyFigureCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageF: UIImageView!
    @IBOutlet weak var imageS: UIImageView!
    
    @IBOutlet weak var imageT: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var hitsLabel: UILabel!
    func configCell(news: NewsModel)
    {
        titleLabel.text = news.title
        timeLabel.text = news.time
        hitsLabel.text = String(news.hits)
        let imgURLF = TSImageURLHelper(string: (news.coverImages?[0].urlString)! , size: CGSize(width: 200, height: 150)).chop()
        let imgURLS = TSImageURLHelper(string: (news.coverImages?[1].urlString)! , size: CGSize(width: 200, height: 150)).chop()
        let imgURLT = TSImageURLHelper(string: (news.coverImages?[2].urlString)! , size: CGSize(width: 200, height: 150)).chop()
        imageF.sd_setImage(with: URL(string: imgURLF.urlString), placeholderImage: R.image.empty.image150x100(), options: [.retryFailed, .progressiveDownload])
        imageS.sd_setImage(with: URL(string: imgURLS.urlString), placeholderImage:  R.image.empty.image150x100(), options: [.retryFailed, .progressiveDownload])
        imageT.sd_setImage(with: URL(string: imgURLT.urlString), placeholderImage:  R.image.empty.image150x100(), options: [.retryFailed, .progressiveDownload])

        tag = news.id
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
