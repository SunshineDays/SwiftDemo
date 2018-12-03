//
//  RecommendExpertCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class RecommendExpertCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var matchTimeLabel: UILabel!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var lookNumberLabel: UILabel!
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    static var defaultHeight: CGFloat = 140
    
    public func comfigCell(model: RecommendExpertListModel) {
        titleLabel.text = "【" + model.serial + "】" + model.title
        titleLabel.textColor = UIColor(hex: 0x4D4D4D)

        leagueLabel.text = model.matchInfo.leagueName
        leagueLabel.textColor = model.matchInfo.color
        
        if model.matchInfo.saleStatus == .delay {
            matchTimeLabel.text = "延期"
            matchTimeLabel.textColor = UIColor(hex: 0x3E66EE)
        } else {
            matchTimeLabel.text = TSUtils.timestampToString(model.matchInfo.matchTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
            matchTimeLabel.textColor = UIColor(hex: 0x4D4D4D)
        }

        homeTeamLabel.text = model.matchInfo.home
        homeTeamLabel.textColor = UIColor(hex: 0x4D4D4D)
        awayTeamLabel.text = model.matchInfo.away
        awayTeamLabel.textColor = UIColor(hex: 0x4D4D4D)
        if model.winStatus != .notOpen {
            scoreLabel.attributedText = TSPublicTool.attributedString(texts: [model.matchInfo.score ?? "0:0", "(半\(model.matchInfo.halfScore ?? "0:0"))"],
                                                                      fonts: [UIFont.systemFont(ofSize: 12), UIFont.systemFont(ofSize: 10)],
                                                                      colors: [UIColor(hex: 0xFF4422), UIColor(hex: 0xB3B3B3)])
            updateTimeLabel.text = model.codeString
            updateTimeLabel.textColor = UIColor(hex: 0xFF4422)
            updateTimeLabel.font = UIFont.systemFont(ofSize: 12)
        } else {
            scoreLabel.text = "VS"
            scoreLabel.textColor = UIColor(hex: 0x4D4D4D)
            updateTimeLabel.text = "更新时间：" + TSUtils.timestampToString(model.updateTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
            updateTimeLabel.textColor = UIColor(hex: 0xB3B3B3)
            updateTimeLabel.font = UIFont.systemFont(ofSize: 10)
        }
        
        lookNumberLabel.text = model.hits.string()
        
        resultImageView.image = model.winStatus.image
        
        if !model.isShow {
            titleLabel.textColor = UIColor(hex: 0xB3B3B3)
            leagueLabel.textColor = UIColor(hex: 0xB3B3B3)
            matchTimeLabel.textColor = UIColor(hex: 0xB3B3B3)
            homeTeamLabel.textColor = UIColor(hex: 0xB3B3B3)
            awayTeamLabel.textColor = UIColor(hex: 0xB3B3B3)
            scoreLabel.textColor = UIColor(hex: 0xB3B3B3)
            updateTimeLabel.textColor = UIColor(hex: 0xB3B3B3)
            lookNumberLabel.textColor = UIColor(hex: 0xB3B3B3)
            resultImageView.image = R.image.recommend_result_giveup()
        }
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
