//
//  FBLeagueHomeRegionViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 每行cell的个数
private let kNumberOfItemsInRow = 4

/// 资料库首页 大洲下的 洲际赛事(区域赛事)
class FBLeagueHomeRegionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var leagueList: [FBLeagueModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

}

extension FBLeagueHomeRegionViewController {
    func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension FBLeagueHomeRegionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.width / CGFloat(kNumberOfItemsInRow)
        return CGSize(width: width, height: 38)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagueList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbLeagueHomeRegionCollectionViewCell, for: indexPath)!
        let league = leagueList[indexPath.row]
        cell.configCell(league: league)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let league = leagueList[indexPath.row]
        let ctrl = TSEntryViewControllerHelper.fbLeagueMainViewController(leagueId: league.id, seasonId: nil)
        ctrl.title = league.fullName
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
}
