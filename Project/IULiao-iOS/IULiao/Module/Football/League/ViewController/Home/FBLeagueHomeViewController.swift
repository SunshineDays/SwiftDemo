//
//  FBLeagueHomeViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/13.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 资料库首页
class FBLeagueHomeViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var hotLeagueView: UIView!
    
    
    private let leagueHomeHandler = FBLeagueHomeHandler()
    private var leagueHomeData = FBLeagueHomeDataModel(json: JSON.null)
    
    private let leagueHomeBottomCtrl = R.storyboard.fbLeagueHome.fbLeagueHomeBottomViewController()!
    private lazy var retryBtn = TSEmptyDataViewHelper.createRetryButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


extension FBLeagueHomeViewController {
    
    private func initView() {
        view.addSubview(retryBtn)
        retryBtn.snp.makeConstraints {
            make in
            make.centerX.edges.equalToSuperview()
            make.centerY.edges.equalToSuperview()
            make.width.edges.equalToSuperview()
        }
        retryBtn.addTarget(self, action: #selector(retryData), for: .touchUpInside)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addChildViewController(leagueHomeBottomCtrl)
        bottomView.addSubview(leagueHomeBottomCtrl.view)
        leagueHomeBottomCtrl.view.snp.makeConstraints {
            make in
            make.edges.equalTo(bottomView)
        }
    }
    
    @objc private func retryData() {
        getData()
    }
    
    private func initNetwork() {
        leagueHomeHandler.delegate = self
        getData()
    }
    
    private func getData() {
        retryBtn.isHidden = true
        hud.show(animated: true)
        leagueHomeHandler.getHomeData()
    }
}

extension FBLeagueHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(leagueHomeData.hotLeagues.count, 8)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbLeagueHomeHotCollectionViewCell, for: indexPath)
        let league = leagueHomeData.hotLeagues[indexPath.row]
        cell?.configCell(league: league)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(TSScreen.currentWidth / 4)
        return CGSize(width: width, height: 46)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let league = leagueHomeData.hotLeagues[indexPath.row]
        
        let ctrl = TSEntryViewControllerHelper.fbLeagueMainViewController(leagueId: league.id, seasonId: nil)
        ctrl.title = league.fullName
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
}

extension FBLeagueHomeViewController: FBLeagueHomeHandlerDelegate {
    
    func leagueHomeHandler(_ handler: FBLeagueHomeHandler, didFetchedData data: FBLeagueHomeDataModel) {
        hotLeagueView.isHidden = false
        leagueHomeData = data
        leagueHomeBottomCtrl.leagueHomeData = data
        collectionView.reloadData()
        hud.hide(animated: true)
    }
    
    func leagueHomeHandler(_ handler: FBLeagueHomeHandler, didError error: NSError) {
        hud.hide(animated: true)
        retryBtn.isHidden = false
        view.bringSubview(toFront: retryBtn)
        TSToast.showNotificationWithMessage(error.localizedDescription)
    }
    
}
