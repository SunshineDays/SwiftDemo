//
//  FBLeagueRankScoreGroupViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/22.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// /// 联赛 排行榜 积分榜(分组)
class FBLeagueRankScoreGroupViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var groups = [FBLeagueRankScoreDataModel.Section]() {
        didSet {
            tableView?.reloadData()
            if groups.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
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

}

extension FBLeagueRankScoreGroupViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.register(R.nib.fbLeagueRankScoreStatisticsTableCell)
    }
    
}

extension FBLeagueRankScoreGroupViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLeagueRankScoreStatisticsTableCell, for: indexPath)!
        let score = groups[indexPath.section].list[indexPath.row]
        cell.configCell(score: score, rank: indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = FBLeagueRankScoreHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 36))
        let group = groups[section]
        header.configView(groupName: group.name)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let score = groups[indexPath.section].list[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: score.teamId)
        ctrl.title = score.teamName
        navigationController?.pushViewController(ctrl, animated: true)
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


extension FBLeagueRankScoreGroupViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        return TSEmptyDataViewHelper.dzn_emptyDataAttributedString()
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -16
    }
}
