//
//  FBLiveFilterLeagueViewController.swift
//  IULiao
//
//  Created by tianshui on 16/8/1.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//


import UIKit
import MJRefresh

/// Delegate
protocol FBLiveFilterLeagueViewControllerDelegate: class {
    func liveFilterLeagueViewController(dataDidChange data: FBLiveDataModel2)
}

/// 选择类型
private enum LeagueSelectOperate {
    case selectAll
    case clearAll
    case reverse
}

/// 比分联赛筛选 注意:全不选视为全选
class FBLiveFilterLeagueViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initListener()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    
    public func initWith(liveData: FBLiveDataModel2) {
        self.liveData = liveData
        
    }
    
    /// 上个界面给的数据
    private var liveData = FBLiveDataModel2()

    private let liveMatchListHandler = FBLiveMatchListHandler()
    
    /// FBLiveFilterLeagueViewControllerDelegate
    weak var delegate: FBLiveFilterLeagueViewControllerDelegate?
    
    private var dataSource = [[FBLiveLeagueModel]]()
    private var indexTitles = [String]()
    
    // 缓存的数据
//    private var liveDataCache = [Lottery: FBLiveDataModel2]()
    
}

// MARK: - Init
extension FBLiveFilterLeagueViewController {
    private func initData() {
        updateLiveData(liveData)
    }
    
    private func initListener() {
        liveMatchListHandler.delegate = self
        if liveData.leagueList.count > 0 {
//            liveDataCache[liveData.lottery] = liveData
        } else {
            liveMatchListHandler.executeFetchMatchList(liveData.selectIssue, lottery: liveData.lottery)
        }
    }
    
    private func initView() {
        view.bringSubview(toFront: hud)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBLiveFilterLeagueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FBLiveFilterLeagueViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FBLiveFilterLeagueCollectionCell.reuseCollectionViewCellIdentifier, for: indexPath) as! FBLiveFilterLeagueCollectionCell

        let league = dataSource[collectionView.tag][indexPath.item]
        cell.configCell(league: league)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let league = dataSource[collectionView.tag][indexPath.item]
        dataSource[collectionView.tag][indexPath.item].isSelected = !league.isSelected
        if let index = liveData.leagueList.index(where: {$0.id == league.id}) {
            liveData.leagueList[index].isSelected = !league.isSelected
        }
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK:- FBLiveMatchListHandlerDelegate
extension FBLiveFilterLeagueViewController: FBLiveMatchListHandlerDelegate {
    
    func liveMatchListHandler(_ handler: FBLiveMatchListHandler, didFetchedData data: FBLiveDataModel2) {
        updateLiveData(data)
        hud.hide(animated: true)
    }
    
    func liveMatchListHandler(_ handler: FBLiveMatchListHandler, didError error: NSError) {
        var data = liveData
        data.allMatchList = []
        data.leagueList = []
        updateLiveData(data)
        hud.hide(animated: true)
    }
    
}


// MARK: - Action
extension FBLiveFilterLeagueViewController {
    /// 完成
    @IBAction func done(_ sender: UIBarButtonItem) {
        if isSelectAllOrUnSelectAllLeague().isUnSelectAll {
            leagueSelectOperate(.selectAll)
        }
        
        delegate?.liveFilterLeagueViewController(dataDidChange: liveData)
        let _ = navigationController?.popViewController(animated: true)
    }
    
    /// 全选
    @IBAction func selectAllLeague(_ sender: UIButton) {
        leagueSelectOperate(.selectAll)
        tableView.reloadData()
    }
    
    /// 清空
    @IBAction func clearAllLeague(_ sender: UIButton) {
        leagueSelectOperate(.clearAll)
        tableView.reloadData()
    }
    
    /// 反选
    @IBAction func reverseLeague(_ sender: UIButton) {
        leagueSelectOperate(.reverse)
        tableView.reloadData()
    }
}

// MARK: - Method
extension FBLiveFilterLeagueViewController {
    
    /// 联赛改变操作
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
                if let index = liveData.leagueList.index(where: {$0.id == league.id}) {
                    liveData.leagueList[index].isSelected = isSelected
                }
            }
        }
    }
    
    private func updateLiveData(_ data: FBLiveDataModel2) {
        
//        if data.leagueList.count > 0 {
//            // 设置缓存
//            liveDataCache[data.lottery] = data
//        }
//        if let cacheData = liveDataCache[liveData.lottery] {
//            // 从缓存中读取数据
//            liveData = cacheData
//        }
        (indexTitles, dataSource) = liveData.leaugeGroupByFirstCharter()
        
        if isSelectAllOrUnSelectAllLeague().isSelectAll {
            leagueSelectOperate(.clearAll)
        }
        tableView.reloadData()
    }
    
    /// 是否全选或全未选
    private func isSelectAllOrUnSelectAllLeague() -> (isSelectAll: Bool, isUnSelectAll: Bool) {
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

