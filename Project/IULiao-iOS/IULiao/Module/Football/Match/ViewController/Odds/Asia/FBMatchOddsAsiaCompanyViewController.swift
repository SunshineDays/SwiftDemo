//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

/// 赛事分析 亚盘公司
class FBMatchOddsAsiaCompanyViewController: FBMatchMainParentViewController, FBMatchOddsCompanyProtocol {

    private var asiaTabs: [AsiaType] = [.history, .sameOdds, .sameLeague]
    var selectedAsiaType = AsiaType.history
    var companyId: Int! = 451
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    enum AsiaType {
        case history, sameOdds, sameLeague
        
        var title: String {
            switch self {
            case .history: return "亚盘详细"
            case .sameOdds: return "相同盘口"
            case .sameLeague: return "相同联赛"
            }
        }
    }
    
    override func viewController(at page: Int) -> (UIViewController & TSNestInnerScrollViewProtocol)? {
        guard let matchType = asiaTabs[safe: page] else {
            return nil
        }
        var ctrl: UIViewController & TSNestInnerScrollViewProtocol & FBMatchViewControllerProtocol & FBMatchOddsCompanyProtocol
        switch matchType {
        case .history:
            ctrl = FBMatchOddsAsiaHistoryViewController()
        case .sameOdds:
            ctrl = FBMatchOddsAsiaSameViewController()
            (ctrl as? FBMatchOddsAsiaSameViewController)?.sameType = .odds
        case .sameLeague:
            ctrl = FBMatchOddsAsiaSameViewController()
            (ctrl as? FBMatchOddsAsiaSameViewController)?.sameType = .league
        }
        ctrl.matchId = matchId
        ctrl.lottery = lottery
        ctrl.companyId = companyId
        return  ctrl
    }
}

// MARK:- method
extension FBMatchOddsAsiaCompanyViewController {
    
    private func initView() {
        if let index = asiaTabs.index(of: selectedAsiaType) {
            selectedPage = index
        }
        tabTitles = asiaTabs.map { $0.title }
    }
}
