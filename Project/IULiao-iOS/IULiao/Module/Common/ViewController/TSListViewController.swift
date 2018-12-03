//
//  TSListViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/10/10.
// 
//

import UIKit
import MJRefresh
import SnapKit

let listImageSize = CGSize(width: 300, height: 200)

/// 列表基类(分页不分页均可使用) 不基于UITableViewController是因为有局限
class TSListViewController: BaseViewController {
    
    var tableView = UITableView()
    
    /// 数据源
    var dataSource = [BaseModelProtocol]()
    
    /// 分页信息
    var pageInfo = TSPageInfoModel(page: 1, pageSize: 20)
    
    /// 载入中label
    var loadingLabel: UILabel = {
        let l = UILabel()
        l.text = "有料体育"
        l.font = UIFont.boldSystemFont(ofSize: 17)
        l.textColor = UIColor.gray
        l.textAlignment = .center
        return l
    }()
    
    /// 空数据label
    var emptyLable: UILabel = {
        let l = UILabel()
        l.text = "暂无数据"
        l.textColor = UIColor.gray
        l.textAlignment = .center
        l.isHidden = true
        return l
    }()
    
    /// 重试按钮
    var retryBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("加载失败,请重试", for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 自己设置inset 即使有navbar和tabbar 也能在下面半透明显示内容
        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // 不显示多余分割线
        self.tableView.tableFooterView = UIView()
        
        // 下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader{
            [weak self] () -> Void in
            self?.tableView.mj_footer?.resetNoMoreData()
            self?.emptyLable.isHidden = true
            self?.retryBtn.isHidden = true
            
            // 重置页数
            _ = self?.pageInfo.resetPage()
            self?.loadData(1)
        }

        retryBtn.addTarget(self, action: #selector(TSListViewController.retryLoadData), for: .touchUpInside)

        self.view.addSubview(self.tableView)
        self.view.addSubview(self.loadingLabel)
        self.view.addSubview(self.emptyLable)
        self.view.addSubview(self.retryBtn)
        
//        self.initLayout()
        
    }
    
    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.tableView.snp.makeConstraints {
            [weak self](make) -> Void in
            guard let me = self else {
                return
            }
            make.top.equalTo(me.view)//.offset(-64)
            make.bottom.equalTo(me.view)
            make.left.equalTo(me.view)
            make.right.equalTo(me.view)
        }

        let closure = {
            [weak self](make: ConstraintMaker) -> Void in
            guard let me = self else {
                return
            }
            make.centerX.equalTo(me.view.snp.centerX)
            make.centerY.equalTo(me.view.snp.centerY)
            make.width.equalTo(me.view.snp.width)
            make.height.equalTo(44)
        }
        
        self.loadingLabel.snp.updateConstraints(closure)
        self.emptyLable.snp.updateConstraints(closure)
        self.retryBtn.snp.updateConstraints(closure)
    }
}

/// method
extension TSListViewController {
    
//    func initLayout() {
//        let top = TSScreen.statusBarHeight + TSScreen.navgationBarHeight(self)
//        let bottom = TSScreen.tabBarHeight(self)
//        // 设置inset
//        let insets = UIEdgeInsetsMake(top, 0, bottom, 0)
//        self.tableView.contentInset = insets
//        self.tableView.scrollIndicatorInsets = insets
//    }
    
    /// 加载数据方法 子类需重写此方法
    @objc func loadData(_ page: Int) {
        self.endRefreshing()
    }
    
    /// 尝试重新加载数据
    @objc func retryLoadData() {
        if self.tableView.mj_header != nil {
            self.tableView.mj_header?.beginRefreshing()
        } else {
            self.loadData(1)
        }
    }
    
    /// 第一次加载
    func firstRefreshing() {
        self.loadingLabel.isHidden = false
        self.emptyLable.isHidden   = true
        self.retryBtn.isHidden     = true
        
        self.tableView.mj_header?.beginRefreshing()
    }
    
    /// 结束加载 子类需使用此方法结束刷新
    func endRefreshing(isSuccess: Bool = true) {
        // 停止下拉刷新
        if self.tableView.mj_header != nil && self.tableView.mj_header.isRefreshing {
            self.tableView.mj_header?.endRefreshing()
        }
        // 停止上拉刷新
        if self.tableView.mj_footer != nil && self.tableView.mj_footer.isRefreshing {
            self.tableView.mj_footer?.endRefreshing()
        }
        
        if pageInfo.hasMorePage() {
            // 有更多页
            if self.tableView.mj_footer == nil {
                // 创建上拉加载
                let footer = MJRefreshAutoNormalFooter {
                    [weak self] () -> Void in
                    // 下一页
                    if let page = self?.pageInfo.nextPage() {
                        self?.loadData(page)
                    }
                }
                // 被弃用了
//                footer?.isAutomaticallyHidden = true
                footer?.triggerAutomaticallyRefreshPercent = 0.2
                self.tableView.mj_footer = footer
            }
        } else {
            // 无更多页
            self.tableView.mj_footer?.endRefreshingWithNoMoreData()
        }
        
        self.loadingLabel.isHidden = true
        
        if isSuccess {
            if self.dataSource.count == 0 {
                self.emptyLable.isHidden = false
            } else {
                self.emptyLable.isHidden = true
            }
            self.retryBtn.isHidden = true
        } else {
            if self.pageInfo.isFirstPage() && self.dataSource.count == 0{
                self.retryBtn.isHidden = false
            }else {
                self.retryBtn.isHidden = true
            }
        }
    }
}

/// UITableViewDelegate, UITableViewDataSource
extension TSListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 去除tableview 分割线不紧挨着左边
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
