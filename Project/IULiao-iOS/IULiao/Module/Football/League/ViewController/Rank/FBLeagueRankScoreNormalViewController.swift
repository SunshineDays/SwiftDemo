//
//  FBLeagueRankScoreNormalViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/21.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
import DZNEmptyDataSet

private let kCollectionViewHeight: CGFloat = 24
private let kNumberOfItemsInRow = 4

/// 联赛 排行榜 积分榜(普通)
class FBLeagueRankScoreNormalViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var allRankBtn: UIButton!
    @IBOutlet weak var homeRankBtn: UIButton!
    @IBOutlet weak var awayRankBtn: UIButton!
    @IBOutlet weak var rankScoreHeaderView: FBLeagueRankScoreHeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!

    /// 排行榜类型
    private var teamType = TeamType.none {
        didSet {
            tableView.reloadData()
            tipView.isHidden = teamType != .none
            let height = kCollectionViewHeight * ceil(CGFloat(rankScoreData.grades.count) / CGFloat(kNumberOfItemsInRow))
            collectionViewHeightConstraint.constant = teamType == .none ? height : 0
            
            if dataSource.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    /// 显示模式
    private var displayModeType = DisplayModeType.statistics {
        didSet {
            rankScoreHeaderView.configView(groupName: nil, displayMode: displayModeType)
            tableView.reloadData()
        }
    }
    private let rankHandler = FBLeagueRankHandler()
    var rankScoreData = FBLeagueRankScoreDataModel(json: JSON.null) {
        didSet {
            tableView?.reloadData()
            collectionView?.reloadData()
            if collectionViewHeightConstraint != nil {
                let height = kCollectionViewHeight * ceil(CGFloat(rankScoreData.grades.count) / CGFloat(kNumberOfItemsInRow))
                collectionViewHeightConstraint.constant = height
            }
            if dataSource.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    private var dataSource: [FBLeagueRankScoreModel] {
        switch teamType {
        case .none: return rankScoreData.all
        case .home: return rankScoreData.home
        case .away: return rankScoreData.away
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    enum DisplayModeType {
        /// 统计
        case statistics
        /// 近期战绩
        case matchResult
    }

    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    @IBAction func recentMatchBtnClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        displayModeType = sender.isSelected ? .matchResult : .statistics
    }
    
    @IBAction func allRankBtnClick(_ sender: UIButton) {
        rankBtnSelect(sender: sender, team: .none)
    }
    
    @IBAction func homeRankBtnClick(_ sender: UIButton) {
        rankBtnSelect(sender: sender, team: .home)
    }
    
    @IBAction func awayRankBtnClick(_ sender: UIButton) {
        rankBtnSelect(sender: sender, team: .away)
    }
}

extension FBLeagueRankScoreNormalViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.register(R.nib.fbLeagueRankScoreStatisticsTableCell)
        tableView.register(R.nib.fbLeagueRankScoreMatchResultTableCell)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.fbLeagueRankGradeCollectionViewCell)
    }
    
    private func rankBtnSelect(sender: UIButton, team: TeamType) {
        allRankBtn.isSelected = team == .none
        homeRankBtn.isSelected = team == .home
        awayRankBtn.isSelected = team == .away
        
        teamType = team
    }
    
}

extension FBLeagueRankScoreNormalViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        let row = indexPath.row
        let score = dataSource[row]
        if displayModeType == .statistics {
            let v = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLeagueRankScoreStatisticsTableCell, for: indexPath)!
            v.configCell(score: score, rank: row + 1)
            cell = v
        } else {
            let v = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLeagueRankScoreMatchResultTableCell, for: indexPath)!
            v.configCell(score: score, rank: row + 1)
            cell = v
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let score = dataSource[indexPath.row]
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

extension FBLeagueRankScoreNormalViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankScoreData.grades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbLeagueRankGradeCollectionViewCell, for: indexPath)!
        cell.configCell(grade: rankScoreData.grades[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(TSScreen.currentWidth / CGFloat(kNumberOfItemsInRow))
        return CGSize(width: width, height: kCollectionViewHeight)
    }
}

extension FBLeagueRankScoreNormalViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        return TSEmptyDataViewHelper.dzn_emptyDataAttributedString()
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -34
    }
}
