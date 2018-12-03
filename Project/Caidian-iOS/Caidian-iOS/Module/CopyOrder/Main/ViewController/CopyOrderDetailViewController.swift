//
//  CopyOrderDetailViewController.swift
//  Caidian-iOS
//
//  Created by levine on 2018/5/18.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SpriteKit
import DZNEmptyDataSet


/// 复制跟单详情
class CopyOrderDetailViewController: BaseViewController {
    
    private let tableView = UITableView()
    private var bottomView = R.nib.copyOrderDetailBottomView.firstView(owner: nil)!
    private var bottomViewHeight: CGFloat = 135
    private var headerView = R.nib.copyOrderDetailHeaderView.firstView(owner: nil)!
    
    private let resultImageView = UIImageView()
    
    private let segmentControl = HMSegmentedControl()
    private var maxTimeMatch: TimeInterval = 0
    
    private let handler = CopyOrderDetailHandler()
    private var titles = ["方案详情", "跟单用户"]
    /// 是否可以跟单
    var canCopyOrder = true
    var orderId = 0
    private var accountList = [CopyOrderAccountModel]() {
        didSet {
            titles[1] = "跟单用户(\(accountList.count))"
            segmentControl.sectionTitles = titles
        }
    }
    private var tableDataSource = [OrderDetailModel.MatchCombination]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var orderDetailModel: OrderDetailModel? {
        didSet {
            guard let orderDetailModel = orderDetailModel else {
                return
            }
            headerView.configView(orderDetail: orderDetailModel)
            headerView.avatarBlock = { sender in
                let vc =  R.storyboard.copyOrder.userCopyOrderDetailController()!
                vc.initWith(userId: orderDetailModel.copy.userId)
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            tableDataSource = orderDetailModel.matchList
            bottomView.getSeriesString(oneMoney: orderDetailModel.copy.oneMoney)
            
            resultImageView.image = orderDetailModel.order.winStatus.copyOrderImage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wr_setNavBarBackgroundAlpha(0)
        wr_setNavBarBarTintColor(UIColor.black)
        if #available(iOS 11.0, *) {

        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        NotificationCenter.default.addObserver(self, selector: #selector(buySuccess), name: TSNotification.buySuccess.notification, object: nil)
        
        bottomViewHeight = canCopyOrder ? 110 : 0
        bottomView.isHidden = !canCopyOrder
        initData()
        initView()
    }
    
    /// 购买成功
    @objc  func buySuccess(){
        initData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            headerView.height = 244
        } else {
            headerView.height = 244 + 44 + TSScreen.statusBarHeight
        }
        if tableView.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to: #selector(setter:UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - method
extension CopyOrderDetailViewController {
    private func initView() {
        do {
            view.addSubview(tableView)
            view.addSubview(bottomView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.emptyDataSetDelegate = self
            tableView.emptyDataSetSource = self
        }
        do {
            tableView.snp.makeConstraints { maker in
                maker.top.equalToSuperview()
                maker.left.equalToSuperview()
                maker.right.equalToSuperview()
                if #available(iOS 11.0, *) {
                    maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-bottomViewHeight)
                } else {
                    maker.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(-bottomViewHeight)
                }
            }
        }
        do {
            bottomView.snp.makeConstraints { maker in
                if #available(iOS 11.0, *) {
                    maker.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                } else {
                    maker.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
                }
                maker.left.equalToSuperview()
                maker.right.equalToSuperview()
                maker.height.equalTo(bottomViewHeight)
            }
        }
        do {
            segmentControl.backgroundColor = UIColor.white
            segmentControl.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.grayGamut.gamut333333,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
            ]
            segmentControl.selectedTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor.logo,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
            ]
            segmentControl.selectedSegmentIndex = 0
            segmentControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            segmentControl.selectionIndicatorColor = UIColor.logo
            segmentControl.selectionIndicatorLocation = .down
            segmentControl.selectionIndicatorColor = UIColor.logo
            segmentControl.selectionIndicatorHeight = 1.5
            segmentControl.selectionStyle = .fullWidthStripe
            segmentControl.sectionTitles = titles
        }
        do {
            resultImageView.frame = CGRect(x: 15, y: -8, width: 30, height: 30)
            resultImageView.contentMode = .scaleAspectFit
            segmentControl.addSubview(resultImageView)
        }
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        
        /// 方案详情和跟单用户切换
        segmentControl.indexChangeBlock = {
            [weak self] index in
            self?.tableView.reloadData()
        }
        /// 立即跟单
        bottomView.followClickBlock = {
            [weak self]  btn in
            
            /// 无数据情况
            if self?.orderDetailModel == nil {
                self?.initData()
                return
            }
            if UserToken.shared.userInfo?.userID != nil && UserToken.shared.userInfo!.userID == self?.orderDetailModel?.copy.userId {
                TSToast.showText(view: self!.view, text: "自己不能跟自己的方案", color: .error)
                return
            }
            self?.bottomView.nextBtn.isEnabled = false
            TSToast.showLoading(view: self!.view)
            UserAccountHandler().getAccountDetail(
                success: {
                    account in
                    self?.bottomView.nextBtn.isEnabled = true
                    TSToast.hideHud(for: self!.view)
                    let ctrl = R.storyboard.copyOrderBuy.copyOrderBuyViewController()!
                    ctrl.multiple = self?.bottomView.multiple
                    ctrl.orderDetailModel = self?.orderDetailModel
                    ctrl.totalMoney = (self?.orderDetailModel?.copy.oneMoney ?? 0) * (Double(self?.bottomView.multiple ?? 0))
                    self?.navigationController?.pushViewController(ctrl, animated: true)
            },
                failed: {
                    error in
                    self?.bottomView.nextBtn.isEnabled = true
                    TSToast.hideHud(for: self!.view)
                    TSToast.showText(view: self!.view, text: error.localizedDescription, color: .error)
            })
        }
    }
    
    private func initData() {
        TSToast.showLoading(view: view)
        handler.orderDetail(
            orderId: orderId,
            success: {
                orderDetailModel in
                self.orderDetailModel = orderDetailModel
                TSToast.hideHud(for: self.view)
                
        },
            failed: {
                error in
                TSToast.hideHud(for: self.view)
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        })
        // 跟单用户
        handler.orderAccount(
            orderId: orderId,
            page: 1,
            pageSize: 20,
            success: { models, pageInfoModel in
                self.accountList = models
        },
            failed: {
                error in
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        })
    }
    
    /// 是否显示截止公布
    private func showBetView() -> Bool {
        if UserToken.shared.userInfo?.phone == "17621746288" {
            return false
        }
        
        if segmentControl.selectedSegmentIndex != 0 {
            return false
        }
        
        if orderDetailModel == nil {
            return false
        }
        
        /// 自己发单
        if UserToken.shared.userInfo?.userID != nil && orderDetailModel?.order.userId == UserToken.shared.userInfo?.userID {
            return false
        }
        
        /// 0
        if (orderDetailModel!.order.isSecret == 0 || (orderDetailModel!.order.isSecret == 2 && (orderDetailModel?.isCopyBoolean ?? false))) {
            return false
        }
            /// 1
        else {
            //最大的时间
            maxTimeMatch = tableDataSource.first!.match.matchTime
            tableDataSource.forEach {
                if $0.match.matchTime >= maxTimeMatch {
                    maxTimeMatch = $0.match.matchTime
                }
            }
            return maxTimeMatch > Date().timeIntervalSince1970
        }
    }
}

// MARK: - UITableView
extension CopyOrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter:UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentControl.selectedSegmentIndex == 0 {
            tableView.register(R.nib.orderJczqTableCell)
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.orderJczqTableCell, for: indexPath)!
            let combination = tableDataSource[indexPath.row]
            cell.configCell(
                match: combination.match as! JczqMatchModel,
                betKeyList: combination.betKeyList as! [JczqBetKeyType],
                isMustBet: combination.isMustBet,
                letBall: Int(combination.letBall)
            )
            return cell
            
        } else {
            tableView.register(R.nib.copyOrderAccountTableViewCell)
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.copyOrderAccountTableViewCell, for: indexPath)!
            cell.configCell(copyOrderAccount: accountList[indexPath.row])
            return cell
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return 0
        return segmentControl.selectedSegmentIndex == 0 ? (showBetView() ? 0 : tableDataSource.count) : accountList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentControl.selectedSegmentIndex == 0 {
            let combination = tableDataSource[indexPath.row]
            let betKeyList = combination.betKeyList as! [JczqBetKeyType]
            let height = 50 + 15 * (betKeyList.count > 3 ? betKeyList.count - 3 : 0)
            return CGFloat(height)
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return segmentControl.selectedSegmentIndex == 0 ? (showBetView() ? 40 : 65) : 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let backView = UIView()
        backView.addSubview(segmentControl)
        segmentControl.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        let lineView = UIView()
        backView.addSubview(lineView)
        lineView.snp.makeConstraints {
            make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(segmentControl.snp.bottom)
            make.height.equalTo(TSScreen.pointToPX(point: 1))
        }
        lineView.backgroundColor = UIColor.cellSeparatorBackground
        
        if segmentControl.selectedSegmentIndex == 0 && !showBetView() {
            let firstView = OrderMatchTableHeaderView()
            backView.addSubview(firstView)
            firstView.snp.makeConstraints { make in
                make.top.equalTo(segmentControl.snp.bottom)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
        return backView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        var y = scrollView.contentOffset.y
        if #available(iOS 11.0, *) {
            y = y + 44 + TSScreen.statusBarHeight
        }
        if y >= 0 {
            wr_setNavBarBackgroundAlpha(y / 244)
        } else {
            wr_setNavBarBackgroundAlpha(0)
        }
    }
}

extension CopyOrderDetailViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var  describe = "截止后公开"
        if orderDetailModel != nil && orderDetailModel!.order.isSecret == 2  {
            describe = "复制跟单后可见"
        }
        return TSEmptyDataViewHelper.dzn_emptyDataAttributedString(title: "\(TSUtils.timestampToString(maxTimeMatch, withFormat: "MM-dd HH:mm")) \(describe)")
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return R.image.order.detailSecret()!
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return showBetView()
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return headerView.height / 2
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}


