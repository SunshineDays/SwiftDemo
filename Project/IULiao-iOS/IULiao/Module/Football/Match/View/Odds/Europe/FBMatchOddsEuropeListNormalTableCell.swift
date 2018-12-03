//
//  FBMatchOddsEuropeListNormalTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/11.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 欧赔 普通cell
class FBMatchOddsEuropeListNormalTableCell: UITableViewCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyTypeLabel: UILabel!
    
    @IBOutlet weak var winFirstLabel: UILabel!
    @IBOutlet weak var winSecondLabel: UILabel!
    @IBOutlet weak var drawFirstLabel: UILabel!
    @IBOutlet weak var drawSecondLabel: UILabel!
    @IBOutlet weak var lostFirstLabel: UILabel!
    @IBOutlet weak var lostSecondLabel: UILabel!
    
    @IBOutlet weak var returnRateLabel: UILabel!
    
    @IBOutlet weak var companyNameLabelXConstraint: NSLayoutConstraint!
    
    private var needBackgroundColor = false
    
    func configCell(europe: FBOddsEuropeSetModel, cellType: FBMatchOddsEuropeListViewController.CellType, europe99Odds: FBOddsEuropeModel, jingcaiOdds: FBOddsEuropeModel, needBackgroundColor: Bool) {
        
        self.needBackgroundColor = needBackgroundColor
        contentView.backgroundColor = needBackgroundColor ? TSColor.cellEachBackgroud : UIColor.white
        
        companyNameLabel.text = europe.company.name
        
        let companyType = europe.company.companyType
        switch companyType {
        case .major, .bourse:
            companyTypeLabel.text = companyType.description
            companyTypeLabel.backgroundColor = companyType.color
            companyNameLabelXConstraint.constant = -8
            companyTypeLabel.isHidden = false
        default:
            companyNameLabelXConstraint.constant = 0
            companyTypeLabel.isHidden = true
        }
        
        
        let lastOdds = europe.lastOdds
        let lastReturnRate = lastOdds.returnRate
        winFirstLabel.text = lastOdds.win.decimal(2)
        winFirstLabel.textColor = TSOddsHelper.trendColor(trend: europe.winTrend)
        
        drawFirstLabel.text = lastOdds.draw.decimal(2)
        drawFirstLabel.textColor = TSOddsHelper.trendColor(trend: europe.drawTrend)
        
        lostFirstLabel.text = lastOdds.lost.decimal(2)
        lostFirstLabel.textColor = TSOddsHelper.trendColor(trend: europe.lostTrend)
        
        returnRateLabel.text = (lastReturnRate * 100).decimal(2)
        
        switch cellType {
        case .probability:
            winSecondLabel.text = (lastOdds.winPercent * 100).decimal(1) + "%"
            drawSecondLabel.text = (lastOdds.drawPercent * 100).decimal(1) + "%"
            lostSecondLabel.text = (lastOdds.lostPercent * 100).decimal(1) + "%"
        case .initOdds:
            let initOdds = europe.initOdds
            winSecondLabel.text = initOdds.win.decimal(2)
            drawSecondLabel.text = initOdds.draw.decimal(2)
            lostSecondLabel.text = initOdds.lost.decimal(2)
        case .kelly:
            winSecondLabel.text = lastOdds.winKelly(europe99: europe99Odds).decimal(4)
            drawSecondLabel.text = lastOdds.drawKelly(europe99: europe99Odds).decimal(4)
            lostSecondLabel.text = lastOdds.lostKelly(europe99: europe99Odds).decimal(4)
        case .jingcai:
            
            if jingcaiOdds.winPercent > 0 {
                winSecondLabel.text = (jingcaiOdds.returnRate / lastOdds.winPercent).decimal(2)
            } else {
                winSecondLabel.text = "-"
            }
            if jingcaiOdds.drawPercent > 0 {
                drawSecondLabel.text = (jingcaiOdds.returnRate / lastOdds.drawPercent).decimal(2)
            } else {
                drawSecondLabel.text = "-"
            }
            if jingcaiOdds.lostPercent > 0 {
                lostSecondLabel.text = (jingcaiOdds.returnRate / lastOdds.lostPercent).decimal(2)
            } else {
                lostSecondLabel.text = "-"
            }
        }
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            contentView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            UIView.animate(
                withDuration: 0.1,
                delay: 0.1,
                options: .curveEaseInOut,
                animations: {
                    self.contentView.backgroundColor = self.needBackgroundColor ? TSColor.cellEachBackgroud : UIColor.white
            },
                completion: nil
            )
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            contentView.backgroundColor = TSColor.cellHighlightedBackground
        } else {
            contentView.backgroundColor = needBackgroundColor ? TSColor.cellEachBackgroud : UIColor.white
        }
    }
}
