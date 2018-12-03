//
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON
import ActionSheetPicker_3_0

/// 赛事分析页 历史交锋
class FBMatchWarVersusViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {

    private var tableView = UITableView()
    private var toolbarView: FBMatchWarRecentToolbarView?
    private var tableFooterView: FBMatchWarRecentTableFooterView?
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private let warHandler = FBMatchWarHandler()
    private var statistics = FBMatchWarStatisticsHelper(allMatchList: [], teamId: 0, teamType: .home) {
        didSet {
            tableView.reloadData()
        }
    }
    private var matchList: [FBMatchWarModel] {
        return statistics.matchList
    }
    private var matchInfo = FBMatchModel(json: JSON.null)
    private var matchNumberList = [6, 10, 20]
    
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
        
        warHandler.getVersusMatch(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, versus in
                self.isRequestFailed = false
                self.isLoadData = true
                self.statistics = FBMatchWarStatisticsHelper(allMatchList: versus, teamId: match.homeTid, teamType: .home)
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

extension FBMatchWarVersusViewController {
    
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
    
    private func setupToolbarHeaderView() -> FBMatchWarRecentToolbarView {
        let toolbarView = R.nib.fbMatchWarRecentToolbarView.firstView(owner: nil)!
        
        toolbarView.titleLabel.text = "双方历史交锋"
        toolbarView.titleLabel.textColor = TSColor.gray.gamut333333
        toolbarView.numberButtonClickBlock = {
            [weak self] btn in
            guard let me = self else {
                return
            }
            // 不要把actionSheetPicker当做成员变量 会内存泄露
            let actionSheetPicker = ActionSheetCustomPicker(title: "选择场次", delegate: me, showCancelButton: false, origin: me.view)
            actionSheetPicker?.toolbarButtonsColor = TSColor.logo
            actionSheetPicker?.show()
            
        }
        toolbarView.leagueFilterButtonClickBlock = {
            [weak self] btn in
            self?.statistics.isRemoveFriendshipLeague = btn.isSelected
        }
        toolbarView.sameHomeAwayButtonClickBlock = {
            [weak self] btn in
            self?.statistics.isSameHomeAway = btn.isSelected
        }
        return toolbarView
    }
}

extension FBMatchWarVersusViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoadData || matchList.isEmpty {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isLoadData {
            return 0
        }
        return matchList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchWarRecentTableCell, for: indexPath)!
        let match = matchList[row]
        let teamId = matchInfo.homeTid
        cell.configCell(recentMatch: match, teamId: teamId, needBackgroundColor: row % 2 == 0)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if matchList.isEmpty {
            return 0
        }
        return 60
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var toolbar: FBMatchWarRecentToolbarView!
        if matchList.isEmpty {
            return nil
        }

        if toolbarView == nil {
            toolbarView = setupToolbarHeaderView()
        }
        toolbar = toolbarView
        toolbar.matchNumberButton.setTitle("近\(statistics.matchNumber)场", for: .normal)
        toolbar.matchNumberButton.layoutImageViewPosition(.right, withOffset: 5)
        return toolbar
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let match = matchList[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: lottery, selectedTab: .war(.recent))
        navigationController?.pushViewController(ctrl, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if matchList.isEmpty {
            return 0
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if matchList.isEmpty {
            return nil
        }
        let footerView = tableFooterView ?? R.nib.fbMatchWarRecentTableFooterView.firstView(owner: nil)!
        footerView.configView(teamName: matchInfo.home, statistics: statistics.statistics)
        return footerView
    }
}


// MARK:- ActionSheetCustomPickerDelegate
extension FBMatchWarVersusViewController: ActionSheetCustomPickerDelegate {
    
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
        let row = matchNumberList.index(of: statistics.matchNumber) ?? 0
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statistics.matchNumber = matchNumberList[row]
    }
}

extension FBMatchWarVersusViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
