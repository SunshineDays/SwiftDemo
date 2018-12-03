//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

protocol FBMatchOddsCompanyProtocol {
    /// 公司id
    var companyId: Int! { get set }
}

/// 赛事分析 欧赔公司
class FBMatchOddsEuropeCompanyViewController: FBMatchMainParentViewController, FBMatchOddsCompanyProtocol {

    private var europeTabs: [EuropeType] = [.history, .sameOdds, .sameLeague]
    var selectedEuropeType = EuropeType.history
    var companyId: Int! = 451
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    enum EuropeType {
        case history, sameOdds, sameLeague
        
        var title: String {
            switch self {
            case .history: return "欧赔详细"
            case .sameOdds: return "相同赔率"
            case .sameLeague: return "相同联赛"
            }
        }
    }
    
    override func viewController(at page: Int) -> (UIViewController & TSNestInnerScrollViewProtocol)? {
        guard let matchType = europeTabs[safe: page] else {
            return nil
        }
        var ctrl: UIViewController & TSNestInnerScrollViewProtocol & FBMatchViewControllerProtocol & FBMatchOddsCompanyProtocol
        switch matchType {
        case .history:
            ctrl = FBMatchOddsEuropeHistoryViewController()
        case .sameOdds:
            ctrl = FBMatchOddsEuropeSameViewController()
            (ctrl as? FBMatchOddsEuropeSameViewController)?.sameType = .odds
        case .sameLeague:
            ctrl = FBMatchOddsEuropeSameViewController()
            (ctrl as? FBMatchOddsEuropeSameViewController)?.sameType = .league
        }
        ctrl.matchId = matchId
        ctrl.lottery = lottery
        ctrl.companyId = companyId
        return  ctrl
    }
}

// MARK:- method
extension FBMatchOddsEuropeCompanyViewController {
    
    private func initView() {
        if let index = europeTabs.index(of: selectedEuropeType) {
            selectedPage = index
        }
        tabTitles = europeTabs.map { $0.title }
    }
}
