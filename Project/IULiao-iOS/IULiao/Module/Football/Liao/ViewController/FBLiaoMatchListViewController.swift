//
//  FBLiaoMatchListViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import SnapKit

/// 料 对阵列表
class FBLiaoMatchListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var issueListHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var issueStackView: UIStackView!
    
    let liaoMatchListHandler = FBLiaoMatchListHandler()
    
    var liaoData = FBLiaoDataModel() {
        didSet {
            issueListHeightConstraint.constant = liaoData.issueList.count == 0 ? 0 : 58.5
            setupIssueView()
        }
    }
    var matchList = [FBMatchModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initListener()
        tableView.mj_header?.beginRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FBLiaoFilterLeagueSegue" {
            let destinationCtrl = segue.destination as! FBLiaoFilterLeagueViewController
            destinationCtrl.liaoData = liaoData
            destinationCtrl.hidesBottomBarWhenPushed = true
            destinationCtrl.delegate = self
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- method
extension FBLiaoMatchListViewController {
    
    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        liaoMatchListHandler.delegate = self
    }
    
    private func initView() {
        

        let header = MJRefreshNormalHeader {
            [weak self] in
            self?.liaoMatchListHandler.executeFetchMatchList(self?.liaoData.selectIssue)
        }
        header?.lastUpdatedTimeKey = "FBLiaoMatchListViewController"
        tableView.mj_header = header
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    func setupIssueView() {
        
        issueStackView.arrangedSubviews.forEach {
            (v) in
            issueStackView.removeArrangedSubview(v)
            v.removeFromSuperview()
        }
        
        for issue in liaoData.issueList {
            
            let v = FBLiaoIssueView()
            v.currentIssue = liaoData.currentIssue
            v.selectIssue = liaoData.selectIssue
            v.issue = issue
            issueStackView.addArrangedSubview(v)
            v.delegate = self
        }
        
    }
    
    /// 从后台转入前台
    @objc func applicationWillEnterForeground() {
        let now = Foundation.Date().timeIntervalSince1970
        let last = tableView.mj_header?.lastUpdatedTime?.timeIntervalSince1970 ?? 0
        // 20分钟自动刷新
        if now - last > 1200 {
            tableView.mj_header?.beginRefreshing()
        }
    }
    
}

// MARK:- FBLiaoFilterLeagueViewControllerDelegate
extension FBLiaoMatchListViewController: FBLiaoFilterLeagueViewControllerDelegate {
    
    func liaoFilterLeagueViewController(dataDidChange data: FBLiaoDataModel) {

        liaoData = data
        matchList = liaoData.filterMatchList()
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
    }
}

// MARK:- UITableViewDataSource
extension FBLiaoMatchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchList.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 41
        case 2:
            return 44
        default:
            return 90
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let (row, section) = (indexPath.row, indexPath.section)
    
        let match = matchList[section]
        let briefList = liaoData.briefDict[match.mid] ?? []
        
        switch row {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FBLiaoMatchTableCell", for: indexPath) as! FBLiaoMatchTableCell
            cell.configCell(match: match)
            return cell
            
        case 1:

            if let brief = briefList.first {
                if brief.imgUrl == nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FBLiaoH1TextTableCell", for: indexPath) as! FBLiaoH1TextTableCell
                    cell.configCell(brief: brief, match: match)
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "FBLiaoH1ImageTableCell", for: indexPath) as! FBLiaoH1ImageTableCell
                    cell.configCell(brief: brief, match: match)
                    return cell
                }
            }
            
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FBLiaoH2TableCell", for: indexPath) as! FBLiaoH2TableCell
            if let brief = briefList.last {
                cell.configCell(brief: brief, match: match)
            }
            return cell
            
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = matchList[indexPath.section]
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: .jingcai, selectedTab: .news)
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 去除tableview 分割线不紧挨着左边
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
}

// MAKR:- FBLiaoIssueViewDelegate
extension FBLiaoMatchListViewController: FBLiaoIssueViewDelegate {
    
    func liaoIssueViewDayButtonClick(_ v: FBLiaoIssueView) {
        liaoData.selectIssue = v.issue
        tableView.mj_header?.beginRefreshing()
    }
}

// MARK:- FBOLiaoMatchListHandlerDelegate
extension FBLiaoMatchListViewController: FBLiaoMatchListHandlerDelegate {
    
    func liaoMatchListHandler(_ handler: FBLiaoMatchListHandler, didFetchedData data: FBLiaoDataModel) {
        liaoData = data
        matchList = liaoData.filterMatchList()
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
    }
    
    func liaoMatchListHandler(_ handler: FBLiaoMatchListHandler, didError error: NSError) {
        tableView.mj_header?.endRefreshing()
        TSToast.showNotificationWithMessage(error.localizedDescription)
    }
}


