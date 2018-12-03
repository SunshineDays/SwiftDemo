//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON
import ActionSheetPicker_3_0

/// 赛事分析页 相同盘口(同赔)
class FBMatchWarSameHandicapViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {

    private var tableView = UITableView()
    private var homeToolbarView: FBMatchWarSameHandicapToolbarView?
    private var awayToolbarView: FBMatchWarSameHandicapToolbarView?
    private var homeTableFooterView: FBMatchWarRecentTableFooterView?
    private var awayTableFooterView: FBMatchWarRecentTableFooterView?
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let warHandler = FBMatchWarHandler()
    private var homeStatistics = FBMatchWarStatisticsHelper(allMatchList: [], teamId: 0, teamType: .home) {
        didSet {
            tableView.reloadData()
        }
    }
    private var awayStatistics = FBMatchWarStatisticsHelper(allMatchList: [], teamId: 0, teamType: .away) {
        didSet {
            tableView.reloadData()
        }
    }
    private var homeMatchList: [FBMatchWarModel] {
        return homeStatistics.matchList
    }
    private var awayMatchList: [FBMatchWarModel] {
        return awayStatistics.matchList
    }
    private var matchInfo = FBMatchModel(json: JSON.null)
    private var matchNumberList = [6, 10, 20]
    private var actionSheetPickerTeam = TeamType.home
    
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
        
        warHandler.getSameHandicapMatch(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, home, away in
                self.isRequestFailed = false
                self.isLoadData = true
                self.homeStatistics = FBMatchWarStatisticsHelper(allMatchList: home, teamId: match.homeTid, teamType: .home)
                self.awayStatistics = FBMatchWarStatisticsHelper(allMatchList: away, teamId: match.awayTid, teamType: .away)
                self.matchInfo = match
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

extension FBMatchWarSameHandicapViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(R.nib.fbMatchWarRecentTableCell)
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    private func initNetwork() {
        getData()
    }
    
    private func setupToolbarHeaderView(team: TeamType) -> FBMatchWarSameHandicapToolbarView {
        let toolbarView = R.nib.fbMatchWarSameHandicapToolbarView.firstView(owner: nil)!

        toolbarView.titleLabel.text = team == .home ? matchInfo.home : matchInfo.away
        
        toolbarView.numberButtonClickBlock = {
            [weak self] btn in
            guard let me = self else {
                return
            }
            me.actionSheetPickerTeam = team
            // 不要把actionSheetPicker当做成员变量 会内存泄露
            let actionSheetPicker = ActionSheetCustomPicker(title: "选择场次", delegate: me, showCancelButton: false, origin: me.view)
            actionSheetPicker?.toolbarButtonsColor = TSColor.logo
            actionSheetPicker?.show()
            
        }
        return toolbarView
    }
}

extension FBMatchWarSameHandicapViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        if !isLoadData {
            return 0
        }
        return section == 0 ? homeMatchList.count : awayMatchList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchWarRecentTableCell, for: indexPath)!
        var match: FBMatchWarModel!
        var teamId: Int!
        if section == 0 {
            match = homeMatchList[row]
            teamId = matchInfo.homeTid
        } else {
            match = awayMatchList[row]
            teamId = matchInfo.awayTid
        }
        cell.configCell(sameHandicapMatch: match, teamId: teamId, needBackgroundColor: row % 2 == 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        var match: FBMatchWarModel!
        if indexPath.section == 0 {
            match = homeMatchList[row]
        } else {
            match = awayMatchList[row]
        }
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: lottery, selectedTab: .war(.recent))
        navigationController?.pushViewController(ctrl, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if homeMatchList.isEmpty && awayMatchList.isEmpty {
            return 0
        }
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if homeMatchList.isEmpty && awayMatchList.isEmpty {
            return nil
        }
        
        var toolbarView: FBMatchWarSameHandicapToolbarView!
        
        if section == 0 {
            if homeToolbarView == nil {
                homeToolbarView = setupToolbarHeaderView(team: .home)
            }
            toolbarView = homeToolbarView
            homeToolbarView?.matchNumberButton.setTitle("\(homeStatistics.matchNumber)场", for: .normal)
        } else {
            if awayToolbarView == nil {
                awayToolbarView = setupToolbarHeaderView(team: .away)
            }
            toolbarView = awayToolbarView
            awayToolbarView?.matchNumberButton.setTitle("\(awayStatistics.matchNumber)场", for: .normal)
        }
        toolbarView.matchNumberButton.layoutImageViewPosition(.right, withOffset: 5)

        return toolbarView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if homeMatchList.isEmpty && awayMatchList.isEmpty {
            return 0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if homeMatchList.isEmpty && awayMatchList.isEmpty {
            return nil
        }
        
        let tableFooterView = (section == 0 ? homeTableFooterView : awayTableFooterView) ?? R.nib.fbMatchWarRecentTableFooterView.firstView(owner: nil)!
        if section == 0 {
            tableFooterView.configView(teamName: nil, statistics: homeStatistics.statistics)
        } else {
            tableFooterView.configView(teamName: nil, statistics: awayStatistics.statistics)
        }
        return tableFooterView
    }
}


// MARK:- ActionSheetCustomPickerDelegate
extension FBMatchWarSameHandicapViewController: ActionSheetCustomPickerDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return matchNumberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return " \(matchNumberList[row])场"
    }
    
    func actionSheetPicker(_ actionSheetPicker: AbstractActionSheetPicker!, configurePickerView pickerView: UIPickerView!) {
        var row = 0
        if actionSheetPickerTeam == .home {
            row = matchNumberList.index(of: homeStatistics.matchNumber) ?? 0
        } else {
            row = matchNumberList.index(of: awayStatistics.matchNumber) ?? 0
        }
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if actionSheetPickerTeam == .home {
            homeStatistics.matchNumber = matchNumberList[row]
        } else {
            awayStatistics.matchNumber = matchNumberList[row]
        }
    }
}

extension FBMatchWarSameHandicapViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
