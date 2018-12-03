//
//  FBMatchOddsAsiaListTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 亚盘cell
class FBMatchOddsAsiaListTableCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyTypeLabel: UILabel!
    
    @IBOutlet weak var aboveInitLabel: UILabel!
    @IBOutlet weak var aboveLastLabel: UILabel!
    @IBOutlet weak var belowInitLabel: UILabel!
    @IBOutlet weak var belowLastLabel: UILabel!
    @IBOutlet weak var handicapInitLabel: UILabel!
    @IBOutlet weak var handicapLastLabel: UILabel!
    
    @IBOutlet weak var companyNameLabelXConstraint: NSLayoutConstraint!
    
    private var needBackgroundColor = false
    
    /// 亚盘
    func configCell(asia: FBOddsAsiaSetModel, needBackgroundColor: Bool) {
        configCommon(company: asia.company, needBackgroundColor: needBackgroundColor)
        
        let initOdds = asia.initOdds
        let lastOdds = asia.lastOdds
        aboveInitLabel.text = initOdds.above.decimal(2)
        belowInitLabel.text = initOdds.below.decimal(2)
        handicapInitLabel.text = initOdds.handicap
        
        aboveLastLabel.text = lastOdds.above.decimal(2)
        belowLastLabel.text = lastOdds.below.decimal(2)
        handicapLastLabel.text = lastOdds.handicap
        
        aboveLastLabel.textColor = TSOddsHelper.trendColor(trend: asia.aboveTrend)
        belowLastLabel.textColor = TSOddsHelper.trendColor(trend: asia.belowTrend)
        handicapLastLabel.textColor = TSOddsHelper.trendColor(trend: Double(asia.handicapTrend))
    }
    
    /// 大小球
    func configCell(bigSmall: FBOddsBigSmallSetModel, needBackgroundColor: Bool) {
        configCommon(company: bigSmall.company, needBackgroundColor: needBackgroundColor)
        
        let initOdds = bigSmall.initOdds
        let lastOdds = bigSmall.lastOdds
        aboveInitLabel.text = initOdds.big.decimal(2)
        belowInitLabel.text = initOdds.small.decimal(2)
        handicapInitLabel.text = initOdds.handicap
        
        aboveLastLabel.text = lastOdds.big.decimal(2)
        belowLastLabel.text = lastOdds.small.decimal(2)
        handicapLastLabel.text = lastOdds.handicap
        
        aboveLastLabel.textColor = TSOddsHelper.trendColor(trend: bigSmall.bigTrend)
        belowLastLabel.textColor = TSOddsHelper.trendColor(trend: bigSmall.smallTrend)
        handicapLastLabel.textColor = TSOddsHelper.trendColor(trend: Double(bigSmall.handicapTrend))
    }
    
    private func configCommon(company: CompanyModel, needBackgroundColor: Bool) {
        self.needBackgroundColor = needBackgroundColor
        contentView.backgroundColor = needBackgroundColor ? TSColor.cellEachBackgroud : UIColor.white
        
        companyNameLabel.text = company.name
        
        let companyType = company.companyType
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
