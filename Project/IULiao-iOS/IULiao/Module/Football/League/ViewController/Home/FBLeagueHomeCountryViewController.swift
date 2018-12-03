//
//  FBLeagueHomeCountryViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 每行cell的个数
private let kNumberOfItemsInRow = 4

/// 资料库首页 大洲下的 国家赛事
class FBLeagueHomeCountryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var leagueCountry: [FBLeagueCountryModel]!
    /// 已经展开的国家id
    private var expandCountryId = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

extension FBLeagueHomeCountryViewController {
    
    private func initView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension FBLeagueHomeCountryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = indexPath.row
        // 查出第几个国家被展开了
        let expandCountryIndex = leagueCountry.index { $0.id == expandCountryId } ?? 0
        let leagues = leagueCountry[expandCountryIndex].leagues
        let leagueBeginIndex = kNumberOfItemsInRow * Int(floor(Double(expandCountryIndex) / Double(kNumberOfItemsInRow)) + 1)
        let leagueMaxCount = Int(ceil(Double(leagues.count) / Double(kNumberOfItemsInRow))) * kNumberOfItemsInRow
        let leagueEndIndex = leagueBeginIndex + leagueMaxCount
        
        let width = collectionView.width / CGFloat(kNumberOfItemsInRow)
        if row >= leagueBeginIndex && row < leagueEndIndex {
            return CGSize(width: width, height: 34)
        }
        return CGSize(width: width, height: 38)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 查出当前展开的国家,如果没有则取第一个国家
        guard let country = leagueCountry.filter({ $0.id == expandCountryId }).first ?? leagueCountry.first else  {
            return 0
        }
        
        let leagueMaxCount = Int(ceil(Double(country.leagues.count) / Double(kNumberOfItemsInRow))) * kNumberOfItemsInRow
        let countryMaxCount = Int(ceil(Double(leagueCountry.count) / Double(kNumberOfItemsInRow))) * kNumberOfItemsInRow
        return countryMaxCount + leagueMaxCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = indexPath.row
        // 查出第几个国家被展开了
        let expandCountryIndex = leagueCountry.index { $0.id == expandCountryId } ?? 0
        let leagues = leagueCountry[expandCountryIndex].leagues
        let leagueBeginIndex = kNumberOfItemsInRow * Int(floor(Double(expandCountryIndex) / Double(kNumberOfItemsInRow)) + 1)
        let leagueMaxCount = Int(ceil(Double(leagues.count) / Double(kNumberOfItemsInRow))) * kNumberOfItemsInRow
        let leagueEndIndex = leagueBeginIndex + leagueMaxCount
        
        var cell: UICollectionViewCell!
        
        if row < leagueBeginIndex {
            // 联赛之前的国家cell
            let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbLeagueHomeCountryCollectionViewCell, for: indexPath)!
            if row < leagueCountry.count {
                let country = leagueCountry[row]
                _cell.configCell(country: country, isSelected: expandCountryIndex == row)
            } else {
                _cell.configCellEmpty()
            }
            cell = _cell
        } else if row >= leagueBeginIndex && row < leagueEndIndex {
            // 展开国家下属联赛cell
            let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbLeagueHomeCountryLeagueCollectionViewCell, for: indexPath)!
            let leagueIndex = row - leagueBeginIndex
            // 每行的第一个cell与最后一个cell的背景特殊处理
            let showLeftSpace = leagueIndex % kNumberOfItemsInRow == 0
            let showRightSpace = leagueIndex % kNumberOfItemsInRow == (kNumberOfItemsInRow - 1)
            
            if leagues.count > leagueIndex {
                let league = leagues[leagueIndex]
                _cell.configCell(league: league, showLeftSpace: showLeftSpace, showRightSpace: showRightSpace)
            } else {
                _cell.configCell(league: nil, showLeftSpace: showLeftSpace, showRightSpace: showRightSpace)
            }
            cell = _cell
        } else if row >= leagueEndIndex {
            // 联赛后面的国家cell
            let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.fbLeagueHomeCountryCollectionViewCell, for: indexPath)!
            if row - leagueMaxCount < leagueCountry.count {
                let country = leagueCountry[row - leagueMaxCount]
                _cell.configCell(country: country, isSelected: false)
            } else {
                _cell.configCellEmpty()
            }
            cell = _cell
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        // 查出第几个国家被展开了
        let expandCountryIndex = leagueCountry.index { $0.id == expandCountryId } ?? 0
        let leagues = leagueCountry[expandCountryIndex].leagues
        let leagueBeginIndex = kNumberOfItemsInRow * Int(floor(Double(expandCountryIndex) / Double(kNumberOfItemsInRow)) + 1)
        let leagueMaxCount = Int(ceil(Double(leagues.count) / Double(kNumberOfItemsInRow))) * kNumberOfItemsInRow
        let leagueEndIndex = leagueBeginIndex + leagueMaxCount
        
        if row < leagueBeginIndex {
            // 联赛之前的国家cell
            if row < leagueCountry.count {
                let country = leagueCountry[row]
                expandCountryId = country.id
            }
        } else if row >= leagueBeginIndex && row < leagueEndIndex {
            collectionView.deselectItem(at: indexPath, animated: true)
            // 展开国家下属联赛cell
            let leagueIndex = row - leagueBeginIndex
            let league = leagues[safe: leagueIndex]
            if let league = league {
                let ctrl = TSEntryViewControllerHelper.fbLeagueMainViewController(leagueId: league.id, seasonId: nil)
                ctrl.title = league.fullName
                ctrl.title = league.fullName
                ctrl.hidesBottomBarWhenPushed = true
                navigationController?.pushViewController(ctrl, animated: true)
            }
        } else if row >= leagueEndIndex {
            // 联赛后面的国家cell
            if row - leagueMaxCount < leagueCountry.count {
                let country = leagueCountry[row - leagueMaxCount]
                expandCountryId = country.id
            }
        }
    }
}
