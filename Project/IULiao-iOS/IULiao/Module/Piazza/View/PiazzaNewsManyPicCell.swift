//
//  PiazzaNewsManyPicCell.swift
//  IULiao
//
//  Created by levine on 2017/7/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class PiazzaNewsManyPicCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var fristImageV: UIImageView!
    
    @IBOutlet weak var secondImageV: UIImageView!
    
    @IBOutlet weak var thridImageV: UIImageView!
    
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
        let imgURLF = TSImageURLHelper(string: (news.coverImages?[0].urlString)! , size: CGSize(width: 300, height: 200)).chop()
        let imgURLS = TSImageURLHelper(string: (news.coverImages?[1].urlString)! , size: CGSize(width: 300, height: 200)).chop()
        let imgURLT = TSImageURLHelper(string: (news.coverImages?[2].urlString)! , size: CGSize(width: 300, height: 200)).chop()
        fristImageV.sd_setImage(with: URL(string: imgURLF.urlString), placeholderImage: R.image.empty.image150x100(), options: [.retryFailed, .progressiveDownload])
        secondImageV.sd_setImage(with: URL(string: imgURLS.urlString), placeholderImage:  R.image.empty.image150x100(), options: [.retryFailed, .progressiveDownload])
        thridImageV.sd_setImage(with: URL(string: imgURLT.urlString), placeholderImage:  R.image.empty.image150x100(), options: [.retryFailed, .progressiveDownload])
        tag = news.id
    }
    
}
