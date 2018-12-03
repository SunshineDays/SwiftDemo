//
//  FBMatchOddsAsiaListViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

/// 赛事分析页 指数 亚盘列表
class FBMatchOddsAsiaListViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {

    var tableView: UITableView!
    private var headerView: UIView?
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let oddsHandler = FBMatchOddsHandler()
    private var oddsList = [FBOddsAsiaSetModel]()
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
        
        oddsHandler.getAsiaList(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, oddsList in
                self.isRequestFailed = false
                self.isLoadData = true
                self.matchInfo = match
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

extension FBMatchOddsAsiaListViewController {
    
    private func initView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(R.nib.fbMatchOddsAsiaListTableCell)
        
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

extension FBMatchOddsAsiaListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoadData || oddsList.isEmpty {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchOddsAsiaListTableCell, for: indexPath)!
        let asia = oddsList[row]
        cell.configCell(asia: asia, needBackgroundColor: row % 2 == 0)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isLoadData || oddsList.isEmpty {
            return nil
        }
        if headerView == nil {
            headerView = R.nib.fbMatchOddsAsiaListHeaderView.firstView(owner: nil)!
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let asia = oddsList[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbMatchOddsAsiaCompanyViewController(matchId: matchId, companyId: asia.company.id, lottery: lottery)
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
}

extension FBMatchOddsAsiaListViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
