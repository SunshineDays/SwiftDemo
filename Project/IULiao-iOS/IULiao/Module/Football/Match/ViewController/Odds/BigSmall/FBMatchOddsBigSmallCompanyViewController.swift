//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

/// 赛事分析 大小球公司
class FBMatchOddsBigSmallCompanyViewController: FBMatchMainParentViewController, FBMatchOddsCompanyProtocol {

    private var bigSmallTabs: [BigSmallType] = [.history]
    var selectedBigSmallType = BigSmallType.history
    var companyId: Int! = 451
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    enum BigSmallType {
        case history
        
        var title: String {
            switch self {
            case .history: return "亚盘详细"
            }
        }
    }
    
    override func viewController(at page: Int) -> (UIViewController & TSNestInnerScrollViewProtocol)? {
        guard let matchType = bigSmallTabs[safe: page] else {
            return nil
        }
        var ctrl: UIViewController & TSNestInnerScrollViewProtocol & FBMatchViewControllerProtocol & FBMatchOddsCompanyProtocol
        switch matchType {
        case .history:
            ctrl = FBMatchOddsBigSmallHistoryViewController()
        }
        ctrl.matchId = matchId
        ctrl.lottery = lottery
        ctrl.companyId = companyId
        return  ctrl
    }
}

// MARK:- method
extension FBMatchOddsBigSmallCompanyViewController {
    
    private func initView() {
        if let index = bigSmallTabs.index(of: selectedBigSmallType) {
            selectedPage = index
        }
        tabTitles = bigSmallTabs.map { $0.title }
    }
}
