//
//  FBLeagueScheduleRoundViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/25.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol FBLeagueScheduleRoundViewControllerDelegate: class {
    /// 轮次选中
    func leagueScheduleRound(_ ctrl: FBLeagueScheduleRoundViewController, selectRound round: FBLeagueStageModel.GroupModel)
}

/// 联赛 赛事 轮次选择
class FBLeagueScheduleRoundViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: FBLeagueScheduleRoundViewControllerDelegate?
    
    var roundList = [FBLeagueStageModel.GroupModel]()
    var selectedRound: FBLeagueStageModel.GroupModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

}

extension FBLeagueScheduleRoundViewController {
    
    private func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension FBLeagueScheduleRoundViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(collectionView.width / 4)
        return CGSize(width: width, height: 38)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roundList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbLeagueScheduleRoundCollectionViewCell, for: indexPath)!
        let round = roundList[indexPath.row]
        var isSelected = false
        if let selectedRound = selectedRound {
            isSelected = selectedRound.id == round.id
        }
        
        cell.configCell(round: round, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let round = roundList[indexPath.row]
        delegate?.leagueScheduleRound(self, selectRound: round)
        navigationController?.popViewController(animated: true)
    }
}
