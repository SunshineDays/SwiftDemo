//
//  FBRecommendExpertRecordCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/11.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 专家页 成绩单 UITableViewCell
class FBRecommendExpertRecordCell: UITableViewCell {

    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var teamHomeLabel: UILabel!
    
    @IBOutlet weak var teamAwayLabel: UILabel!
    
    @IBOutlet weak var vsLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var winButton: UIButton!
    
    @IBOutlet weak var drawButton: UIButton!
    
    @IBOutlet weak var lostButton: UIButton!
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var reasonLabel: UILabel!
    
    @IBOutlet weak var letBallLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    func setupConfigView(model: FBRecommendExpertHistoryListModel) {
        leagueLabel.text = model.match.lName
        leagueLabel.textColor = UIColor(rgba: model.match.color)
        teamHomeLabel.text = model.match.home
        teamAwayLabel.text = model.match.away
        if model.match.hScore.isEmpty || model.match.aScore.isEmpty {
            vsLabel.text = "VS"
            vsLabel.textColor = UIColor(hex: 0x333333)
        }
        else {
            vsLabel.text = String(format: "%@ : %@", model.match.hScore, model.match.aScore)
            vsLabel.textColor = UIColor(hex: 0xFF4444)
        }
        dateLabel.text = TSUtils.timeMonthDayHourMinute(TimeInterval(model.match.mTime), withFormat: "MM-dd")
        timeLabel.text = TSUtils.timeMonthDayHourMinute(TimeInterval(model.match.mTime), withFormat: "HH:mm")
        
        if model.oddsType == .asianPlate {
            configAsia(model: model)
        }
        if model.oddsType == .sizePlate {
            configBigSmall(model: model)
        }
        if model.oddsType == .europe {
            configEurope(model: model)
        }
        
        
        letBallLabel.text = model.betOdds.letBall > 0 ? String(format: "+%d", model.betOdds.letBall) : (model.betOdds.letBall < 0 ? String(format: "%d", model.betOdds.letBall) : "")
        letBallLabel.textColor = model.betOdds.letBall > 0 ? UIColor(hex: 0xFF3333) : UIColor(hex: 0x009933)
        
        reasonLabel.text = model.reason != "" ? "理据" : ""
        if model.result != .noOpen {
            resultImageView.image = model.result.jingCaiImage
        }
        else {
            resultImageView.image = nil
        }
        
    }
    
    ///亚盘
    private func configAsia(model: FBRecommendExpertHistoryListModel) {
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
    private func configBigSmall(model: FBRecommendExpertHistoryListModel) {
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
    private func configEurope(model: FBRecommendExpertHistoryListModel) {
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
