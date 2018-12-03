//
//  FBMatchOddsEuropeHistoryViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/18.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

/// 赛事分析 指数 欧赔 详细(历史)
class FBMatchOddsEuropeHistoryViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol, FBMatchOddsCompanyProtocol {
    
    private var headerView: FBMatchOddsEuropeHistoryHeaderView?
    var tableView: UITableView!
    var matchId: Int!
    var lottery: Lottery?
    var companyId: Int!
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let oddsHandler = FBMatchOddsHandler()
    private var oddsList = [FBOddsEuropeModel]()
    private var matchInfo = FBMatchModel(json: JSON.null)
    private var companyInfo = CompanyModel(cid: 0, name: "")
    
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
        
        oddsHandler.getEuropeHistory(
            matchId: matchId,
            companyId: companyId,
            lottery: lottery,
            success: {
                match, companyInfo, oddsList in
                self.isRequestFailed = false
                self.isLoadData = true
                self.matchInfo = match
                self.companyInfo = companyInfo
                self.oddsList = oddsList
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

extension FBMatchOddsEuropeHistoryViewController {
    
    private func initView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(R.nib.fbMatchOddsEuropeHistoryTableCell)
        
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

extension FBMatchOddsEuropeHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoadData {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oddsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchOddsEuropeHistoryTableCell, for: indexPath)!
        let europe = oddsList[row]
        let prevEurope = oddsList[safe: row + 1] ?? europe
        cell.configCell(matchInfo: matchInfo, europe: europe, prevEurope: prevEurope, isFirstOdds: row == oddsList.count - 1, needBackgroundColor: row % 2 == 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if oddsList.isEmpty {
            return 0
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if oddsList.isEmpty {
            return nil
        }
        if headerView == nil {
            headerView = R.nib.fbMatchOddsEuropeHistoryHeaderView.firstView(owner: nil)!
        }
        headerView?.companyNameLabel.text = "\(companyInfo.name)赔率变化"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FBMatchOddsEuropeHistoryViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
