//  Created by tianshui on 2017/12/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 比分指数
class FBMatchOddsBetfairIndexView: UIView {
    
    @IBOutlet weak var winMarketLabel: UILabel!
    @IBOutlet weak var winHotLabel: UILabel!
    @IBOutlet weak var winProfitLabel: UILabel!
    @IBOutlet weak var winBuyLabel: UILabel!
    @IBOutlet weak var winSellLabel: UILabel!
    
    @IBOutlet weak var drawMarketLabel: UILabel!
    @IBOutlet weak var drawHotLabel: UILabel!
    @IBOutlet weak var drawProfitLabel: UILabel!
    @IBOutlet weak var drawBuyLabel: UILabel!
    @IBOutlet weak var drawSellLabel: UILabel!
    
    @IBOutlet weak var lostMarketLabel: UILabel!
    @IBOutlet weak var lostHotLabel: UILabel!
    @IBOutlet weak var lostProfitLabel: UILabel!
    @IBOutlet weak var lostBuyLabel: UILabel!
    @IBOutlet weak var lostSellLabel: UILabel!

    func configView(betfair: FBMatchOddsBetfairDataModel) {
        let winIndex = betfair.winStatistics.index
        let drawIndex = betfair.drawStatistics.index
        let lostIndex = betfair.lostStatistics.index
        
        guard winIndex.market > 0 && winIndex.market > 0 && lostIndex.market > 0 else {
            return
        }
        
        let maxHot = max(winIndex.hot, drawIndex.hot, lostIndex.hot)
        let minHot = min(winIndex.hot, drawIndex.hot, lostIndex.hot)
        let maxProfit = max(winIndex.profit, drawIndex.profit, lostIndex.profit)
        let minProfit = min(winIndex.profit, drawIndex.profit, lostIndex.profit)
        var maxHotLabel: UILabel?
        var minHotLabel: UILabel?
        var maxProfitLabel: UILabel?
        var minProfitLabel: UILabel?
        
        winMarketLabel.text = (winIndex.market * 100).decimal(0)
        winHotLabel.text = (winIndex.hot * 100).decimal(0)
        winProfitLabel.text = (winIndex.profit * 100).decimal(0)
        winBuyLabel.text = (winIndex.buyPrefer * 100).decimal(0)
        winSellLabel.text = (winIndex.sellPrefer * 100).decimal(0)
        if maxHot == winIndex.hot {
            maxHotLabel = winHotLabel
        } else if minHot == winIndex.hot {
            minHotLabel = winHotLabel
        }
        if maxProfit == winIndex.profit {
            maxProfitLabel = winProfitLabel
        } else if minProfit == winIndex.profit {
            minProfitLabel = winProfitLabel
        }
        
        drawMarketLabel.text = (drawIndex.market * 100).decimal(0)
        drawHotLabel.text = (drawIndex.hot * 100).decimal(0)
        drawProfitLabel.text = (drawIndex.profit * 100).decimal(0)
        drawBuyLabel.text = (drawIndex.buyPrefer * 100).decimal(0)
        drawSellLabel.text = (drawIndex.sellPrefer * 100).decimal(0)
        if maxHot == drawIndex.hot {
            maxHotLabel = drawHotLabel
        } else if minHot == drawIndex.hot {
            minHotLabel = drawHotLabel
        }
        if maxProfit == drawIndex.profit {
            maxProfitLabel = drawProfitLabel
        } else if minProfit == drawIndex.profit {
            minProfitLabel = drawProfitLabel
        }
        
        lostMarketLabel.text = (lostIndex.market * 100).decimal(0)
        lostHotLabel.text = (lostIndex.hot * 100).decimal(0)
        lostProfitLabel.text = (lostIndex.profit * 100).decimal(0)
        lostBuyLabel.text = (lostIndex.buyPrefer * 100).decimal(0)
        lostSellLabel.text = (lostIndex.sellPrefer * 100).decimal(0)
        if maxHot == lostIndex.hot {
            maxHotLabel = lostHotLabel
        } else if minHot == lostIndex.hot {
            minHotLabel = lostHotLabel
        }
        if maxProfit == lostIndex.profit {
            maxProfitLabel = lostProfitLabel
        } else if minProfit == lostIndex.profit {
            minProfitLabel = lostProfitLabel
        }

        maxHotLabel?.textColor = TSColor.matchResult.win
        minHotLabel?.textColor = TSColor.matchResult.draw
        maxProfitLabel?.textColor = TSColor.matchResult.win
        minProfitLabel?.textColor = TSColor.matchResult.draw
    }
}
