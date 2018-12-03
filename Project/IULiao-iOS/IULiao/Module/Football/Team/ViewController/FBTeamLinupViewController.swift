//
//  FBTeamLinupViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/11/8.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// 球队 阵容
class FBTeamLineupViewController: TSEmptyViewController, FBTeamViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!

    var teamId: Int!

    private let teamHandler = FBTeamHandler()
    private var dataSource = [FBTeamLinupModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initNetwork()
    }
    
    override func getData() {
        isLoadData = false
        hud.show(animated: true)
        
        teamHandler.getLineup(
            teamId: teamId,
            success: {
                lineupList in
                self.isRequestFailed = false
                self.isLoadData = true
                self.dataSource = lineupList
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
}

extension FBTeamLineupViewController {
    
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
}

extension FBTeamLineupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[safe: section]?.playerList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbTeamLineupTableCell, for: indexPath)!
        let player = dataSource[indexPath.section].playerList[indexPath.row]
        cell.configCell(player: player)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let lineup = dataSource[section]
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 32))
        v.backgroundColor = UIColor.white
        
        let indicatorView = UIView()
        indicatorView.backgroundColor = TSColor.logo
        
        let titleLabel = UILabel()
        titleLabel.text = lineup.pointName
        titleLabel.textColor = TSColor.logo
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        v.addSubview(indicatorView)
        v.addSubview(titleLabel)
        
        indicatorView.snp.makeConstraints {
            make in
            make.width.equalTo(3)
            make.height.equalTo(16)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        titleLabel.snp.makeConstraints {
            make in
            make.centerY.equalToSuperview()
            make.left.equalTo(indicatorView).offset(10)
        }
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == dataSource.count - 1 {
            return 0
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == dataSource.count - 1 {
            return nil
        }
        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 5))
        v.backgroundColor = UIColor(hex: 0xededed)
        return v
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let player = dataSource[indexPath.section].playerList[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbPlayerMainViewController(playerId: player.id)
        ctrl.title = player.name
        ctrl.hidesBottomBarWhenPushed = true
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

extension FBTeamLineupViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -32
    }
}
