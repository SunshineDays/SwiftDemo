//
//  FBRecommendDetailAgainstInfoCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/20.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 推荐详情 足球对阵信息
class FBRecommendDetailAgainstInfoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        winButton.setTitleColor(UIColor(hex: 0x666666), for: .normal)
        winButton.setTitleColor(UIColor.white, for: .selected)
        winButton.setBackgroundColor(UIColor(hex: 0xF2F2F2), forState: .normal)
        winButton.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
        
        drawButton.setTitleColor(UIColor(hex: 0x666666), for: .normal)
        drawButton.setTitleColor(UIColor.white, for: .selected)
        drawButton.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
        
        lostButton.setTitleColor(UIColor(hex: 0x666666), for: .normal)
        lostButton.setTitleColor(UIColor.white, for: .selected)
        lostButton.setBackgroundColor(UIColor(hex: 0xF2F2F2), forState: .normal)
        lostButton.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var otherButton: UIButton!
    
    @IBOutlet weak var homeLogoImageView: UIImageView!
    
    @IBOutlet weak var awayLogoImageView: UIImageView!
    
    @IBOutlet weak var homeNameLabel: UILabel!
    
    @IBOutlet weak var awayNameLabel: UILabel!
    
    @IBOutlet weak var vsOrScoreLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var winButton: UIButton!
    
    @IBOutlet weak var drawButton: UIButton!
    
    @IBOutlet weak var lostButton: UIButton!
    
    func setupConfigView(model: FBRecommendDetailModel) {
        self.model = model
        self.matchModel = model.match
        
        if model.oddsType == .asianPlate {
            configAsia(model: model)
        }
        if model.oddsType == .sizePlate {
            configBigSmall(model: model)
        }
        if model.oddsType == .europe {
            configEurope(model: model)
        }
    }
    
    var matchModel: FBRecommendSponsorMatchModel! = nil {
        didSet {
            leagueLabel.text = matchModel.lName
            leagueLabel.textColor = UIColor(rgba: matchModel.color)
            
            if matchModel.hScore.isEmpty || matchModel.aScore.isEmpty {
                vsOrScoreLabel.text = "VS"
                vsOrScoreLabel.textColor = UIColor(hex: 0x333333)
            }
            else {
                vsOrScoreLabel.text = String(format: "%@:%@", matchModel.hScore, matchModel.aScore)
                vsOrScoreLabel.textColor = UIColor(hex: 0xFF4444)
            }
            
            if let url = TSImageURLHelper.init(string: matchModel.hLogo, w: 100, h: 100).chop(mode: .onlyResize).url {
                homeLogoImageView.sd_setImage(with: url, placeholderImage: R.image.empty.teamLogo120x120(), completed: nil)
            }
            else {
                homeLogoImageView.image = R.image.empty.teamLogo120x120()
            }
            
            if let url = TSImageURLHelper.init(string: matchModel.aLogo, w: 100, h: 100).chop(mode: .onlyResize).url {
                awayLogoImageView.sd_setImage(with: url, placeholderImage: R.image.empty.teamLogo120x120(), completed: nil)
            }
            else {
                awayLogoImageView.image = R.image.empty.teamLogo120x120()
            }
            dateLabel.text = TSUtils.timeMonthDayHourMinute(TimeInterval(matchModel.mTime), withFormat: "MM-dd HH:mm")
            homeNameLabel.text = matchModel.home
            awayNameLabel.text = matchModel.away
            
        }
    }
    
    var model: FBRecommendDetailModel! = nil {
        didSet {
            typeLabel.text = model.oddsType.message
        }
    }
    
    ///亚盘
    private func configAsia(model: FBRecommendDetailModel) {
        drawButton.setBackgroundColor(UIColor.clear, forState: .normal)
        
        let betOdds = model.betOdds
        let betOnList = model.betons
        let asia = betOdds.asia
        
        winButton.setTitle("主 \(asia.above.decimal(2))", for: .normal)
        drawButton.setTitle("\(asia.handicap)", for: .normal)
        lostButton.setTitle("客 \(asia.below.decimal(2))", for: .normal)
        
        winButton.isSelected = betOnList.contains(where: { $0.betKey == .above })
        drawButton.isSelected = betOnList.contains(where: { $0.betKey == .handicap })
        lostButton.isSelected = betOnList.contains(where: { $0.betKey == .below })
    }
    
    ///大小球
    private func configBigSmall(model: FBRecommendDetailModel) {
        drawButton.setBackgroundColor(UIColor.clear, forState: .normal)
        
        let betOdds = model.betOdds
        let betOnList = model.betons
        let bigSmall = betOdds.bigSmall
        
        winButton.setTitle("大球 \(bigSmall.big.decimal(2))", for: .normal)
        drawButton.setTitle("\(bigSmall.handicap)", for: .normal)
        lostButton.setTitle("小球 \(bigSmall.small.decimal(2))", for: .normal)
        
        winButton.isSelected = betOnList.contains(where: { $0.betKey == .big })
        drawButton.isSelected = betOnList.contains(where: { $0.betKey == .handicap })
        lostButton.isSelected = betOnList.contains(where: { $0.betKey == .small })
    }
    
    ///欧赔
    private func configEurope(model: FBRecommendDetailModel) {
        drawButton.setBackgroundColor(UIColor(hex: 0xF2F2F2), forState: .normal)
        
        let betOdds = model.betOdds
        let betOnList = model.betons
        let europe = betOdds.europe
        
        winButton.setTitle("胜 \(europe.win.decimal(2))", for: .normal)
        drawButton.setTitle("平 \(europe.draw.decimal(2))", for: .normal)
        lostButton.setTitle("负 \(europe.lost.decimal(2))", for: .normal)
        
        winButton.isSelected = betOnList.contains(where: { $0.betKey == .win })
        drawButton.isSelected = betOnList.contains(where: { $0.betKey == .draw })
        lostButton.isSelected = betOnList.contains(where: { $0.betKey == .lost })
    }
    
    
    
}
