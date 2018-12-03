//
// Created by tianshui on 2017/11/30.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import DZNEmptyDataSet
import SwiftyJSON

private let kCollectionViewHeight: CGFloat = 24
private let kNumberOfItemsInRow = 4

/// 赛事分析 积分榜
class FBMatchWarRankScoreViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {
    
    private var tableView: UITableView!
    private var lineView: UIView! // collection上面的一条线
    private var collectionView: UICollectionView!
    private var headerView: FBMatchWarRankScoreHeaderView?
    
    private var collectionViewHeight: CGFloat {
        return kCollectionViewHeight * ceil(CGFloat(rankScoreData.grades.count) / CGFloat(kNumberOfItemsInRow))
    }
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?
    
    override var isRequestFailed: Bool {
        didSet {
            tableView.reloadData()
        }
    }
    private let warHandler = FBMatchWarHandler()
    private var rankScoreData = FBLeagueRankScoreDataModel(json: JSON.null) {
        didSet {
            collectionView.snp.updateConstraints {
                make in
                make.height.equalTo(teamType == .none ? collectionViewHeight : 0)
            }
            if rankScoreData.type == .normal && teamType == .none {
                collectionView.isHidden = false
            } else {
                collectionView.isHidden = true
            }
            lineView.isHidden = collectionView.isHidden
            collectionView.reloadData()
            tableView.reloadData()
        }
    }
    private var teamType = TeamType.none {
        didSet {
            if rankScoreData.type == .normal && teamType == .none {
                collectionView.isHidden = false
            } else {
                collectionView.isHidden = true
            }
            lineView.isHidden = collectionView.isHidden
            tableView.reloadData()
            if dataSource.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    /// 显示模式
    private var displayModeType = FBLeagueRankScoreNormalViewController.DisplayModeType.statistics {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var dataSource: [FBLeagueRankScoreModel] {
        if rankScoreData.type == .group {
            return rankScoreData.section?.list ?? []
        } else {
            switch teamType {
            case .none: return rankScoreData.all
            case .home: return rankScoreData.home
            case .away: return rankScoreData.away
            }
        }
    }
    private var matchInfo = FBMatchModel(json: JSON.null)

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
        
        warHandler.getRankScore(
            matchId: matchId,
            lottery: lottery,
            success: {
                match, rankScoreData in
                self.matchInfo = match
                self.isRequestFailed = false
                self.isLoadData = true
                self.rankScoreData = rankScoreData
                self.hud.hide(animated: true)
        },
            failed: {
                error in
                self.isRequestFailed = true
                self.hud.hide(animated: true)
        })
    }
    
}

extension FBMatchWarRankScoreViewController {
    
    private func initView() {
        do {
            tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
            tableView.register(R.nib.fbLeagueRankScoreMatchResultTableCell)
            tableView.register(R.nib.fbLeagueRankScoreStatisticsTableCell)
            tableView.separatorStyle = .none
            
            view.addSubview(tableView)
            tableView.snp.makeConstraints {
                make in
                make.edges.equalToSuperview()
            }
        }
        
        do {
            let flow = UICollectionViewFlowLayout()
            flow.sectionInset = .zero
            flow.minimumLineSpacing = 0
            flow.minimumInteritemSpacing = 0
            collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = UIColor.white
            collectionView.isScrollEnabled = false
            collectionView.register(R.nib.fbLeagueRankGradeCollectionViewCell)
            
            view.addSubview(collectionView)
            collectionView.snp.makeConstraints {
                make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(kCollectionViewHeight)
            }
        }
        do {
            lineView = UIView()
            lineView.backgroundColor = TSColor.gray.gamutCCCCCC

            view.addSubview(lineView)
            lineView.snp.makeConstraints {
                make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalTo(collectionView.snp.top)
                make.height.equalTo(1 / UIScreen.main.scale)
            }
        }
    }
    
    private func initNetwork() {
        getData()
    }
  
}

extension FBMatchWarRankScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell?
        let row = indexPath.row
        let score = dataSource[row]
        var color = TSColor.gray.gamut666666
        if matchInfo.homeTid == score.teamId {
            color = TSColor.matchResult.win
        } else if matchInfo.awayTid == score.teamId {
            color = TSColor.matchResult.lost
        }
        if rankScoreData.type == .normal && displayModeType == .matchResult {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLeagueRankScoreMatchResultTableCell, for: indexPath)!
            cell.configCell(score: score, rank: row + 1, needBackgroundColor: row % 2 == 0, textColor: color)
            tableCell = cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLeagueRankScoreStatisticsTableCell, for: indexPath)!
            cell.configCell(score: score, rank: row + 1, needBackgroundColor: row % 2 == 0, textColor: color)
            tableCell = cell
        }
        return tableCell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let score = dataSource[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbTeamMainViewController(teamId: score.teamId)
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if dataSource.isEmpty {
            return 0
        }
        return rankScoreData.type == .group ? 60 : 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if dataSource.isEmpty {
            return nil
        }
    
        if headerView == nil {
            let header = headerView ?? R.nib.fbMatchWarRankScoreHeaderView.firstView(owner: nil)
            header?.displayModeClickBlock = {
                [weak self] btn, displayMode in
                self?.displayModeType = displayMode
            }
            header?.teamTypeClickBlock = {
                [weak self] teamType in
                self?.teamType = teamType
            }
            headerView = header
        }
        var title = "\(matchInfo.league.name)"
        if let groupName = rankScoreData.section?.name, rankScoreData.type == .group {
            title = "\(matchInfo.league.name)\(groupName)组"
        }
        headerView?.configView(title: title, scoreType: rankScoreData.type, teamType: teamType, displayMode: displayModeType)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if dataSource.isEmpty {
            return 0
        }
        // footer的高度与collectionView的高度一致
        if rankScoreData.type == .normal && teamType == .none {
            return collectionViewHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

}

extension FBMatchWarRankScoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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

extension FBMatchWarRankScoreViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed || isLoadData && dataSource.isEmpty
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
