//
//  RecommendDetailController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 推荐详情
class RecommendDetailController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var footerView: UIView!
    
    private let cartView = R.nib.recommendFooterCartView.firstView(owner: nil)!
    
    private let recommendHandler = RecommendHandler()
    
    private var model: RecommendDetailModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var rowHeight: CGFloat = 500
    
    private var dataSourceCount = 1
    
    /// 帖子的id
    public var recommendId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
//        extendedLayoutIncludesOpaqueBars = true
        initTableView()
        initCartFooterView()
        getRecommendDetailData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartView.cartNumber = UserToken.shared.userCartInfo?.count ?? 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RecommendDetailController {
    private func initTableView() {
        tableView.register(R.nib.recommendDetailCell)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
    }
    
    private func initCartFooterView() {
        footerView.addSubview(cartView)
        cartView.snp.makeConstraints { (maker) in
            maker.top.left.bottom.right.equalToSuperview()
        }
        cartView.cartNumber = UserToken.shared.userCartInfo?.count ?? 0
        cartView.delegate = self
    }
}

extension RecommendDetailController {
    private func getRecommendDetailData() {
        MBProgressHUD.showAdded(to: view, animated: true)
        recommendHandler.recommendDetail(recommendId: recommendId, success: { [weak self] (model) in
            if let view = self?.view {
                MBProgressHUD.hide(for: view, animated: true)
            }
            self?.dataSourceCount = 1
            self?.model = model
        }) { [weak self] (error) in
            if let view = self?.view {
                self?.dataSourceCount = 0
                self?.tableView.reloadData()
                MBProgressHUD.hide(for: view, animated: true)
                TSToast.showText(view: view, text: error.localizedDescription)
            }
        }
    }
}

extension RecommendDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.recommendDetailCell, for: indexPath)!
        if let model = model {
            cell.delegate = self
            cell.configCell(model: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}


extension RecommendDetailController: RecommendDetailCellDelegate {

    func recommendDetailCell(_ cell: RecommendDetailCell, didClickAvatarButton sender: UIButton) {
        if let model = model {
            let vc = R.storyboard.recommend.recommendExpertController()!
            vc.professorId = model.statistic.userId
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func recommendDetailCell(_ cell: RecommendDetailCell, webViewDidFinishLoad webView: WKWebView, rowHeight: CGFloat) {
        self.rowHeight = rowHeight
        tableView.reloadData()
    }
    
    func recommendDetailCell(_ cell: RecommendDetailCell, isGray: Bool) {
        cartView.isGray = isGray
        if let model = model {
            if model.matchInfo.saleEndTime <= Date().timeIntervalSince1970 {
                cartView.isGray = true
            }
        }
    }
}

extension RecommendDetailController: RecommendFooterCartViewDelegate {
    /// 购物车
    func recommendFooterCartView(_ view: RecommendFooterCartView, cartButtonClick sender: UIButton) {
        let vc = R.storyboard.recommend.recommendCartController()!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 加入投注
    func recommendFooterCartView(_ view: RecommendFooterCartView, addToCartButtonClick sender: UIButton) {
        if let model = model {
            if UserToken.shared.isHaveRecommend(cartInfo: model) {
                let alertController = UIAlertController(title: "您已加入过本场稳胆推荐，是否替换原先投注项？", message: nil, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                    
                }))
                alertController.addAction(UIAlertAction(title: "替换", style: .default, handler: { (action) in
                    UserToken.shared.addToCart(cartInfo: model)
                    MBProgressHUD.show(info: "添加投注成功")
                }))
                present(alertController, animated: true, completion: nil)
            } else {
                UserToken.shared.addToCart(cartInfo: model)
                cartView.addToCart()
            }
        }
    }
    
    ///立即投注
    func recommendFooterCartView(_ view: RecommendFooterCartView, betButtonClick sender: UIButton) {
//        var buyModel = SLBuyModel<JczqMatchModel, JczqBetKeyType>()
//        buyModel.lottery = .jczq
//        buyModel.play = .hh
        if let model = model {
//            buyModel.changeBetKeyList(match: model.matchInfo, betKeyList: model.recommend.code)
            let vc = TSEntryViewControllerHelper.lotteryViewController(lottery: .jczq, playType: .hh, recommendModels: [model])
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}


extension RecommendDetailController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        return TSEmptyDataViewHelper.dzn_retryButtonAttributedString(for: state)
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        getRecommendDetailData()
    }
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 0
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}

