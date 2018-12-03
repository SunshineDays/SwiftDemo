//
//  FBMatchOddsEuropeSameViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/19.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 赛事分析 亚盘 相同赔率
class FBMatchOddsAsiaSameViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol, FBMatchOddsCompanyProtocol {
    
    private var headerView: FBMatchOddsEuropeSameMatchHeaderView?
    
    var tableView: UITableView!
    var matchId: Int!
    var lottery: Lottery?
    var companyId: Int!
    var sameType = SameType.odds
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private var matchInfo = FBMatchModel(json: JSON.null)
    private let oddsHandler = FBMatchOddsHandler()
    private var asiaSame = FBMatchOddsAsiaSameModel(json: JSON.null)
    private var asiaData: FBMatchOddsAsiaSameModel.AsiaData {
        return sameType == .league ? asiaSame.sameLeagueData : asiaSame.allData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNetwork()
    }
    
    private enum CellType: Int {
        case statistics = 0, match
    }
    
    /// 相同
    enum SameType {
        /// 相同赔率
        case odds
        /// 相同联赛
        case league
    }
    
    override func getData() {
        isLoadData = false
        
        view.bringSubview(toFront: hud)
        hud.offset.y = -(FBMatchMainHeaderViewController.maxHeight / 2)
        hud.show(animated: true)
        
        oddsHandler.getAsiaSameOdds(
            matchId: matchId,
            companyId: companyId,
            lottery: lottery,
            success: {
                match, asiaSame in
                self.isRequestFailed = false
                self.isLoadData = true
                self.matchInfo = match
                self.asiaSame = asiaSame
                self.tableView.reloadData()
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.isRequestFailed = true
                self.tableView.reloadData()
                self.hud.hide(animated: true)
        })
    }
}

extension FBMatchOddsAsiaSameViewController {
    
    private func initView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.register(R.nib.fbMatchOddsEuropeSameMatchTableCell)
        tableView.register(R.nib.fbMatchOddsEuropeSameStatisticsTableCell)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    private func initNetwork() {
        getData()
    }
    
}

extension FBMatchOddsAsiaSameViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoadData {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellType = CellType(rawValue: section) ?? .match
        if cellType == .statistics {
            if asiaData.oddsList.isEmpty {
                return 0
            }
            return 1
        }
        return asiaData.oddsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = CellType(rawValue: indexPath.section) ?? .match
        if cellType == .statistics {
            return 100
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = CellType(rawValue: indexPath.section) ?? .match

        if cellType == .statistics {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchOddsEuropeSameStatisticsTableCell, for: indexPath)!
            let leagueName = sameType == .league ? matchInfo.league.name : nil
            cell.configCell(companyInfo: asiaSame.companyInfo, statistics: asiaData.statistics, leagueName: leagueName)
            return cell
        } else {
            let row = indexPath.row
            let asia = asiaData.oddsList[row]
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchOddsEuropeSameMatchTableCell, for: indexPath)!
            cell.configCell(match: asia.match, asia: asia.asiaSet, needBackgroundColor: row % 2 == 0)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cellType = CellType(rawValue: section) ?? .match
        if cellType == .statistics {
            return 0
        }
        if asiaData.oddsList.isEmpty {
            return 0
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        if asiaData.oddsList.isEmpty {
            return nil
        }
        if headerView == nil {
            headerView = R.nib.fbMatchOddsEuropeSameMatchHeaderView.firstView(owner: nil)!
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellType = CellType(rawValue: indexPath.section) ?? .match
        if cellType == .statistics {
            return
        }
        
        let europe = asiaData.oddsList[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: europe.match.id, lottery: lottery, selectedTab: .war(.recent))
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let cellType = CellType(rawValue: indexPath.section) ?? .match
        if cellType == .statistics {
            return false
        }
        return true
    }
}

extension FBMatchOddsAsiaSameViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
