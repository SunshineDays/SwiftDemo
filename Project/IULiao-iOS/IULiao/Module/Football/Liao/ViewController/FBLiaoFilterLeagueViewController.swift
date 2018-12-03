//
//  FBLiaoFilterLeagueViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import MJRefresh

protocol FBLiaoFilterLeagueViewControllerDelegate: class {
    func liaoFilterLeagueViewController(dataDidChange data: FBLiaoDataModel)
}

/// 爆料站联赛筛选 注意:全不选视为全选
class FBLiaoFilterLeagueViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    
    var liaoData = FBLiaoDataModel()
    weak var delegate: FBLiaoFilterLeagueViewControllerDelegate?
    
    private var dataSource = [[FBLiveLeagueModel]]()
    private var indexTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLiaoData(liaoData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


// MARK:- action
extension FBLiaoFilterLeagueViewController {
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if isSelectAllOrUnSelectAllLeague().isUnSelectAll {
            leagueSelectOperate(.selectAll)
        }
        delegate?.liaoFilterLeagueViewController(dataDidChange: liaoData)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectAllLeague(_ sender: UIButton) {
        
        leagueSelectOperate(.selectAll)
        tableView.reloadData()
    }
    
    @IBAction func clearAllLeague(_ sender: UIButton) {
        leagueSelectOperate(.clearAll)
        tableView.reloadData()
    }
    
    @IBAction func reverseLeague(_ sender: UIButton) {
        leagueSelectOperate(.reverse)
        tableView.reloadData()
    }
}

private enum LeagueSelectOperate {
    case selectAll
    case clearAll
    case reverse
}

// MARK:- method
extension FBLiaoFilterLeagueViewController {
    
    private func leagueSelectOperate(_ operate: LeagueSelectOperate) {
        for (i, leagues) in dataSource.enumerated() {
            for (j, league) in leagues.enumerated() {
                var isSelected = true
                switch operate {
                case .selectAll: isSelected = true
                case .clearAll: isSelected = false
                case .reverse: isSelected = !league.isSelected
                }
                dataSource[i][j].isSelected = isSelected
                if let index = liaoData.leagueList.index(where: {$0.id == league.id}) {
                    liaoData.leagueList[index].isSelected = isSelected
                }
            }
        }
    }
    
    func updateLiaoData(_ data: FBLiaoDataModel) {

        (indexTitles, dataSource) = liaoData.leaugeGroupByFirstCharter()
        if isSelectAllOrUnSelectAllLeague().isSelectAll {
            leagueSelectOperate(.clearAll)
        }
        
        tableView.reloadData()
    }
    
    /// 是否全选或全未选
    func isSelectAllOrUnSelectAllLeague() -> (isSelectAll: Bool, isUnSelectAll: Bool) {
        var isSelectAll = true
        var isUnselectAll = true
        for leagues in dataSource {
            for league in leagues {
                if league.isSelected {
                    isUnselectAll = false
                } else {
                    isSelectAll = false
                }
            }
        }
        return (isSelectAll, isUnselectAll)
    }
}


extension FBLiaoFilterLeagueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FBLiveFilterLeagueTableCell.reuseTableCellIdentifier, for: indexPath) as! FBLiveFilterLeagueTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let collectionViewArray = dataSource[(indexPath as NSIndexPath).section]
        return 44 * ceil(CGFloat(collectionViewArray.count) / 3)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let tableCell = cell as! FBLiveFilterLeagueTableCell
        tableCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, index: (indexPath as NSIndexPath).section)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexTitles
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        var tpIndex = 0
        //遍历索引值
        for character in indexTitles {
            //判断索引值和组名称相等，返回组坐标
            if character == title{
                return tpIndex
            }
            tpIndex += 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexTitles[section]
    }
}

extension FBLiaoFilterLeagueViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FBLiveFilterLeagueCollectionCell.reuseCollectionViewCellIdentifier, for: indexPath) as! FBLiveFilterLeagueCollectionCell
        
        let league = dataSource[collectionView.tag][(indexPath as NSIndexPath).item]
        cell.configCell(league: league)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let league = dataSource[collectionView.tag][(indexPath as NSIndexPath).item]
        dataSource[collectionView.tag][(indexPath as NSIndexPath).item].isSelected = !league.isSelected
        if let index = liaoData.leagueList.index(where: {$0.id == league.id}) {
            liaoData.leagueList[index].isSelected = !league.isSelected
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
}

