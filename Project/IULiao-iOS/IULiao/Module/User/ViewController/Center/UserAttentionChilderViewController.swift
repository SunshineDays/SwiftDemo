//
//  UserAttentionChilderViewController.swift
//  IULiao
//
//  Created by levine on 2017/9/1.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
private let KNewsOrdinaryCell = "NewsOrdinaryCell"
private let KUserAttentionAnalystCell = "UserAttentionAnalystCell"
private let KUserAttentioRecommendCell = "UserAttentioRecommendCell"

class UserAttentionChilderViewController: TSListViewController {
    //MARK:变量区
    var commendAttentionHandler = CommonAttentionHandler()
    /// 分页信息
//    var pageInfo = TSPageInfoModel(page: 1)
    //关注 handler
    private var recommendAttentionHandler = CommonAttentionHandler()

    var list = [BaseModelProtocol]()

//    var attentionRecommendList = [FBRecommendExpertHistoryModel]()
//
//    var attentionNewsList = [NewsModel]()

    //MARK:监听 属性变化
    var commendAttentionType: ModuleAttentionType?
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: TSNotification.userIsAttention.notification, object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initListener()
        firstRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.updateConstraints { (make) in
            make.edges.equalTo(view)
        }

    }

}
extension UserAttentionChilderViewController {
    func initView() {
        tableView.register(UINib(nibName: KNewsOrdinaryCell, bundle: nil), forCellReuseIdentifier: KNewsOrdinaryCell)
        tableView.register(UINib(nibName: KUserAttentionAnalystCell, bundle: nil), forCellReuseIdentifier: KUserAttentionAnalystCell)
        tableView.register(UINib(nibName: KUserAttentioRecommendCell, bundle: nil), forCellReuseIdentifier: KUserAttentioRecommendCell)
        tableView.mj_header?.lastUpdatedTimeKey = "UserVisitListViewControllerLastUpdatedTimeKey"
        commendAttentionHandler.delegate = self
    }
    private func initListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(userIsAttentionAction), name: TSNotification.userIsAttention.notification, object: nil)        
    }
    /// 载入数据
    override func loadData(_ page: Int) {
        //暂时没有分页处理
        commendAttentionHandler.attentionType = commendAttentionType
        commendAttentionHandler.executeAttentionList(module: commendAttentionType ?? .recommend_statistic,page: pageInfo.page,pageSize: pageInfo.pageSize)
    }

    /// 用户关注或取消 通知
    @objc private final func  userIsAttentionAction() {

        commendAttentionHandler.executeAttentionList(module: commendAttentionType ?? .recommend_statistic, page: pageInfo.page, pageSize: pageInfo.pageSize)
    }

}
extension UserAttentionChilderViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ModuleAttentionType.recommend_statistic == commendAttentionType {
            let analystCell = tableView.dequeueReusableCell(withIdentifier: KUserAttentionAnalystCell, for: indexPath) as! UserAttentionAnalystCell
            analystCell.delegate = self
            analystCell.indexPath = indexPath
            analystCell.expertModel = dataSource[indexPath.row] as? FBRecommendRankModel
            analystCell.unAttentionType = { button, userId in
                self.postUnAttentionData(button: button, userId: userId, index: indexPath.row)
            }
            return analystCell
        } else if ModuleAttentionType.recommend == commendAttentionType {
            let recommendCell = tableView.dequeueReusableCell(withIdentifier: KUserAttentioRecommendCell, for: indexPath) as! UserAttentioRecommendCell
            recommendCell.configAttentionRecommendHistoryModel(recommendHistoryModel: dataSource[indexPath.row] as? FBRecommendExpertHistoryModel)
            return recommendCell
        } else {
            let newsCell = tableView.dequeueReusableCell(withIdentifier: KNewsOrdinaryCell, for: indexPath) as! NewsOrdinaryCell
            newsCell.configCell(news: (dataSource[indexPath.row] as? NewsModel)!)
            return newsCell
        }
    }
    
    /// 取消关注
    func postUnAttentionData(button: UIButton, userId: Int, index: Int) {
        button.isUserInteractionEnabled = false
        recommendAttentionHandler.sendUnAttention(module: .recommend_statistic, resourceId: userId, success: { (json) in
            self.dataSource.remove(at: index)
            self.tableView.deleteRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
            button.isUserInteractionEnabled = true
        }) { (error) in
            button.isUserInteractionEnabled = true
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if ModuleAttentionType.recommend_statistic == commendAttentionType {
            return 60
        } else if ModuleAttentionType.recommend == commendAttentionType {
            return 80
        } else {
            return 86
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ModuleAttentionType.recommend_statistic == commendAttentionType {
//            let guessHonorVc = FBRecommendJingCaiHonorDetialViewController()
            let vc = FBRecommendExpertController()
            vc.initWith(userId: (dataSource[indexPath.row] as? FBRecommendRankModel)?.userId ?? 0, oddsType: .football)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        } else if ModuleAttentionType.recommend == commendAttentionType {
//            let fbSingleRecommendDetialVc = FBRecommendSingleMatchDetialViewController()
//            fbSingleRecommendDetialVc.resourceId = (dataSource[indexPath.row] as? FBRecommendExpertHistoryModel)?.id
//            navigationController?.pushViewController(fbSingleRecommendDetialVc, animated: true)
            
            let vc = FBRecommendDetailController()
            vc.initWith(resourceId: (dataSource[indexPath.row] as? FBRecommendExpertHistoryModel)?.id ?? 0)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            if let id = tableView.cellForRow(at: indexPath)?.tag {
                let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: id)
                navigationController?.pushViewController(ctrl, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
}
extension UserAttentionChilderViewController: CommonAttentionHandlerDelegate {

    func commonAttentionHandler(_ handler: CommonAttentionHandler, attentionType type: ModuleAttentionType, didAttentionList List: [BaseModelProtocol]?, pageInfo: TSPageInfoModel) {
        if let list = List {
            if self.pageInfo.isFirstPage() {
                // 第一页直接赋值
                self.pageInfo.pageCount = pageInfo.pageCount
                self.pageInfo.dataCount = pageInfo.dataCount
                self.dataSource = list
            } else {

                self.dataSource += list
            }
       }
        tableView.reloadData()
        endRefreshing(isSuccess: true)
    }
    func commonAttentionHandler(_ handler: CommonAttentionHandler, didFaild error: NSError) {
        TSToast.showNotificationWithMessage(error.localizedDescription)
        endRefreshing(isSuccess: false)
    }
}
extension UserAttentionChilderViewController: UserAttentionAnalystCellDelegate {

    func userAttentionAnalystCell(_ userAttentionAnalystCell: UserAttentionAnalystCell,didClickFollow followBtn: UIButton, currentRow row: Int) {
        if !followBtn.isSelected {
            recommendAttentionHandler.sendAttention(module: ModuleAttentionType.recommend_statistic, resourceId: (userAttentionAnalystCell.expertModel?.userId)!, success: {
                [weak self] _ in
                TSToast.hudTextLoad(view: (self?.view)!, text: "关注成功", mode: .text, margin: 10, duration: 2)
                userAttentionAnalystCell.expertModel?.isAttention = true
                followBtn.isSelected = true
                followBtn.layer.borderWidth = (userAttentionAnalystCell.expertModel?.isAttention)! ? 0 : 1
                var expertModel =  self?.dataSource[row] as? FBRecommendRankModel
                expertModel?.isAttention = true
            }) { (error) in
                TSToast.showNotificationWithTitle(error.localizedDescription)

            }
        }else {
            recommendAttentionHandler.sendUnAttention(module: ModuleAttentionType.recommend_statistic, resourceId: (userAttentionAnalystCell.expertModel?.userId)!, success: {
                [weak self] (_) in
                TSToast.hudTextLoad(view: (self?.view)!, text: "取消关注", mode: .text, margin: 10, duration: 2)
                userAttentionAnalystCell.expertModel?.isAttention = false
                followBtn.isSelected = false
                followBtn.layer.borderWidth = (userAttentionAnalystCell.expertModel?.isAttention)! ? 0 : 1
                var expertModel =  self?.dataSource[row] as? FBRecommendRankModel
                expertModel?.isAttention = false
                }, failed: { (error) in
                    TSToast.showNotificationWithTitle(error.localizedDescription)
            })
        }
    }
}
