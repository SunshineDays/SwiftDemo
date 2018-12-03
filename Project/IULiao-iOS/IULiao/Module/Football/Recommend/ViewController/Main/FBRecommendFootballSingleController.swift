//
//  FBRecommendFootballSingleController.swift
//  IULiao
//
//  Created by levine on 2017/8/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh

/// 查找方式
enum TodayNewsFindWayType: Int {
    /// 按人找
    case user = 0
    /// 按比赛找
    case match = 1
}

/// 推荐 单场推荐
class FBRecommendFootballSingleController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0xe6e6e6)
        initView()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private let rankHandler = FBRecommend2RankHandler()
    
    private let todayNewsHandler = FBRecommend2TodayNewsHandler()
    /// 按人找
    private var todayNewsUserDataSource = [FBRecommend2TodayNewsFromUserModel]()
    /// 按比赛(筛选后的数据)
    private var todayNewsMatchDataSource = [FBRecommendSponsorMatchModel]()
    /// 按比赛（全部数据）
    private var allMatchDataSource = [FBRecommendSponsorMatchModel]()
    
    /// 筛选界面选中的数据
    private var selectedModels = [FBRecommendSponsorMatchModel]()
    
    /// 今日推荐查找方式
    private var findWayType = TodayNewsFindWayType.user {
        didSet {
//            tableView.mj_header.beginRefreshing()
        }
    }
    /// 彩种选择
    private var lotteryType = Lottery.jingcai {
        didSet {
            selectedModels.removeAll()
            todayNewsMatchDataSource.removeAll()
            for model in allMatchDataSource {
                switch lotteryType {
                case .all:
                    todayNewsMatchDataSource = allMatchDataSource
                case .jingcai:
                    if model.isJingCai == 1 {
                        todayNewsMatchDataSource.append(model)
                    }
                case .beidan:
                    if model.isBeiDan == 1 {
                        todayNewsMatchDataSource.append(model)
                    }
                default: break
                }
            }
            tableView.reloadData()
//            tableView.mj_header.beginRefreshing()
        }
    }
    
    // MARK: - Lazy Load

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight + topView.height + 5, width: TSScreen.currentWidth, height: TSScreen.currentHeight - (TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight + topView.height + 5) - TSScreen.tabBarHeight(self)), style: .plain)
        tableView.register(R.nib.fbRecommendTodayNewsCell)
        tableView.register(R.nib.fbRecommendTodayNewsMatchCell)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(hex: 0xe6e6e6)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    private lazy var topView: FBRecommendTopView = {
        let view = Bundle.main.loadNibNamed("FBRecommendTopView", owner: nil, options: nil)?.last as! FBRecommendTopView
        view.frame = CGRect(x: 0, y: TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight, width: TSScreen.currentWidth, height: 85)
        return view
    }()
    
    private lazy var tabHeaderView: FBRecommendRankTabbleHeaderView = {
        let view = Bundle.main.loadNibNamed("FBRecommendRankTabbleHeaderView", owner: nil, options: nil)?.last as! FBRecommendRankTabbleHeaderView
        view.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: 279)
        view.delegate = self
        view.userButton.addTarget(self, action: #selector(userButtonAction(_:)), for: .touchUpInside)
        view.matchButton.addTarget(self, action: #selector(matchButtonAction(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var sectionHeaderView: FBRecommend2TodayNewsMatchSectionTitleView = {
        let view = R.nib.fbRecommend2TodayNewsMatchSectionTitleView.firstView(owner: nil)!
        view.allButton.addTarget(self, action: #selector(allButtonAction(_:)), for: .touchUpInside)
        view.jingCaiButton.addTarget(self, action: #selector(jingCaiButtonAction(_:)), for: .touchUpInside)
        view.beiDanButton.addTarget(self, action: #selector(BeiDanButtonAction(_:)), for: .touchUpInside)
        view.selectButton.addTarget(self, action: #selector(selecteButtonAction(_:)), for: .touchUpInside)
        return view
    }()
}
// MARK: - Init
extension FBRecommendFootballSingleController {
    private func initView() {
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(FBRecommendFootballSingleController.headerRefresh))
        view.addSubview(topView)
        view.addSubview(tableView)
        tableView.mj_header.beginRefreshing()
    }
}

// MARK: - Request
extension FBRecommendFootballSingleController {
    /// 盈利达人
    private func getPayoffRankListData() {
        rankHandler.getSingle(rankType: .payoff, region: .order10, oddsType: .football, success: { [weak self] (modelList) in
            self?.tableView.mj_header.endRefreshing()
            self?.tabHeaderView.payoffPercentModels = modelList
            self?.tableView.tableHeaderView = self?.tabHeaderView
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            self?.tableView.mj_header.endRefreshing()
        }
    }
    
    /// 今日推荐 按人找
    private func getTodayNewFromUser() {
        todayNewsHandler.getTodayNewsFromUser(success: { [weak self] (list) in
            FBProgressHUD.isHidden()
            self?.tableView.mj_header.endRefreshing()
            self?.todayNewsUserDataSource = list
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            FBProgressHUD.isHidden()
            self?.tableView.mj_header.endRefreshing()
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
    
    /// 今日推荐 按比赛
    private func getTodayNewFromMatch() {
        todayNewsHandler.getTodayNewsFromMatch(success: { [weak self] (list) in
            FBProgressHUD.isHidden()
            self?.tableView.mj_header.endRefreshing()
            self?.allMatchDataSource = list
            self?.sectionHeaderView.lotteryType = (self?.lotteryType)!
            self?.lotteryType = (self?.sectionHeaderView.lotteryType)!
        }) { [weak self] (error) in
            FBProgressHUD.isHidden()
            self?.tableView.mj_header.endRefreshing()
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBRecommendFootballSingleController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return findWayType == .user ? todayNewsUserDataSource.count : todayNewsMatchDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if findWayType == .user {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendTodayNewsCell, for: indexPath)!
            cell.setupConfigView(model: todayNewsUserDataSource[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendTodayNewsMatchCell, for: indexPath)!
            cell.setupConfigView(model: todayNewsMatchDataSource[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return findWayType == .user ? 120 : 55
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sectionHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return findWayType == .user ? 0 : 40
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if findWayType == .user {
            //推荐详情
            tableView.deselectRow(at: indexPath, animated: true)
            let vc = FBRecommendDetailController()
            vc.hidesBottomBarWhenPushed = true
            vc.initWith(resourceId: todayNewsUserDataSource[indexPath.row].id)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: todayNewsMatchDataSource[indexPath.row].mid, lottery: .all, selectedTab: .recommend)
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - FBRecommendRankTabbleHeaderViewDelegate
extension FBRecommendFootballSingleController: FBRecommendRankTabbleHeaderViewDelegate {
    func rankTabHeaderView(_ rankTabHeaderView: FBRecommendRankTabbleHeaderView, didClickIcon index: Int?) {
        //专家页
        let vc = FBRecommendExpertController()
        vc.hidesBottomBarWhenPushed = true
        vc.initWith(userId: self.tabHeaderView.payoffPercentModels![index!].userId, oddsType: .football)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

// MARK: - Action
extension FBRecommendFootballSingleController {
    //刷新方法
    @objc private func headerRefresh() {
        getPayoffRankListData()
        findWayType == .user ? getTodayNewFromUser() : getTodayNewFromMatch()
    }
    
    /// 按人找
    @objc private func userButtonAction(_ button: UIButton) {
        findWayType = .user
        FBProgressHUD.showProgress()
        getTodayNewFromUser()
        tabHeaderView.findWayType = findWayType
    }
    
    /// 按比赛 找
    @objc private func matchButtonAction(_ button: UIButton) {
        findWayType = .match
        FBProgressHUD.showProgress()
        getTodayNewFromMatch()
        tabHeaderView.findWayType = findWayType
    }
    
    /// 全部
    @objc private func allButtonAction(_ button: UIButton) {
        lotteryType = .all
        sectionHeaderView.lotteryType = lotteryType
    }
    /// 竞彩
    @objc private func jingCaiButtonAction(_ button: UIButton) {
        lotteryType = .jingcai
        sectionHeaderView.lotteryType = lotteryType
    }
    /// 北单
    @objc private func BeiDanButtonAction(_ button: UIButton) {
        lotteryType = .beidan
        sectionHeaderView.lotteryType = lotteryType
    }
    /// 筛选
    @objc private func selecteButtonAction(_ button: UIButton) {
        let vc = FBRecommendSponsorMatchSelectController()
        todayNewsMatchDataSource.removeAll()
        for model in allMatchDataSource {
            switch lotteryType {
            case .all:
                todayNewsMatchDataSource = allMatchDataSource
            case .jingcai:
                if model.isJingCai == 1 {
                    todayNewsMatchDataSource.append(model)
                }
            case .beidan:
                if model.isBeiDan == 1 {
                    todayNewsMatchDataSource.append(model)
                }
            default: break
            }
        }
        vc.initWithModels(allArray: todayNewsMatchDataSource, selectedArray: selectedModels, lotteryType: nil) { (selectedModels, lotteryType) in
            self.selectedModels = selectedModels
            if selectedModels.count > 0 {
                self.todayNewsMatchDataSource = selectedModels
                self.tableView.reloadData()
            } else {
                self.lotteryType = self.sectionHeaderView.lotteryType
            }
        }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

