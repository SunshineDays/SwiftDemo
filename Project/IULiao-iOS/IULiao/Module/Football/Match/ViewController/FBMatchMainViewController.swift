//
//  FBMatchViewController.swift
//  IULiao
//
//  Created by tianshui on 16/7/8.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

/// 赛事view controller 需要实现的协议
protocol FBMatchViewControllerProtocol {
    
    /// 赛事id
    var matchId: Int! { get set }
    
    /// 彩种
    var lottery: Lottery? { get set }
}

/// 足球赛事详情
class FBMatchMainViewController: FBMatchMainParentViewController {

    private var isFirstLoad = true
    private var matchTabs: [MatchType] = UserToken.shared.isText ? [.analyze(.event), .odds(.europe), .war(.recent), .news] : [.analyze(.event), .odds(.europe), .war(.recent), .recommend, .news]
    var selectedMatchType = MatchType.odds(.europe) {
        didSet {
            isFirstLoad = true
            if let index = matchTabs.index(where: { $0 == selectedMatchType }) {
                matchTabs[index] = selectedMatchType
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    enum MatchType: Equatable {
        
        case analyze(FBMatchAnalyzeViewController.AnalyzeType)
        case odds(FBMatchOddsViewController.OddsType)
        case war(FBMatchWarViewController.WarType)
        case news
        case recommend
        
        var title: String {
            switch self {
            case .analyze: return "赛况"
            case .odds: return "指数"
            case .war: return "战绩"
            case .news: return "爆料"
            case .recommend: return "推荐"
            }
        }
        
        static func ==(lhs: FBMatchMainViewController.MatchType, rhs: FBMatchMainViewController.MatchType) -> Bool {
            return lhs.title == rhs.title
        }
    }
    
    override func viewController(at page: Int) -> (UIViewController & TSNestInnerScrollViewProtocol)? {
        guard let matchType = matchTabs[safe: page] else {
            return nil
        }
        
        selectedMatchType = matchType
        var ctrl: UIViewController & TSNestInnerScrollViewProtocol & FBMatchViewControllerProtocol
        switch matchType {
        case let .analyze(subTabType):
            let vc = FBMatchAnalyzeViewController()
            if isFirstLoad {
                vc.selectedTab = subTabType
            }
            ctrl = vc
        case let .odds(subTabType):
            let vc = FBMatchOddsViewController()
            if isFirstLoad {
                vc.selectedTab = subTabType
            }
            ctrl = vc
        case let .war(subTabType):
            let vc = FBMatchWarViewController()
            if isFirstLoad {
                vc.selectedTab = subTabType
            }
            ctrl = vc
        case .news:
            ctrl = R.storyboard.fbMatchNews.fbMatchNewsViewController()!
        case .recommend:
            ctrl = FBMatchRecommendViewController()
        }
        
        ctrl.matchId = matchId
        ctrl.lottery = lottery
        
        isFirstLoad = false
        
        return  ctrl
    }
}

extension FBMatchMainViewController {

    private func initView() {
        if let index = matchTabs.index(where: { $0 == selectedMatchType }) {
            selectedPage = index
        }
        tabTitles = matchTabs.map { $0.title }
    }

}
