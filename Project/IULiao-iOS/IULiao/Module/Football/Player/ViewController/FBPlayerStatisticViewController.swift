//
//  FBPlayerStatisticViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/11/17.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import DZNEmptyDataSet
import ActionSheetPicker_3_0

/// 球员技术统计
class FBPlayerStatisticViewController: TSEmptyViewController, FBPlayerViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leagueBtn: UIButton!
    @IBOutlet weak var seasonBtn: UIButton!

    var playerId: Int!

    var contentScrollView: UIScrollView {
        return tableView
    }

    private let playerHandler = FBPlayerHandler()
    
    override var isRequestFailed: Bool {
        didSet {
            tableView.reloadData()
        }
    }
    private var playerStatistic = FBPlayerStatisticsModel(json: JSON.null) {
        didSet {
            if selectedLeagueId == nil {
                let hasStatistic = playerStatistic.statisticList.filter({
                    $0.leagueInfo.lid == playerStatistic.currentLeagueId
                }).first ?? playerStatistic.statisticList.first
                selectedLeagueId = hasStatistic?.leagueInfo.lid
                selectedSeasonName = hasStatistic?.payloadList.first?.seasonName
            }
            tableView.reloadData()
        }
    }

    /// 选中的联赛id
    private var selectedLeagueId: Int? {
        didSet {
            guard let league = playerStatistic.statisticList.filter({ $0.leagueInfo.lid == selectedLeagueId }).first else {
                return
            }
            leagueBtn.setTitle(league.leagueInfo.name, for: .normal)
            leagueBtn.layoutImageViewPosition(.right, withOffset: 4)
        }
    }
    /// 选中的赛季名
    private var selectedSeasonName: String? {
        didSet {
            guard let name = selectedSeasonName else {
                return
            }
            seasonBtn.setTitle(name, for: .normal)
            seasonBtn.layoutImageViewPosition(.right, withOffset: 4)
        }
    }

    /// 当前联赛,赛季的统计
    private var currentStatisticPayload: FBPlayerStatisticsModel.Statistic.Payload? {
        let payload = playerStatistic.statisticList.filter({
            $0.leagueInfo.lid == selectedLeagueId ?? 0
        }).first?.payloadList.filter({
            $0.seasonName == selectedSeasonName ?? ""
        }).first
        return payload
    }

    /// actionSheet选择的lid
    private var actionSheetSelectedLeagueId: Int? = nil
    /// actionSheet选择的赛季名
    private var actionSheetSelectedSeasonName: String? = nil

    private var sectionList = ["比赛", "进球", "场均传球", "场均防守", "其它场均数据", "得分"]
    private var sectionRows = [3, 4, 2, 2, 4, 2]

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initNetwork()
    }
    
    override func getData() {
        isLoadData = false
        hud.show(animated: true)
        
        playerHandler.getStatistics(
            playerId: playerId,
            success: {
                statistic in
                self.isRequestFailed = false
                self.isLoadData = true
                self.playerStatistic = statistic
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.hud.hide(animated: true)
                self.isRequestFailed = true
                self.playerStatistic = FBPlayerStatisticsModel(json: JSON.null)
        })
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        leagueBtn.layoutImageViewPosition(.right, withOffset: 4)
        seasonBtn.layoutImageViewPosition(.right, withOffset: 4)
    }

    /// 联赛和赛季点击
    @IBAction func leagueBtnClick(_ sender: UIButton) {
        // 不要把actionSheetPicker当做成员变量 会内存泄露
        let actionSheetPicker = ActionSheetCustomPicker(title: "选择联赛-赛季", delegate: self, showCancelButton: true, origin: view)
        actionSheetPicker?.toolbarButtonsColor = TSColor.logo
        actionSheetPicker?.show()
    }
}

extension FBPlayerStatisticViewController {

    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self

        leagueBtn.layoutImageViewPosition(.right, withOffset: 4)
        seasonBtn.layoutImageViewPosition(.right, withOffset: 4)
    }

    private func initNetwork() {
        getData()
    }

}


extension FBPlayerStatisticViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return isLoadData ? sectionList.count : 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isLoadData {
            return 0
        }
        return sectionRows[safe: section] ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbPlayerStatisticTableCell, for: indexPath)!
        let payload = currentStatisticPayload

        var statisticName = ""
        var value = ""
        let total = payload?.total ?? 0
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            statisticName = "总出场次数"
            value = payload == nil ? "-" : "\(total) 次"
        case (0, 1):
            statisticName = "首发次数"
            value = payload == nil ? "-" : "\(payload!.first) 次"
        case (0, 2):
            statisticName = "场均上场时间"
            value = payload == nil ? "-" : "\(calc(divider: payload!.time, dividend: total)) 分钟"

        case (1, 0):
            statisticName = "进球"
            value = payload == nil ? "-" : "\(payload!.goal) 个"
        case (1, 1):
            statisticName = "进球频率"
            value = payload == nil ? "-" : "\(calc(divider: payload!.time, dividend: payload!.goal)) 分钟"
        case (1, 2):
            statisticName = "场均进球"
            value = payload == nil ? "-" : "\(calc(divider: payload!.goal, dividend: total)) 个"
        case (1, 3):
            statisticName = "场均射门"
            value = payload == nil ? "-" : "\(calc(divider: payload!.shoot, dividend: total)) 次"

        case (2, 0):
            statisticName = "助攻"
            value = payload == nil ? "-" : "\(calc(divider: payload!.assist, dividend: total)) 次"
        case (2, 1):
            statisticName = "创造得分机会"
            value = payload == nil ? "-" : "\(calc(divider: payload!.keyPass, dividend: total)) 次"

        case (3, 0):
            statisticName = "断球"
            value = payload == nil ? "-" : "\(calc(divider: payload!.interception, dividend: total)) 次"
        case (3, 1):
            statisticName = "铲球"
            value = payload == nil ? "-" : "\(calc(divider: payload!.tackle, dividend: total)) 次"

        case (4, 0):
            statisticName = "带球摆脱"
            value = payload == nil ? "-" : "\(calc(divider: payload!.breakLoose, dividend: total)) 次"
        case (4, 1):
            statisticName = "丢球"
            value = payload == nil ? "-" : "\(calc(divider: payload!.turnover, dividend: total)) 次"
        case (4, 2):
            statisticName = "犯规"
            value = payload == nil ? "-" : "\(calc(divider: payload!.foul, dividend: total)) 次"
        case (4, 3):
            statisticName = "被犯规"
            value = payload == nil ? "-" : "\(calc(divider: payload!.fouled, dividend: total)) 次"

        case (5, 0):
            statisticName = "黄牌"
            value = payload == nil ? "-" : "\(payload!.yellow) 张"
        case (5, 1):
            statisticName = "红牌"
            value = payload == nil ? "-" : "\(payload!.red) 张"
        default:
            break
        }

        cell.configCell(statisticName: statisticName, value: value)
        return cell
    }

    private func calc(divider: Int, dividend: Int) -> String {
        if dividend == 0 {
            return "0"
        }
        let result = Double(divider) / Double(dividend)
        return result.decimal(2)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isLoadData ? 30 : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let v = UIView()
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.width, height: 30))
        label.backgroundColor = UIColor.white
        label.textColor = TSColor.gray.gamut333333
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = sectionList[safe: section] ?? "其它"
        v.addSubview(label)
        return v
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if !isLoadData {
            return 0
        }
        if section == sectionList.count - 1 {
            return 0
        }
        return 4
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == sectionList.count - 1 {
            return nil
        }
        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 4))
        v.backgroundColor = UIColor(hex: 0xeeeeee)
        return v
    }

}

// MARK:- ActionSheetCustomPickerDelegate
extension FBPlayerStatisticViewController: ActionSheetCustomPickerDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return playerStatistic.statisticList.count
        }
        return playerStatistic.statisticList.filter({ $0.leagueInfo.lid == actionSheetSelectedLeagueId ?? selectedLeagueId }).first?.payloadList.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return playerStatistic.statisticList[safe: row]?.leagueInfo.name
        }
        return playerStatistic.statisticList.filter({ $0.leagueInfo.lid == actionSheetSelectedLeagueId ?? selectedLeagueId }).first?.payloadList[safe: row]?.seasonName
    }

    func actionSheetPicker(_ actionSheetPicker: AbstractActionSheetPicker!, configurePickerView pickerView: UIPickerView!) {

        if let row = playerStatistic.statisticList.index(where: { $0.leagueInfo.lid == selectedLeagueId }) {
            pickerView.selectRow(row, inComponent: 0, animated: false)
        }

        if let list = playerStatistic.statisticList.filter({ $0.leagueInfo.lid == selectedLeagueId }).first?.payloadList {
            let row = list.index(where: { $0.seasonName == selectedSeasonName }) ?? 0
            pickerView.selectRow(row, inComponent: 1, animated: false)
        }
    }

    func actionSheetPickerDidSucceed(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
        if let actionSheetSelectedLeagueId = actionSheetSelectedLeagueId {
            selectedLeagueId = actionSheetSelectedLeagueId
        }
        if let actionSheetSelectedSeasonName = actionSheetSelectedSeasonName {
            selectedSeasonName = actionSheetSelectedSeasonName
        }
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        actionSheetSelectedLeagueId = nil
        actionSheetSelectedSeasonName = nil
    }

    func actionSheetPickerDidCancel(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
        actionSheetSelectedLeagueId = nil
        actionSheetSelectedSeasonName = nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            actionSheetSelectedLeagueId = playerStatistic.statisticList[safe: row]?.leagueInfo.lid
            actionSheetSelectedSeasonName = playerStatistic.statisticList[safe: row]?.payloadList.first?.seasonName
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: false)
        } else if component == 1 {
            actionSheetSelectedSeasonName = playerStatistic.statisticList.filter({
                $0.leagueInfo.lid == actionSheetSelectedLeagueId ?? selectedLeagueId
            }).first?.payloadList[safe: row]?.seasonName
        }

    }
}
