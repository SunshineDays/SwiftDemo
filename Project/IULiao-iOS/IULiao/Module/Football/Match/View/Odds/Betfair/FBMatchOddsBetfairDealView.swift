//
//  FBMatchOddsBetfairDealView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 必发成交量
class FBMatchOddsBetfairDealView: UIView {
    
    @IBOutlet weak var winPriceLabel: UILabel!
    @IBOutlet weak var winVolumeLabel: UILabel!
    @IBOutlet weak var winProfitLabel: UILabel!
    
    @IBOutlet weak var drawPriceLabel: UILabel!
    @IBOutlet weak var drawVolumeLabel: UILabel!
    @IBOutlet weak var drawProfitLabel: UILabel!
    
    @IBOutlet weak var lostPriceLabel: UILabel!
    @IBOutlet weak var lostVolumeLabel: UILabel!
    @IBOutlet weak var lostProfitLabel: UILabel!

    func configView(betfair: FBMatchOddsBetfairDataModel) {
        let winDeal = betfair.winStatistics.deal
        let drawDeal = betfair.drawStatistics.deal
        let lostDeal = betfair.lostStatistics.deal
        
        guard winDeal.price > 0 && drawDeal.price > 0 && lostDeal.price > 0 else {
            return
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        let totalVolume = betfair.totalVolume
        
        let winProfit = Int(totalVolume - winDeal.volume * winDeal.price)
        winPriceLabel.text = winDeal.price.decimal(2)
        winVolumeLabel.text = formatter.string(for: winDeal.volume)
        winProfitLabel.text = formatter.string(for: winProfit)
        winProfitLabel.textColor = winProfit < 0 ? TSColor.matchResult.draw : TSColor.matchResult.win
        
        let drawProfit = Int(totalVolume - drawDeal.volume * drawDeal.price)
        drawPriceLabel.text = drawDeal.price.decimal(2)
        drawVolumeLabel.text = formatter.string(for: drawDeal.volume)
        drawProfitLabel.text = formatter.string(for: drawProfit)
        drawProfitLabel.textColor = drawProfit < 0 ? TSColor.matchResult.draw : TSColor.matchResult.win
        
        let lostProfit = Int(totalVolume - lostDeal.volume * lostDeal.price)
        lostPriceLabel.text = lostDeal.price.decimal(2)
        lostVolumeLabel.text = formatter.string(for: lostDeal.volume)
        lostProfitLabel.text = formatter.string(for: lostProfit)
        lostProfitLabel.textColor = lostProfit < 0 ? TSColor.matchResult.draw : TSColor.matchResult.win
    }
}
