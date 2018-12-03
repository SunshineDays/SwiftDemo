//
//  PiazzaHeaderContentView.swift
//  IULiao
//
//  Created by levine on 2017/7/28.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
protocol PiazzaHeaderContentViewDelegate:class {
    func clickAction(_ piazzaHeaderContentView:PiazzaHeaderContentView,clickAction button:UIButton)
}
class PiazzaHeaderContentView: UIView {

    
    weak var delegate: PiazzaHeaderContentViewDelegate?
    @IBOutlet weak var serialLabel: UILabel!
    
    @IBOutlet weak var leagueLabel: UILabel!//联赛
    
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var awayLabel: UILabel!
    
    @IBOutlet weak var homeLogo: UIImageView!
    
    @IBOutlet weak var awayLogo: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var teamLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func configContent(birefModel:PiazzaBirefModel,matchModel:FBLiveMatchModel) {
        
        serialLabel.text = matchModel.serial
        leagueLabel.text = matchModel.league.name
        leagueLabel.textColor = matchModel.league.color
        homeLabel.text = matchModel.home
        awayLabel.text = matchModel.away
        timeLabel.text = Date(matchModel.matchTime).stringWithFormat("HH:mm")
        if let homeLogoStr = matchModel.homeLogo {
            homeLogo.sd_setImage(with: TSImageURLHelper(string: homeLogoStr, w: 60, h: 60).chop().url, placeholderImage: R.image.empty.teamLogo50x50())
        }
        if let awayLogStr = matchModel.awayLogo {
            awayLogo.sd_setImage(with: TSImageURLHelper(string: awayLogStr, w: 60, h: 60).chop().url, placeholderImage: R.image.empty.teamLogo50x50())
        }
        messageLabel.text = birefModel.title
        if birefModel.tid == matchModel.homeTid {
            teamLabel.text  = "主队·信息"
        }else {
            teamLabel.text = "客队·信息"
        }
        contentLabel.text = birefModel.content
        
        
    }
    @IBAction func clickAction(_ sender: UIButton) {
        delegate?.clickAction(self, clickAction: sender)
//      

    }
    

}
