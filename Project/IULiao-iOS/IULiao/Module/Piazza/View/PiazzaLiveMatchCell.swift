//
//  PiazzaLiveMatchCell.swift
//  IULiao
//
//  Created by levine on 2017/7/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class PiazzaLiveMatchCell: UITableViewCell {

    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var awayLogo: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var birefLabel: UILabel!
    @IBOutlet weak var liaoLabel: UILabel!
    @IBOutlet weak var bLinkImageV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let img1 = R.image.fbLive.blink1()!
        let img2 = R.image.fbLive.blink2()!
        bLinkImageV.animationImages = [img1, img2]
        bLinkImageV.animationDuration = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configerContent(_ match:FBLiveMatchModel) {
        homeLabel.text = match.home//主队
        awayLabel.text = match.away//客队
       // var homeScore = ""
        var color = UIColor.black
        var birefText = ""
        var liaoText = ""
        switch match.stateType {
        case .uptHalf:
            birefText = "上半场"
            liaoText = "\(match.liveTime())  "
            color = match.stateType.color
        case .halfTime:
            birefText = "中场"
            liaoText = ""
            color = match.stateType.color
        case .downHalf:
            birefText = "下半场"
            liaoText = "\(match.liveTime())  "
            color = match.stateType.color
        case .over:
            color = match.stateType.color
            birefText = ""
            liaoText = "完场"
        case .pause:
            color = match.stateType.color
            birefText = "暂停"
            liaoText = "\(match.liveTime())  "
        default:
            break
        }
        birefLabel.text = birefText
        liaoLabel.text = liaoText
        timeLabel.textColor = color
        liaoLabel.textColor = color
        birefLabel.textColor = color
        
        if match.stateType == .notStarted {
            timeLabel.text = Date(match.matchTime).stringWithFormat("HH:mm")
            liaoLabel.text = "爆料"
            birefLabel.text = "\(match.briefCount ?? 0) 条"
            birefLabel.textColor = UIColor.orange
        }else {
            timeLabel.text = "\(match.homeScore ?? 0)"+":"+"\(match.awayScore ?? 0)"
        }
        if match.stateType == .uptHalf || match.stateType == .downHalf {
            bLinkImageV.isHidden = false
            bLinkImageV.startAnimating()
        } else {
            bLinkImageV.isHidden = true
            bLinkImageV.stopAnimating()
        }
 
        if let homeLogoStr = match.homeLogo {
            homeLogo.sd_setImage(with: TSImageURLHelper(string: homeLogoStr, w: 60, h: 60).chop().url, placeholderImage: R.image.empty.teamLogo50x50())
        }
        if let awayLogStr = match.awayLogo {
            awayLogo.sd_setImage(with: TSImageURLHelper(string: awayLogStr, w: 60, h: 60).chop().url, placeholderImage: R.image.empty.teamLogo50x50())
        }
        
        
    }
    
}
