//
//  FBRecommendJingcaiBunchController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/24.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD

/// 推荐 竞彩2串1
class FBRecommendJingcaiBunchController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0xe6e6e6)
        initView()
//        initNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private let recommendHandler = FBRecommend2RankHandler()
    
    private let bunchHandler = FBRecommend2BunchHandler()
    
    /// 推荐方案
    private var bunchDataSource = [FBRecommend2BunchModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    /// 推荐方案展开数据数组
    private var userDataSource = [[FBRecommend2BunchUserModel]]() {
        didSet {
            
        }
    }
    
    /// 记录列表展开状态
    private var flagArray = [Bool]()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight, width: TSScreen.currentWidth, height: TSScreen.currentHeight - (TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight) - TSScreen.tabBarHeight(self)), style: .plain)
        tableView.register(R.nib.fbRecommend2BunchCell)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        }
        self.view.addSubview(tableView)
        return tableView
    }()
    
    private lazy var tabHeaderView: FBRecommendRankTabbleHeaderView = {
        let view = Bundle.main.loadNibNamed("FBRecommendRankTabbleHeaderView", owner: nil, options: nil)?.last as! FBRecommendRankTabbleHeaderView
        view.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: 279 - 100)
        view.delegate = self
        return view
    }()
    
}

// MARK: - Init
extension FBRecommendJingcaiBunchController {
    private func initView() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header.beginRefreshing()
    }
    
    private func initNetwork() {
        getRankListData()
        getBunchListData()
    }
}

// MARK: - Request
extension FBRecommendJingcaiBunchController {
    /// 竞彩达人
    private func getRankListData() {
        recommendHandler.getSingle(rankType: .hitPercent, region: .order10, oddsType: .jingcai, success: { [weak self] (modelList) in
            self?.tableView.tableHeaderView = self?.tabHeaderView
            self?.tabHeaderView.hitPercentModels = modelList
            self?.tableView.mj_header.endRefreshing()
        }) { [weak self] (error) in
            self?.tableView.mj_header.endRefreshing()
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
    /// 2串1列表
    private func getBunchListData() {
        bunchHandler.getBunchList(success: { [weak self] (models) in
            self?.bunchDataSource.removeAll()
            self?.flagArray.removeAll()
            self?.userDataSource.removeAll()
            for _ in models {
                self?.flagArray.append(false)
                self?.userDataSource.append([FBRecommend2BunchUserModel]())
            }
            self?.bunchDataSource = models
        }) { (error) in
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
    
    /// 展开列表数据
    private func getBunchUserListData(section: Int) {
        MBProgressHUD.showAdded(to: view, animated: true)
        bunchHandler.getBunchDetailList(userId: bunchDataSource[section].id, success: { [weak self] (models) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            self?.userDataSource[section] = models
            self?.tableView.reloadSections(IndexSet.init(integer: section), with: .automatic)
        }) { [weak self] (error) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBRecommendJingcaiBunchController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return bunchDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagArray[section] == false ? 0 : userDataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommend2BunchCell, for: indexPath)!
        cell.setupConfigView(model: userDataSource[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = userDataSource[indexPath.section][indexPath.row]
        return model.oddstype == .single ? 80 : 160
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = R.nib.fbRecommend2BunchHeaderView.firstView(owner: nil)!
        view.setupConfigView(model: bunchDataSource[section], isExpand: self.flagArray[section]) {
            self.flagArray[section] = !self.flagArray[section]
            if self.flagArray[section] && self.userDataSource[section].count == 0 {
                self.getBunchUserListData(section: section)
            } else {
                tableView.reloadSections(IndexSet.init(integer: section), with: .automatic)
            }
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FBRecommendDetailController()
        vc.hidesBottomBarWhenPushed = true
        vc.initWith(resourceId: userDataSource[indexPath.section][indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - FBRecommendRankTabbleHeaderViewDelegate
extension FBRecommendJingcaiBunchController: FBRecommendRankTabbleHeaderViewDelegate {
    func rankTabHeaderView(_ rankTabHeaderView: FBRecommendRankTabbleHeaderView, didClickIcon index: Int?) {
        //专家页
        let vc = FBRecommendExpertController()
        vc.hidesBottomBarWhenPushed = true
        vc.initWith(userId: self.tabHeaderView.hitPercentModels![index!].userId, oddsType: .jingcai)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

// MARK: - Action
extension FBRecommendJingcaiBunchController {
    /// 下拉刷新
    @objc private func headerRefresh() {
        initNetwork()
    }
    
}

