//
// Created by levine on 2018/4/28.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import MJRefresh

/// 提现记录
class UserWithdrawListViewController: TSEmptyTableViewController {
    private let handler = UserWithdrawHandler()
    private var tableViewData = [UserWithDrawModel]()
    private var page = 1
    private var drawListModel: UserWithDrawListModel? {
        didSet {
            guard let drawListModel = drawListModel else {
                return
            }

            if page == 1 {
                tableViewData.removeAll()
            }

            if page > drawListModel.pageInfo.pageCount {
                page = drawListModel.pageInfo.page
            } else {
                drawListModel.list.forEach {
                    it in
                    tableViewData.append(it)
                }
            }

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        tableView.mj_header.beginRefreshing()

    }

    /// 获取提现记录数据
    override func getData() {
        handler.drawList(
                page: page,
                pageSize: 20,
                success: {
                    model in
                    self.drawListModel = model
                    self.isLoadData = true
                    self.isRequestFailed = false


                    self.tableView.mj_header.endRefreshing()
                    if model.pageInfo.pageCount > 1 {
                        self.tableView.mj_footer.isHidden = false
                    }
                    if self.page >= model.pageInfo.pageCount {
                        self.tableView.mj_footer.isHidden = true

                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    } else {
                        self.tableView.mj_footer.isHidden = false
                        self.tableView.mj_footer.endRefreshing()
                    }
                    self.tableView.reloadData()
                },
                failed: {
                    error in
                    self.isLoadData = false
                    self.isRequestFailed = true
                    self.tableView.mj_footer.endRefreshing()
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)

                })
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userWithdrawListTableViewCell, for: indexPath)!
        cell.configCell(userWithdrawModel: tableViewData[indexPath.row])
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) //去除点击后效果
    }
    

}

extension UserWithdrawListViewController {
    func initView() {

        /// 去掉分隔线
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableFooterView = UIView()
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self

        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshListener))
        tableView.mj_header = header
        let footer = BaseRefreshAutoFooter()
        footer.isHidden = true
        footer.setRefreshingTarget(self, refreshingAction: #selector(loadListener))
        tableView.mj_footer = footer
        
    }

    @objc func refreshListener() {
        page = 1
        getData()
    }

    @objc func loadListener() {
        page += 1
        getData()
    }
}

extension UserWithdrawListViewController {
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return  isLoadData
    }
}
