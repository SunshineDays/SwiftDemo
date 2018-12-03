//
//  FBLiveGoalDialogViewController.swift
//  IULiao
//
//  Created by tianshui on 16/8/8.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 进球弹窗
class FBLiveGoalDialogViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func showGoalDialogView(_ matchs: [FBLiveMatchModel2], autoCloseTimeInterval timeInterval: TimeInterval = 10) {
        var newMatchs = [FBLiveMatchModel2]()
        if matchModelss.isEmpty {
            newMatchs = matchs
        } else {
            for model in dataSource {
                for match in matchs {
                    if model.id != match.id {
                        newMatchs.append(match)
                    }
                }
            }
        }
        
        if !newMatchs.isEmpty {
            matchModelss.append(matchs)
            updataDataSource()
            updataViewFrame()
            tableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + timeInterval) {
                self.changeGoalDialogView()
            }
        }
    }
    
    private var matchModelss = [[FBLiveMatchModel2]]()
    
    private var dataSource = [FBLiveMatchModel2]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth - 60, height: view.height), style: .plain)
        tableView.backgroundColor = UIColor.clear
        tableView.register(R.nib.fbLiveMatchShowNotificationCell)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        return tableView
    }()
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBLiveGoalDialogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLiveMatchShowNotificationCell, for: indexPath)!
        cell.configCell(match: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = dataSource[indexPath.row]
        var tab: FBMatchMainViewController.MatchType
        tab = .odds(.europe)
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: .all, selectedTab: tab)
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
}

// MARK: - Method
extension FBLiveGoalDialogViewController {
    /// 整理数据
    private func updataDataSource() {
        dataSource.removeAll()
        for i in 0 ..< matchModelss.count {
            for model in matchModelss[i] {
                dataSource.append(model)
            }
        }
        view.isHidden = dataSource.isEmpty
    }
    
    /// 改变数据
    private func changeGoalDialogView() {
        matchModelss.removeFirst()
        updataDataSource()
        updataViewFrame()
        tableView.reloadData()
    }
    
    /// 更新self.view的frame
    private func updataViewFrame() {
        view.snp.updateConstraints { (make) in
            make.height.equalTo(self.dataSource.count * 50)
        }
        tableView.height = CGFloat(self.dataSource.count * 50)
    }
}
