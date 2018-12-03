//
//  FBOddsFilterLeagueViewController.swift
//  IULiao
//
//  Created by tianshui on 16/8/1.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//


import UIKit
import MJRefresh

protocol FBOddsFilterLeagueViewControllerDelegate: class {
    func oddsFilterLeagueViewController(dataDidChange data: FBOddsDataModel)
}

/// 赔率联赛筛选 注意:全不选视为全选
class FBOddsFilterLeagueViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    
    let oddsMatchListHandler = FBOddsMatchListHandler()
    var oddsData = FBOddsDataModel()
    var segmentedTabs = [Lottery.all, Lottery.jingcai, Lottery.beidan, Lottery.sfc]
    weak var delegate: FBOddsFilterLeagueViewControllerDelegate?
    
    private var dataSource = [[FBLiveLeagueModel]]()
    private var indexTitles = [String]()
    private var oddsDataCache = [Lottery: FBOddsDataModel]()
    
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
}


// MARK:- action
extension FBOddsFilterLeagueViewController {
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if isSelectAllOrUnSelectAllLeague().isUnSelectAll {
            leagueSelectOperate(.selectAll)
        }
        delegate?.oddsFilterLeagueViewController(dataDidChange: oddsData)
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
extension FBOddsFilterLeagueViewController {
    
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
                if let index = oddsData.leagueList.index(where: {$0.id == league.id}) {
                    oddsData.leagueList[index].isSelected = isSelected
                }
            }
        }
    }
    
    private func initData() {
        updateOddsData(oddsData)
    }
    
    private func initListener() {
        oddsMatchListHandler.delegate = self
        if oddsData.leagueList.count > 0 {
            oddsDataCache[oddsData.lottery] = oddsData
        } else {
            oddsMatchListHandler.executeFetchMatchList(oddsData.selectIssue, lottery: oddsData.lottery)
        }
    }
    
    private func initView() {
        
        view.bringSubview(toFront: hud)
        
        segmentedControl.backgroundColor = UIColor(hex: 0x191710)
        segmentedControl.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0xcccccc),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)
        ]
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionStyle = .fullWidthStripe
        segmentedControl.sectionTitles = segmentedTabs.map { $0.name }
        segmentedControl.selectedSegmentIndex = segmentedTabs.index(of: oddsData.lottery) ?? 0
        
        segmentedControl.indexChangeBlock = {
            [weak self] index in
            guard let me = self else {
                return
            }
            
            me.oddsData.lottery = me.segmentedTabs[index]
            if let data = me.oddsDataCache[me.oddsData.lottery] {
                me.updateOddsData(data)
            } else {
                me.hud.show(animated: true)
                me.oddsMatchListHandler.executeFetchMatchList(nil, lottery: me.oddsData.lottery)
            }
        }
        
    }
    
    func updateOddsData(_ data: FBOddsDataModel) {
        var data = data
        data.lottery  = oddsData.lottery
        data.companys = oddsData.companys
        data.oddsType = oddsData.oddsType
        
        if data.leagueList.count > 0 {
            // 设置缓存
            oddsDataCache[data.lottery] = data
        }
        if let cacheData = oddsDataCache[oddsData.lottery] {
            // 从缓存中读取数据
            oddsData = cacheData
        }
        (indexTitles, dataSource) = oddsData.leaugeGroupByFirstCharter()
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


extension FBOddsFilterLeagueViewController: UITableViewDelegate, UITableViewDataSource {
    
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

extension FBOddsFilterLeagueViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        if let index = oddsData.leagueList.index(where: {$0.id == league.id}) {
            oddsData.leagueList[index].isSelected = !league.isSelected
        }
        collectionView.reloadItems(at: [indexPath])
    }
    
}


// MARK:- FBOddsMatchListHandlerDelegate
extension FBOddsFilterLeagueViewController: FBOddsMatchListHandlerDelegate {
    
    func oddsMatchListHandler(_ handler: FBOddsMatchListHandler, didFetchedData data: FBOddsDataModel) {
        updateOddsData(data)
        hud.hide(animated: true)
    }
    
    func oddsMatchListHandler(_ handler: FBOddsMatchListHandler, didError error: NSError) {
        var data = oddsData
        data.allMatchList = []
        data.leagueList = []
        updateOddsData(data)
        hud.hide(animated: true)
    }
    
}
