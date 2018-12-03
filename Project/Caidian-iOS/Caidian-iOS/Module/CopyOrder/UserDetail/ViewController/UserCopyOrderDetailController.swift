//
//  UserCopyOrderDetailController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/20.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 复制跟单 用户详情
class UserCopyOrderDetailController: BaseViewController {
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var orderCountLabel: UILabel!
    @IBOutlet weak var winMoneyLabel: UILabel!
    @IBOutlet weak var copOrderNumberLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    private let detailHandler = CopyOrderUserDetailHandler()
    
    private var dataSource = [UserCopyOrderUserHistoryModel]()
    
    private var pageInfoModel: TSPageInfoModel!

    private var userId = Int()
    
    public func initWith(userId: Int) {
        self.userId = userId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wr_setNavBarBarTintColor(UIColor.clear)
        wr_setNavBarBackgroundAlpha(0)
        wr_setNavBarShadowImageHidden(true)
        
        initView()
        
        MBProgressHUD.showAdded(to: view, animated: true)
        getCopyUserInfor()
        getCopyUserHistory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UserCopyOrderDetailController {
    private func initView() {
        initTableView()
        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        let footer = BaseRefreshAutoFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.isHidden = true
        tableView.mj_footer = footer
    }
    
    private func initTableView() {
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.register(R.nib.userCopyOrderHistoryCell)
        tableView.tableFooterView = UIView()
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
        view.addSubview(tableView)
    }
    
    private func configHeaderView(model: UserCopyOrderUserInfoModel) {
        if let url = TSImageURLHelper.init(string: model.user.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
            avatarImageView.sd_setImage(with: url, placeholderImage: R.image.empty.image50x50(), completed: nil)
        } else {
            avatarImageView.image = R.image.empty.image50x50()
        }
        nicknameLabel.text = model.user.nickname
        orderCountLabel.text = "总发单：" + model.rankAll.orderCount.string() + " 单"
        winMoneyLabel.text = model.rankAll.totalBonus.decimal(2)
        copOrderNumberLabel.text = model.rankAll.copyCount.string()
    }
    
    @objc func headerRefresh() {
        getCopyUserHistory()
    }
    
    @objc func footerRefresh() {
        if !dataSource.isEmpty {
            getCopyUserHistory(page: pageInfoModel.page + 1)
        }
        else {
            tableView.mj_footer.endRefreshing()
        }
    }
}

extension UserCopyOrderDetailController {
    private func getCopyUserInfor() {
        detailHandler.copyUserInfor(userId: userId, success: { [weak self] (model) in
            self?.configHeaderView(model: model)
        }) { (error) in
            
        }
    }
    
    private func getCopyUserHistory(page: Int = 1) {
        detailHandler.copyUserHistory(userId: userId, page: page, pageSize: 20, success: { [weak self] (list, pageInfoModel) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            self?.pageInfoModel = pageInfoModel
            if page == 1 {
                self?.dataSource.removeAll()
            }
            self?.dataSource = (self?.dataSource ?? []) + list
            self?.tableView.reloadData()
            self?.tableView.mj_header.endRefreshing()
            if self?.dataSource.count == 0 || pageInfoModel.dataCount == self?.dataSource.count {
                self?.tableView.mj_footer.isHidden = true
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self?.tableView.mj_footer.isHidden = false
                self?.tableView.mj_footer.endRefreshing()
            }
        }) { [weak self] (error) in
            self?.tableView.mj_header.endRefreshing()
            self?.tableView.mj_footer.endRefreshing()
        }
    }
}

extension UserCopyOrderDetailController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userCopyOrderHistoryCell, for: indexPath)!
        cell.configCell(model: dataSource[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let ctrl = CopyOrderDetailViewController()
        ctrl.hidesBottomBarWhenPushed = true
        ctrl.orderId = dataSource[indexPath.section].orderId
        ctrl.canCopyOrder = dataSource[indexPath.section].endTime > NSDate().timeIntervalSince1970
        navigationController?.pushViewController(ctrl, animated: true)
    }
}
