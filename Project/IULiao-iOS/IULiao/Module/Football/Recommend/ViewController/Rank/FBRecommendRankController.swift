//
//  FBRecommendRankController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/2.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh

/// 推荐 排行榜
class FBRecommendRankController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = "单场推荐"
        initView()
        initNetwork()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var recommendSelectsView: UIView!
    @IBOutlet weak var recommendRankView: FBPulldownButtonView!
    @IBOutlet weak var recommendTimeView: FBPulldownButtonView!
    
    @IBOutlet weak var jingcaiSelectsView: UIView!
    @IBOutlet weak var jingcaiBunchView: FBPulldownButtonView!
    @IBOutlet weak var jingcaiRankView: FBPulldownButtonView!
    @IBOutlet weak var jingcaiTimeView: FBPulldownButtonView!
    
    @IBOutlet weak var selectResultLabel: UILabel!

    /**
     * oddsType - 玩法类型
     * regionType - 时间类型
     * rankType - 榜单类型
     */
    public func initWith(oddsType: RecommendDetailOddsType = .football, regionType: RecommendRegionType = .day7, rankType: RecommendRankType = .payoff) {
        self.oddsType = oddsType
        self.regionType = regionType
        self.rankType = rankType
    }
    
    /// 玩法类型
    private var oddsType: RecommendDetailOddsType = .football
    /// 时间类型
    private var regionType: RecommendRegionType = .day7
    /// 榜单类型
    private var rankType: RecommendRankType = .payoff
    
    private let recommendHandler = FBRecommend2RankHandler()
    
    /// 收藏
    private let commonAttentionHandler = CommonAttentionHandler()
    
    private var dataSource = [FBRecommend2RankModel]() {
        didSet {
            tableView.reloadData()
        }
    }
}

// MARK: - Init
extension FBRecommendRankController {
    private func initView() {
        recommendSelectsView.isHidden = oddsType != .football
        jingcaiSelectsView.isHidden = oddsType == .football
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 50
        tableView.dataSource = self
        tableView.delegate = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.getData()
        })
        if #available(iOS 11.0, *) {
            
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    private func initNetwork() {
        self.getData()
    }
}

// MARK: - Request
extension FBRecommendRankController {
    func getData() {
        FBProgressHUD.showProgress()
        recommendHandler.getSingle(rankType: rankType, region: regionType, oddsType: oddsType, success: { [weak self] (modelList) in
            FBProgressHUD.isHidden()
            self?.configView()
            self?.dataSource = modelList
            self?.tableView.mj_header.endRefreshing()
        }) { [weak self] (error) in
            TSToast.showNotificationWithTitle(error.localizedDescription)
            FBProgressHUD.isHidden()
            self?.tableView.mj_header.endRefreshing()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBRecommendRankController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendRankCell, for: indexPath)!
        let model = dataSource[indexPath.row]
        cell.configView(model: model, index: indexPath.row, rankType: rankType)
        cell.isAttentionButton.tag = indexPath.row
        cell.isAttentionButton.addTarget(self, action: #selector(attentionAction(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FBRecommendExpertController()
        vc.hidesBottomBarWhenPushed = true
        vc.initWith(userId: dataSource[indexPath.row].user.id, oddsType: oddsType == .football ? .football : .jingcai)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Action
extension FBRecommendRankController {
    /// 选择串关
    private func jingcaiBunchViewTitleButtonAction() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let array = [RecommendDetailOddsType.single, RecommendDetailOddsType.serial]
        for (index, title) in array.enumerated() {
            alertController.addAction(UIAlertAction.init(title: title.rankMessage, style: .default, handler: { (action) in
                self.oddsType = array[index]
                self.tableView.mj_header.beginRefreshing()
            }))
        }
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// 选择榜单
    private func rankViewTitleButtonAction() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        var array = [RecommendRankType]()
        if oddsType == .football {
            array = [.keepWin, .payoff, .hitPercent, .keepLost]
        } else {
            array = [.payoff, .hitPercent]
        }
        for (index, title) in array.enumerated() {
            if oddsType == .football {
                alertController.addAction(UIAlertAction.init(title: title.message, style: .default, handler: { (action) in
                    self.rankType = array[index]
                    self.tableView.mj_header.beginRefreshing()
                }))
            } else {
                alertController.addAction(UIAlertAction.init(title: title.jingcaiMessage, style: .default, handler: { (action) in
                    self.rankType = array[index]
                    self.tableView.mj_header.beginRefreshing()
                }))
            }
        }
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    /// 选择时间
    private func timeViewTitleButtonAction() {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let array = [RecommendRegionType.order10, RecommendRegionType.day7, RecommendRegionType.day30, RecommendRegionType.all]
        for (index, title) in array.enumerated() {
            alertController.addAction(UIAlertAction.init(title: title.message, style: .default, handler: { (action) in
                self.regionType = array[index]
                self.tableView.mj_header.beginRefreshing()
            }))
        }
        alertController.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func attentionAction(_ button: UIButton) {
        let model = dataSource[button.tag]
        if model.isAttention {
            // 取消关注
            commonAttentionHandler.sendUnAttention(module: .recommend_statistic, resourceId: model.user.id, success: { (json) in
                self.dataSource[button.tag].isAttention = false
                let indexPath = IndexPath.init(row: button.tag, section: 0)
                let cell = self.tableView.cellForRow(at: indexPath) as! FBRecommendRankCell
                cell.isAttentionButton.setImage(R.image.fbRecommend2.attention(), for: .normal)
            }) { (error) in
                
            }
        } else {
            // 关注
            commonAttentionHandler.sendAttention(module: .recommend_statistic, resourceId: model.user.id, success: { (json) in
                self.dataSource[button.tag].isAttention = true
                let indexPath = IndexPath.init(row: button.tag, section: 0)
                let cell = self.tableView.cellForRow(at: indexPath) as! FBRecommendRankCell
                cell.isAttentionButton.setImage(R.image.fbRecommend2.attentionS(), for: .normal)
            }) { (error) in
                
            }
        }
    }
}

// MARK: - Method
extension FBRecommendRankController {
    func configView() {
        self.recommendRankView.titleLabel.text = self.rankType.message
        self.recommendTimeView.titleLabel.text = self.regionType.message
        self.jingcaiBunchView.titleLabel.text = self.oddsType.rankMessage
        self.jingcaiRankView.titleLabel.text = self.rankType.jingcaiMessage
        self.jingcaiTimeView.titleLabel.text = self.regionType.message
        self.recommendRankView.blockTitleButtonAction = { sender in
            self.rankViewTitleButtonAction()
        }
        self.recommendTimeView.blockTitleButtonAction = { sender in
            self.timeViewTitleButtonAction()
        }
        self.jingcaiBunchView.blockTitleButtonAction = { sender in
            self.jingcaiBunchViewTitleButtonAction()
        }
        self.jingcaiRankView.blockTitleButtonAction = { sender in
            self.rankViewTitleButtonAction()
        }
        self.jingcaiTimeView.blockTitleButtonAction = { sender in
            self.timeViewTitleButtonAction()
        }
        self.selectResultLabel.text = self.oddsType == .football ? self.rankType.show : self.rankType.jingcaiShow
    }
}

