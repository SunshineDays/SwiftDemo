//
//  FBMatchAnalyzeLineupViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/12/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON

private let kTableViewHeaderHeight: CGFloat = 32
private let kStadiumWidth: CGFloat = 375
private let kStadiumHeight: CGFloat = 450

/// 赛事分析 赛况 阵容
class FBMatchAnalyzeLineupViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataImageView: UIImageView!
    private var teamSwitchView: FBMatchAnalyzeLineupTeamSwitchView?
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    private var hasLineupLeagueList = [53, 92, 177, 34, 85, 39, 93, 88, 99, 103, 104, 87, 152, 160, 149, 108, 107, 86, 140, 171, 165, 102, 159, 347]
    private var selectedTeam = TeamType.home {
        didSet {
            tableView.reloadData()
            if lineup.first.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    private let analyzeHandler = FBMatchAnalyzeHandler()
    private var dataSource = FBMatchAnalyzeLineupModel(json: JSON.null)
    private var matchInfo = FBMatchModel(json: JSON.null)
    private var lineup: FBMatchAnalyzeLineupModel.Lineup {
        return selectedTeam == .home ? dataSource.home : dataSource.away
    }
    
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
        
        analyzeHandler.getLineup(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, data in
                self.isRequestFailed = false
                self.isLoadData = true
                self.dataSource = data
                self.matchInfo = match
                self.config()
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

extension FBMatchAnalyzeLineupViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    private func judgeLinupView(lid: Int, oName: String) -> Bool {
        let lidArray = [92, 177, 34, 85, 39, 93, 88, 99, 103, 104, 87, 152, 160, 149, 108, 107, 86, 140, 171, 165, 102, 159, 347]
        let ouGaunBeiArray = ["分组赛", "十六强第一回", "十六强", "十六强第二回", "半准决赛", "半决赛", "决赛"]
        let ouluobaArray = ["分组赛", "三十二强第一回", "三十二强", "三十二强第二回", "十六强", "半准决赛", "半决赛", "决赛"]
        let yingZuZongArray = ["决赛", "半决赛", "半准决赛", "第五圈", "第五圈附加", "第六圈", "第六圈附加"]
        return lidArray.contains(lid) || (lid == 74 && ouGaunBeiArray.contains(oName)) || (lid == 58 && ouluobaArray.contains(oName) || (lid == 55 && yingZuZongArray.contains(oName)))
    }
    
    private func config() {
        /// 是否有阵容
        if judgeLinupView(lid: matchInfo.league.id, oName: matchInfo.oName) {
            // 是否有数据
            if lineup.formation.isEmpty {
                noDataImageView.isHidden = false
                noDataImageView.image = R.image.fbMatch.lineupNoData()
            } else {
                let image = R.image.fbMatch.lineupStadium()!
                let resizeImage = image.resize(size: CGSize(width: TSScreen.currentWidth, height: image.size.height / image.size.width * TSScreen.currentWidth))
                tableView.backgroundColor = UIColor(patternImage: resizeImage)
                noDataImageView.isHidden = true
            }
        }
        else {
            noDataImageView.isHidden = false
            noDataImageView.image = R.image.fbMatch.lineupNoData()
        }
        
//        /// 是否有阵容
//        if hasLineupLeagueList.contains(matchInfo.league.id) {
//
//        } else {
//
//        }
        
    }
    
    private func initNetwork() {
        getData()
    }

}

extension FBMatchAnalyzeLineupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoadData || lineup.first.isEmpty {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return lineup.first.count
        }
        if lineup.formation.isEmpty {
            return 0
        }
        return lineup.backup.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            // 球场里面的高度要适配屏幕 并且要适配四行和五行的布局
            let count = lineup.first.count
            let maxHeight = tableView.width * kStadiumHeight / kStadiumWidth - kTableViewHeaderHeight
            if count == 0 {
                return maxHeight
            }
            return maxHeight / CGFloat(count)
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let tableCell: UITableViewCell!
        if indexPath.section == 0 {
            let players = lineup.first[row]
            if players.count % 2 == 1 {
                // 奇数布局
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeLineupEvenTableCell, for: indexPath)!
                cell.configCell(players: players)
                cell.buttonClickBlock = {
                    [weak self] btn, player in
                    guard let player = player, player.id > 0 else {
                        return
                    }
                    let ctrl = TSEntryViewControllerHelper.fbPlayerMainViewController(playerId: player.id)
                    ctrl.title = player.name
                    self?.navigationController?.pushViewController(ctrl, animated: true)
                }
                tableCell = cell
            } else {
                // 偶数布局
                let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeLineupOddTableCell, for: indexPath)!
                cell.configCell(players: players)
                cell.buttonClickBlock = {
                    [weak self] btn, player in
                    guard let player = player, player.id > 0 else {
                        return
                    }
                    let ctrl = TSEntryViewControllerHelper.fbPlayerMainViewController(playerId: player.id)
                    ctrl.title = player.name
                    self?.navigationController?.pushViewController(ctrl, animated: true)
                }
                tableCell = cell
            }
            tableCell.selectionStyle = .none
        } else {
            let player = lineup.backup[row]
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchAnalyzeLineupBackupTableCell, for: indexPath)!
            cell.configCell(player: player)
            tableCell = cell
        }
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            let player = lineup.backup[indexPath.row]
            if  player.id > 0 {
                let ctrl = TSEntryViewControllerHelper.fbPlayerMainViewController(playerId: player.id)
                ctrl.title = player.name
                navigationController?.pushViewController(ctrl, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if !isLoadData || lineup.formation.isEmpty {
            return 0
        }
        return kTableViewHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isLoadData || lineup.formation.isEmpty {
            return nil
        }

        if section == 0 {
            if teamSwitchView != nil {
                return teamSwitchView
            }
            let header = R.nib.fbMatchAnalyzeLineupTeamSwitchView.firstView(owner: nil)!
            let home = "\(matchInfo.home) \(dataSource.home.formation)"
            let away = "\(matchInfo.away) \(dataSource.away.formation)"
            header.configView(homeName: home + "", awayName: away)
            header.buttonSelectedBlock = {
                [weak self] btn, team in
                self?.selectedTeam = team
            }
            teamSwitchView = header
            return teamSwitchView
        } else {
            let header = R.nib.fbMatchAnalyzeLineupTableHeaderView.firstView(owner: nil)!
            return header
        }
    }
}

extension FBMatchAnalyzeLineupViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}


