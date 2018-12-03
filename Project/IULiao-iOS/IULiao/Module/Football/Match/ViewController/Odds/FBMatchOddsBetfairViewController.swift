//
//  Created by tianshui on 2017/12/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

/// 赛事分析页 指数 必发
class FBMatchOddsBetfairViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var betfairDealView: FBMatchOddsBetfairDealView!
    @IBOutlet weak var betfairPieChartView: FBMatchOddsBetfairPieChartView!
    @IBOutlet weak var betfairIndexView: FBMatchOddsBetfairIndexView!
    @IBOutlet weak var betfairLineChartView: FBMatchOddsBetfairLineChartView!
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return scrollView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let oddsHandler = FBMatchOddsHandler()
    private var betfairData = FBMatchOddsBetfairDataModel(json: JSON.null)
    private var matchInfo = FBMatchModel(json: JSON.null)

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNetwork()
    }
    
    override func getData() {
        isLoadData = false
        
        view.bringSubview(toFront: hud)
        hud.offset.y = -(FBMatchMainHeaderViewController.maxHeight / 2)
        hud.show(animated: true)
        
        oddsHandler.getBetfairOdds(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, betfairData in
                self.isRequestFailed = false
                self.isLoadData = true
                self.matchInfo = match
                self.betfairData = betfairData
                self.configView()
                self.scrollView.reloadEmptyDataSet()
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.isRequestFailed = true
                self.scrollView.reloadEmptyDataSet()
                self.hud.hide(animated: true)
        })
    }
}

extension FBMatchOddsBetfairViewController {
    
    private func initView() {
        scrollView.delegate = self
        scrollView.emptyDataSetSource = self
        scrollView.emptyDataSetDelegate = self
    }
    
    private func initNetwork() {
        getData()
    }
    
    private func configView() {
        contentView.isHidden = betfairData.totalVolume == 0
        betfairDealView.configView(betfair: betfairData)
        betfairPieChartView.configView(betfair: betfairData)
        betfairIndexView.configView(betfair: betfairData)
        betfairLineChartView.configView(betfair: betfairData)
    }
    
}

extension FBMatchOddsBetfairViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
}

extension FBMatchOddsBetfairViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed || isLoadData && betfairData.totalVolume == 0
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
