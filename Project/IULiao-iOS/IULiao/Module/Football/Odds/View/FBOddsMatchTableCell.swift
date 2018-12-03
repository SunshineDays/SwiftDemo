//
//  FBOddsMatchTableCell.swift
//  IULiao
//
//  Created by tianshui on 16/7/29.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class FBOddsMatchTableCell: UITableViewCell {

    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var oddsView: UIView!
    @IBOutlet weak var initWinLabel: UILabel!
    @IBOutlet weak var initDrawLabel: UILabel!
    @IBOutlet weak var initLostLabel: UILabel!
    
    @IBOutlet weak var lastWinLabel: UILabel!
    @IBOutlet weak var lastDrawLabel: UILabel!
    @IBOutlet weak var lastLostLabel: UILabel!
    
    @IBOutlet weak var sameButton: UIButton!
    
    func configCell(company: CompanyModel, europe: FBOddsEuropeSetModel?) {
        
        companyLabel.text = company.name
        
        guard let europe = europe else {
            configCellEmptyOdds()
            return
        }
        
        sameButton.isEnabled = true
        
        let initOdds = europe.initOdds
        if initOdds.isAvailable {
            initWinLabel.text  = initOdds.win.decimal(2)
            initDrawLabel.text = initOdds.draw.decimal(2)
            initLostLabel.text = initOdds.lost.decimal(2)
        } else {
            configCellEmptyOdds()
        }
        
        let lastOdds = europe.lastOdds
        if lastOdds.isAvailable {
            lastWinLabel.text  = lastOdds.win.decimal(2)
            lastDrawLabel.text = lastOdds.draw.decimal(2)
            lastLostLabel.text = lastOdds.lost.decimal(2)
            lastWinLabel.textColor  = FBColorType(num: europe.winTrend).color
            lastDrawLabel.textColor = FBColorType(num: europe.drawTrend).color
            lastLostLabel.textColor = FBColorType(num: europe.lostTrend).color
        } else {
            configCellEmptyOdds()
        }
    
    }
    
    func configCell(company: CompanyModel, asia: FBOddsAsiaSetModel?) {
        
        companyLabel.text = company.name
        
        guard let asia = asia else {
            configCellEmptyOdds()
            return
        }
        
        sameButton.isEnabled = true
        
        let initOdds = asia.initOdds
        if initOdds.isAvailable {
            initWinLabel.text  = initOdds.above.decimal(3)
            initDrawLabel.text = initOdds.handicap
            initLostLabel.text = initOdds.below.decimal(3)
        } else {
            configCellEmptyOdds()
        }
        
        let lastOdds = asia.lastOdds
        if lastOdds.isAvailable {
            lastWinLabel.text  = lastOdds.above.decimal(3)
            lastDrawLabel.text = lastOdds.handicap
            lastLostLabel.text = lastOdds.below.decimal(3)
            lastWinLabel.textColor  = FBColorType(num: asia.aboveTrend).color
            lastDrawLabel.textColor = FBColorType(num: asia.handicapTrend).color
            lastLostLabel.textColor = FBColorType(num: asia.belowTrend).color
        } else {
            configCellEmptyOdds()
        }
    }
    
    private func configCellEmptyOdds() {
        initWinLabel.text  = "-"
        initDrawLabel.text = "-"
        initLostLabel.text = "-"
        
        lastWinLabel.text  = "-"
        lastDrawLabel.text = "-"
        lastLostLabel.text = "-"
        
        lastWinLabel.textColor  = UIColor.black
        lastDrawLabel.textColor = UIColor.black
        lastLostLabel.textColor = UIColor.black
        
        sameButton.isEnabled = false
    }
}
