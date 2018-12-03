//
//  FBTeamDetailViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/11/6.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

/// 每行cell的个数
private let kNumberOfItemsInRow = 4
private let kRowHeight: CGFloat = 100
private let kHeaderHeight: CGFloat = 32

/// 球队详情
class FBTeamDetailViewController: TSEmptyViewController, FBTeamViewControllerProtocol {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var teamDetailInfoView: FBTeamDetailInfoView!
    @IBOutlet weak var teamDetailHistoryMatchView: FBTeamDetailHistoryMatchView!
    @IBOutlet weak var teamDetailMatchView: FBTeamDetailMatchView!
    @IBOutlet weak var teamDetailGoalSpreadView: FBTeamDetailGoalSpreadView!
    @IBOutlet weak var teamDetailGloryView: UIView!
    @IBOutlet weak var teamDetailRecentView: UIView!
    
    
    @IBOutlet weak var teamDetailRecentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var teamDetailHistoryMatchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var teamDetailMatchViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var teamDetailGloryHeightConstraint: NSLayoutConstraint!
    
    /// 球队id
    var teamId: Int!
    
    private var dataSource = [FBTeamDetailModel.Glory]() {
        didSet {
            collectionView.reloadData()
            if dataSource.count == 0 {
                teamDetailGloryView.isHidden = true
                teamDetailGloryHeightConstraint.constant = 0
            } else {
                teamDetailGloryView.isHidden = false
                let height = dataSource.reduce(0) {
                    initHeight, glory -> CGFloat in
                    let height = CGFloat(ceil(CGFloat(glory.seasonList.count) / CGFloat(kNumberOfItemsInRow))) * kRowHeight
                    return initHeight + height + kHeaderHeight
                }
                teamDetailGloryHeightConstraint.constant = CGFloat(24 + 16 + 16) + height
            }
        }
    }
    
    private let teamHandler = FBTeamHandler()
    override var isRequestFailed: Bool {
        didSet {
            contentView.isHidden = isRequestFailed
            scrollView.reloadEmptyDataSet()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initNetwork()
    }
    
    override func getData() {
        hud.show(animated: true)
        teamHandler.getDetail(teamId: teamId, success: { (detail) in
            self.setupDetailData(detail: detail)
            self.hud.hide(animated: true)
            self.isRequestFailed = false
        }) { (error) in
            self.hud.hide(animated: true)
            self.isRequestFailed = true
        }
    }
}

extension FBTeamDetailViewController {
    
    private func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        scrollView.emptyDataSetSource = self
        scrollView.emptyDataSetDelegate = self
    }
    
    private func initNetwork() {
        getData()
    }
    
    /// 根据数据配置view 并对view显示隐藏
    private func setupDetailData(detail: FBTeamDetailModel) {
        parent?.navigationItem.title = detail.teamInfo.name
        navigationItem.title = detail.teamInfo.name

        teamDetailInfoView.configView(team: detail.teamInfo)
        if detail.historyMatchList.count == 0 {
            teamDetailHistoryMatchView.isHidden = true
            teamDetailHistoryMatchViewHeightConstraint.constant = 0
        } else {
            teamDetailHistoryMatchView.configView(teamId: teamId, matchList: detail.historyMatchList)
        }
        if let nextMatch = detail.nextMatch {
            teamDetailMatchView.configView(match: nextMatch)
        } else {
            teamDetailMatchView.isHidden = true
            teamDetailMatchViewHeightConstraint.constant = 0
        }
        teamDetailGoalSpreadView.configView(detail: detail)
        dataSource = detail.gloryList
        
        if detail.historyMatchList.count == 0 && detail.nextMatch == nil {
            teamDetailRecentView.isHidden = true
            teamDetailRecentViewBottomConstraint.constant = -50
        }
    }
}

extension FBTeamDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[safe: section]?.seasonList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbTeamDetailGloryCollectionViewCell, for: indexPath)!
        let glory = dataSource[indexPath.section]
        let season = glory.seasonList[indexPath.row]
        cell.configCell(season: season, cup: glory.cupType ?? .first)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: R.reuseIdentifier.fbTeamDetailGloryHeaderView, for: indexPath)!
        let glory = dataSource[indexPath.section]
        view.configView(glory: glory)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.width, height: kHeaderHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(collectionView.width / CGFloat(kNumberOfItemsInRow))
        return CGSize(width: width, height: kRowHeight)
    }
}

extension FBTeamDetailViewController {

    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -32
    }
}
