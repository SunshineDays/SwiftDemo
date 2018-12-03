//
//  FBRecommendExpertController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/11.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import MBProgressHUD

enum ExpertSelectType: String {
    case football = "足球推荐"
    case jingcai = "竞彩推荐"
}

/// 推荐 专家页
class FBRecommendExpertController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initView()
        initNetwork()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * userId - 用户id
     * oddsType - 赔率类型
     */
    public func initWith(userId: Int = 0, oddsType: RecommendDetailOddsType = .football) {
        self.userId = userId
        self.oddsType = oddsType
    }
    
    /// 用户id
    private var userId: Int = 0
    
    /// 选择的赔率类型
    private var oddsType: RecommendDetailOddsType = .football
    
    /// 关注/收藏
    private let recommendAttentionHandler = CommonAttentionHandler()
    
    /// 专家详情
    private let expertHandler = FBRecommendExpertHandler()
    
    /// 专家详情数据模型
    private var detailModel: FBRecommendExpertModel! = nil {
        didSet {
            userInfoTitleView.setupConfigView(model: detailModel.user, oddsType: oddsType)
            tableView.tableHeaderView = tableHeaderView
            tableHeaderView.setupConfigView(model: detailModel, oddsType: oddsType)
        }
    }
    
    /// 分页模型
    private var pageInfoModel: TSPageInfoModel! = nil {
        didSet {
        }
    }
    
    /// 成绩单（专家历史推荐）
    private var dataSource = [FBRecommendExpertHistoryListModel]()
    
    /// 顶部用户信息视图
    private lazy var userInfoTitleView: FBRecommendExpertUserInfoTitleView = {
        let view = R.nib.fbRecommendExpertUserInfoTitleView.firstView(owner: nil)!
        view.followButton.addTarget(self, action: #selector(follwowAction(_:)), for: .touchUpInside)
        view.segmentedControl.indexChangeBlock = { index in
            if index == 0 {
                self.oddsType = .football
            } else {
                self.oddsType = .jingcai
            }
            self.tableView.mj_header.beginRefreshing()
        }
        self.view.addSubview(view)
        return view
    }()
    
    /// tableHeaderView
    private lazy var tableHeaderView: FBRecommendExpertStatisticsView = {
        let view = R.nib.fbRecommendExpertStatisticsView.firstView(owner: nil)!
        view.oddsTypeChange = { oddsType in
            self.oddsType = oddsType
            FBProgressHUD.showProgress()
            self.getExpertHistoryData()
        }
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: userInfoTitleView.frame.maxY, width: TSScreen.currentWidth, height: TSScreen.currentHeight - userInfoTitleView.height), style: .plain)
        tableView.backgroundColor = UIColor(hex: 0xe6e6e6)
        tableView.register(R.nib.fbRecommendExpertRecordCell)
        tableView.register(R.nib.fbRecommend2BunchCell)
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = tableHeaderView
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
            tableView.estimatedSectionFooterHeight = 0
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.addSubview(tableView)
        return tableView
    }()
    
}

// MARK: - Init
extension FBRecommendExpertController {
    private func initView() {
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.initNetwork()
        })
        tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.getExpertHistoryData(page: self.pageInfoModel.page + 1)
        })
    }
    
    private func initNetwork() {
        FBProgressHUD.showProgress()
        self.getExpertDetailData()
        self.getExpertHistoryData()
    }
}

// MARK: - Request
extension FBRecommendExpertController {
    /// 专家详情
    @objc private func getExpertDetailData() {
        expertHandler.getDetail(userId: userId, success: { [weak self] (model) in
            FBProgressHUD.isHidden()
            self?.detailModel = model
        }) { (error) in
            FBProgressHUD.isHidden()
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
    
    /// 专家历史推荐
    @objc private func getExpertHistoryData(page: Int = 1) {
        expertHandler.getHistoryList(userId: userId, oddsType: oddsType, page: page, pageSize: 20, success: { (list, pageInfoModel) in
            FBProgressHUD.isHidden()
            if page == 1 {
                self.dataSource.removeAll()
            }
            self.pageInfoModel = pageInfoModel
            let array = NSMutableArray()
            array.addObjects(from: self.dataSource)
            array.addObjects(from: list)
            self.dataSource = array as! [FBRecommendExpertHistoryListModel]
            self.tableView.reloadData()
            if self.dataSource.count == self.pageInfoModel.dataCount || self.dataSource.count == 0 {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }
            else {
                self.tableView.mj_footer.endRefreshing()
            }
            self.tableView.mj_header.endRefreshing()
        }) { (error) in
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            FBProgressHUD.isHidden()
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
    
    /// 关注
    private func postAttentionData() {
        recommendAttentionHandler.sendAttention(module: .recommend_statistic, resourceId: detailModel.user.id, success: { (json) in
            self.detailModel.user.isAttention = true
            self.userInfoTitleView.isAttention = true
        }) { (error) in
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
    
    /// 取消关注
    private func postUnAttentionData() {
        recommendAttentionHandler.sendUnAttention(module: .recommend_statistic, resourceId: detailModel.user.id, success: { (json) in
            self.detailModel.user.isAttention = false
            self.userInfoTitleView.isAttention = false
        }) { (error) in
            
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBRecommendExpertController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch oddsType {
        case .football, .europe, .asianPlate, .sizePlate:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendExpertRecordCell, for: indexPath)!
            cell.setupConfigView(model: dataSource[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommend2BunchCell, for: indexPath)!
            cell.setupConfigViewWithHistory(model: dataSource[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.row]
        let jingcaiHeight: CGFloat = model.oddsType == .single ? 110 : 190
        switch oddsType {
        case .football, .europe, .asianPlate, .sizePlate:
            return 80
        default:
            return jingcaiHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FBRecommendDetailController()
        vc.hidesBottomBarWhenPushed = true
        vc.initWith(resourceId: dataSource[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Action
extension FBRecommendExpertController {
    /// 关注
    @objc private func follwowAction(_ button: UIButton) {
        if detailModel.user.id == UserToken.shared.userInfo?.id {
            FBProgressHUD.showInfor(text: "不能关注自己哦")
        }
        else {
            if !detailModel.user.isAttention {
                postAttentionData()
            }
            else {
                postUnAttentionData()
            }
        }
    }
    
}

