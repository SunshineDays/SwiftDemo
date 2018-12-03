//
//  RecommendExpertController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 专家主页
class RecommendExpertController: TSEmptyViewController {
    
    
    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var winNumberLabel: UILabel!
    
    @IBOutlet weak var keepWinNumberLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let recommendHandler = RecommendHandler()
    
    private var pageInfoModel: PageInfoModel!
    
    private var dataSource = [RecommendExpertListModel]()
    
    private var allModel: RecommendExpertModel! {
        didSet {
            if let url = TSImageURLHelper(string: allModel.statistic.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
                avatarButton.sd_setImage(with: url, for: .normal, placeholderImage: R.image.empty.image100x100(), completed: nil)
            } else {
                avatarButton.setImage(R.image.empty.image100x100(), for: .normal)
            }
            
            nicknameLabel.text = allModel.statistic.name
            winNumberLabel.text = allModel.order.orderCount.string() + "中" + allModel.order.win.string()
            keepWinNumberLabel.text = allModel.order.keepWin.string() + "连红"
        }
    }
    
    /// 专家id
    public var professorId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wr_setNavBarBarTintColor(UIColor.clear)
        wr_setNavBarShadowImageHidden(true)
        wr_setNavBarBackgroundAlpha(0)
        navigationItem.title = "专家主页"
        initView()
        initNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func getData() {
        getRecommendExpertListData()
    }
}

extension RecommendExpertController {
    private func initView() {
        initTableView()
        initTableViewRefresh()
    }

    private func initTableView() {
        tableView.register(R.nib.recommendExpertCell)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    private func initTableViewRefresh() {
        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        let footer = BaseRefreshAutoFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        footer.isHidden = true
        tableView.mj_footer = footer
    }
    
    private func initNetwork() {
        MBProgressHUD.showProgress(toView: view)
        getRecommendExpertListData()
    }
    
    
    @objc func headerRefresh() {
        getRecommendExpertListData()
    }
    
    @objc func footerRefresh() {
        if !dataSource.isEmpty {
            getRecommendExpertListData(page: pageInfoModel.page + 1)
        }
        else {
            tableView.mj_footer.endRefreshing()
        }
    }
    
}


extension RecommendExpertController {
    private func getRecommendExpertListData(page: Int = 1) {
        recommendHandler.recommendExpertInfo(professorId: professorId, page: page, pageSize: 20, success: { [weak self] (model) in
            self?.isLoadData = true
            self?.isRequestFailed = false
            if let view = self?.view {
                MBProgressHUD.hide(for: view)
            }
            self?.allModel = model
            self?.pageInfoModel = model.pageInfo
            if page == 1 {
                self?.dataSource.removeAll()
            }
            self?.dataSource = (self?.dataSource ?? []) + model.list
            self?.tableView.mj_header.endRefreshing()
            if self?.dataSource.count == 0 || self?.pageInfoModel.dataCount == self?.dataSource.count {
                self?.tableView.mj_footer.isHidden = true
                self?.tableView.mj_footer.endRefreshingWithNoMoreData()
            } else {
                self?.tableView.mj_footer.isHidden = false
                self?.tableView.mj_footer.endRefreshing()
            }
            self?.tableView.reloadData()
        }) { [weak self] (error) in
            if let s = self {
                s.isLoadData = s.dataSource.count > 0
                s.isRequestFailed = true
                s.tableView.mj_header.endRefreshing()
                s.tableView.reloadData()
                MBProgressHUD.hide(for: s.view)
                TSToast.showText(view: s.view, text: error.localizedDescription)
            }
        }
    }
}

extension RecommendExpertController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.recommendExpertCell, for: indexPath)!
        cell.comfigCell(model: dataSource[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return RecommendExpertCell.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = R.storyboard.recommend.recommendDetailController()!
        vc.recommendId = dataSource[indexPath.section].id
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension RecommendExpertController {
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
