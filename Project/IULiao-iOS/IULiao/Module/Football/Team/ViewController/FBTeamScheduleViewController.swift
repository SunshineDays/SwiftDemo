//
//  FBTeamScheduleViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/11/9.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// 球队 赛程
class FBTeamScheduleViewController: TSEmptyViewController, FBTeamViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var teamId: Int!
    
    private let teamHandler = FBTeamHandler()
    private var schedule = FBTeamScheduleModel(overMatchList: [], futureMatchList: [])
    private var dataSource: [[FBLiveMatchModel]] {
        return isShowFutureMatch ? [schedule.futureMatchList, schedule.overMatchList] : [[], schedule.overMatchList]
    }
    /// 是否显示未来比赛
    private var isShowFutureMatch = false {
        didSet {
            let set = IndexSet(integer: 0)
            if isShowFutureMatch {
                tableView.reloadSections(set, with: .bottom)
            } else {
                tableView.reloadSections(set, with: .top)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initNetwork()
    }

    override func getData() {
        isLoadData = false
        hud.show(animated: true)
        
        teamHandler.getSchedule(
            teamId: teamId,
            success: {
                schedule in
                self.isRequestFailed = false
                self.isLoadData = true
                self.schedule = schedule
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
    
    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension FBTeamScheduleViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
    }
    
    private func initNetwork() {
        getData()
    }

    @objc private func changeShowFutureMatch(tap: UITapGestureRecognizer) {
        isShowFutureMatch = !isShowFutureMatch
        if let header = tap.view as? FBTeamScheduleHeaderView {
            header.configView(isShowFutureMatch: isShowFutureMatch)
        }
    }
}

extension FBTeamScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[safe: section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbTeamScheduleTableCell, for: indexPath)!
        let match = dataSource[indexPath.section][indexPath.row]
        cell.configCell(teamId: teamId, match: match)
        cell.matchAnalyseClickBlock = {
            btn in
            let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: nil)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        cell.matchAnimationClickBlock = {
            btn in
            let ctrl = TSEntryViewControllerHelper.fbLiveAnimationViewController(matchId: match.id)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        cell.homeTeamClickBlock = {
            let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: match.homeTid)
            ctrl.title = match.home
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        cell.awayTeamClickBlock = {
            let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: match.awayTid)
            ctrl.title = match.away
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let header = R.nib.fbTeamScheduleHeaderView.firstView(owner: nil)!
        header.frame = CGRect(x: 0, y: 0, width: tableView.width, height: 36)
        header.configView(isShowFutureMatch: isShowFutureMatch)
        let tap = UITapGestureRecognizer(target: self, action: #selector(changeShowFutureMatch))
        header.addGestureRecognizer(tap)
        return header
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
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

extension FBTeamScheduleViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -32
    }
}
