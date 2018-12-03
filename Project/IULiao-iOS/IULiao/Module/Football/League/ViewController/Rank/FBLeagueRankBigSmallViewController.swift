//
//  FBLeagueRankBigSmallViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/21.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import DZNEmptyDataSet

/// 联赛 排行榜 大小
class FBLeagueRankBigSmallViewController: TSEmptyViewController, FBLeagueViewControllerProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allRankBtn: UIButton!
    @IBOutlet weak var homeRankBtn: UIButton!
    @IBOutlet weak var awayRankBtn: UIButton!
    
    @IBOutlet weak var rankLabelLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var statisticsLabelWidthConstraint: NSLayoutConstraint!
    
    /// 联赛id
    var leagueId: Int!
    
    /// 赛季id
    var seasonId: Int? {
        didSet {
            if leagueId != nil && tableView != nil && seasonId != nil && seasonId != oldValue  {
                getData()
            }
        }
    }
    
    private var rankType = RankType.all {
        didSet {
            tableView.reloadData()
            if dataSource.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    private let rankHandler = FBLeagueRankHandler()
    /// 请求是否失败
    override var isRequestFailed: Bool {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var rankBigSmallData = FBLeagueRankBigSmallDataModel(
            all: [],
            home: [],
            away: []
        ) {
        didSet {
            tableView.reloadData()
            if dataSource.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    private var dataSource: [FBLeagueRankBigSmallModel] {
        switch rankType {
        case .all: return rankBigSmallData.all
        case .home: return rankBigSmallData.home
        case .away: return rankBigSmallData.away
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initNetwork()
    }
    
    enum RankType {
        case all, home, away
    }
    
    override func getData() {
        isLoadData = false
        hud.show(animated: true)
        rankHandler.getRankBigSmall(
            leagueId: leagueId,
            seasonId: seasonId,
            success: {
                rankBigSmallData in
                self.isRequestFailed = false
                self.isLoadData = true
                self.rankBigSmallData = rankBigSmallData
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.hud.hide(animated: true)
                self.isRequestFailed = true
                self.rankBigSmallData = FBLeagueRankBigSmallDataModel(all: [], home: [], away: [])
        })
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
    
    @IBAction func allRankBtnClick(_ sender: UIButton) {
        rankBtnSelect(sender: sender, rank: .all)
    }
    
    @IBAction func homeRankBtnClick(_ sender: UIButton) {
        rankBtnSelect(sender: sender, rank: .home)
    }
    
    @IBAction func awayRankBtnClick(_ sender: UIButton) {
        rankBtnSelect(sender: sender, rank: .away)
    }
}

extension FBLeagueRankBigSmallViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        if TSScreen.currentWidth == TSScreen.iPhone5Width {
            rankLabelLeftConstraint.constant = 8
            statisticsLabelWidthConstraint.constant = 60
        } else if TSScreen.currentWidth == TSScreen.iPhone6Width {
            rankLabelLeftConstraint.constant = 12
            statisticsLabelWidthConstraint.constant = 72
        } else if TSScreen.currentWidth == TSScreen.iPhone6PlusWidth {
            rankLabelLeftConstraint.constant = 16
            statisticsLabelWidthConstraint.constant = 84
        }
    }
    
    private func initNetwork() {
        getData()
    }
    
    private func rankBtnSelect(sender: UIButton, rank: RankType) {
        allRankBtn.isSelected = rank == .all
        homeRankBtn.isSelected = rank == .home
        awayRankBtn.isSelected = rank == .away
        
        rankType = rank
    }
    
}

extension FBLeagueRankBigSmallViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLeagueRankBigSmallTableCell, for: indexPath)!
        let row = indexPath.row
        let bigSmall = dataSource[row]
        cell.configCell(bigSmall: bigSmall, rank: row + 1)
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let bigSmall = dataSource[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: bigSmall.teamId)
        ctrl.title = bigSmall.teamName
        navigationController?.pushViewController(ctrl, animated: true)
    }
}


extension FBLeagueRankBigSmallViewController {
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -34
    }
}

