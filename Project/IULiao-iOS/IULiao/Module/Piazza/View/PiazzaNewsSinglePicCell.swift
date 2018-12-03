//
//  PiazzaNewsSinglePicCell.swift
//  IULiao
//
//  Created by levine on 2017/7/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class PiazzaNewsSinglePicCell: UITableViewCell {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCelContent(_ news:NewsModel) {
        titleLabel.text = news.title
        let imgURl = TSImageURLHelper(string: news.img, size: CGSize(width: 800, height: 400)).chop()
        imageV.sd_setImage(with: URL(string: imgURl.urlString), placeholderImage: R.image.empty.image400x200(), options: .progressiveDownload)
        tag = news.id
    }
    
}
