//
//  FBRecommendSponsorMatchJingcaiCell.swift
//  IULiao
//
//  Created by bin zhang on 2018/5/2.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 竞彩 赛事选择 UITableViewCell
class FBRecommendSponsorMatchJingcaiCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        let buttons = [winButton, drawButton, lostButton, letWinButton, letDrawButton, letLostButton]
        for button in buttons {
            button?.setTitleColor(UIColor(hex: 0x666666), for: .normal)
            button?.setTitleColor(UIColor.white, for: .selected)
            button?.setBackgroundColor(UIColor.white, forState: .normal)
            button?.setBackgroundColor(UIColor(hex: 0xFC9A39), forState: .selected)
            
            button?.addTarget(self, action: #selector(selectAction(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var AwayTeamLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    
    @IBOutlet weak var spfFixedLabel: UILabel!
    @IBOutlet weak var rqspfFixedLabel: UILabel!
    
    @IBOutlet weak var letBall1Label: UILabel!
    @IBOutlet weak var letBall2Label: UILabel!
    
    @IBOutlet weak var winButton: UIButton!
    @IBOutlet weak var letWinButton: UIButton!
    
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var letDrawButton: UIButton!
    
    @IBOutlet weak var lostButton: UIButton!
    @IBOutlet weak var letLostButton: UIButton!
    
    public var selectedType: ((_ button: UIButton) -> Void)?
    
    public var selectedModelType: ((_ sender: UIButton, _ model: FBRecommendSponsorMatchModel) -> Void)?
    
    public func setupConfigView(model: FBRecommendSponsorMatchModel) {
        self.model = model
        dateLabel.text = model.serial
        leagueLabel.text = model.lName
        leagueLabel.textColor = UIColor(rgba: model.color)
        timeLabel.text = TSUtils.timeMonthDayHourMinute(TimeInterval(model.mTime), withFormat: "HH:mm")
        
        homeTeamLabel.text = model.home
        AwayTeamLabel.text = model.away
        
        type1Label.text = model.spfFixed == 1 && model.spfSingle == 1 ? "单" : ""
        type2Label.text = model.rqspfFixed == 1 && model.rqspfSingle == 1 ? "单" : ""
        
        spfFixedLabel.isHidden = model.spfFixed == 1
        winButton.isHidden = model.spfFixed != 1
        drawButton.isHidden = model.spfFixed != 1
        lostButton.isHidden = model.spfFixed != 1

        rqspfFixedLabel.isHidden = model.rqspfFixed == 1
        letWinButton.isHidden = model.rqspfFixed != 1
        letDrawButton.isHidden = model.rqspfFixed != 1
        letLostButton.isHidden = model.rqspfFixed != 1
        
        letBall1Label.text = "0"
        letBall2Label.text = model.odds.letBall > 0 ? ("+" + "\(model.odds.letBall)") : "\(model.odds.letBall)"
        letBall2Label.backgroundColor = model.odds.letBall > 0 ? UIColor(hex: 0xFC6D65) : UIColor(hex: 0x65B1FC)
        
        winButton.setTitle("胜" + model.odds.win.decimal(2), for: .normal)
        letWinButton.setTitle("胜" + model.odds.letWin.decimal(2), for: .normal)
        
        drawButton.setTitle("平" + model.odds.draw.decimal(2), for: .normal)
        letDrawButton.setTitle("平" + model.odds.letDraw.decimal(2), for: .normal)
        
        lostButton.setTitle("负" + model.odds.lost.decimal(2), for: .normal)
        letLostButton.setTitle("负" + model.odds.letLost.decimal(2), for: .normal)

        winButton.isSelected = model.selectedType.isWin
        letWinButton.isSelected = model.selectedType.isLetWin
        
        drawButton.isSelected = model.selectedType.isDraw
        letDrawButton.isSelected = model.selectedType.isLetDraw
        
        lostButton.isSelected = model.selectedType.isLost
        letLostButton.isSelected = model.selectedType.isLetLost

    }

    private var model: FBRecommendSponsorMatchModel?
    
    @objc private func selectAction(_ sender: UIButton) {
//        selectedType?(sender)
        var selectedModel: FBRecommendSponsorMatchModel?
        
        selectedModel = self.model
        
        switch sender {
        case winButton:
            selectedModel?.selectedType.isWin = !(selectedModel?.selectedType.isWin)!
        case drawButton:
            selectedModel?.selectedType.isDraw = !(selectedModel?.selectedType.isDraw)!
        case lostButton:
            selectedModel?.selectedType.isLost = !(selectedModel?.selectedType.isLost)!
        case letWinButton:
            selectedModel?.selectedType.isLetWin = !(selectedModel?.selectedType.isLetWin)!
        case letDrawButton:
            selectedModel?.selectedType.isLetDraw = !(selectedModel?.selectedType.isLetDraw)!
        case letLostButton:
            selectedModel?.selectedType.isLetLost = !(selectedModel?.selectedType.isLetLost)!
        default:
            break
        }
        
        selectedModelType?(sender, selectedModel!)
  
    }
    
    
}
