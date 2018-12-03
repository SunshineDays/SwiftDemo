//
//  UserLiaoPayFlowController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/21.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 流水明细
class UserLiaoPayFlowController: BaseTableViewController {

    private var pageInfoModel: PageInfoModel!
    
    private var models = [UserLiaoPayFlowListModel]() {
        didSet {
            configDataSource(list: models)
        }
    }
    
    private var dataSource = [[UserLiaoPayFlowListModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        MBProgressHUD.showProgress(toView: view)
        getData()
    }
    
    override func getData() {
        getPayFlowData(page: 1)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userLiaoPayFlowCell, for: indexPath)!
        cell.model = dataSource[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerInSectionView(section: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension UserLiaoPayFlowController {
    private func getPayFlowData(page: Int = 1) {
        UserLiaoHandler().getLiaoPayFlowData(page: page, success: { [weak self] (model) in
            MBProgressHUD.hide(from: self?.view)
            self?.pageInfoModel = model.pageInfo
            if page == 1 {
                self?.models.removeAll()
            }
            self?.models = (self?.models ?? []) + model.list
            self?.tableView.endRefreshing(dataSource: self?.models, pageInfo: model.pageInfo)
            self?.tableView(forEmptyDataSet: true)
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            self?.tableView.endRefreshing()
            self?.tableView(forEmptyDataSet: false)
            CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        }
    }
}

extension UserLiaoPayFlowController {
    /// 把请求到的数据按月份分组
    private func configDataSource(list: [UserLiaoPayFlowListModel]) {
        dataSource.removeAll()
        var models = [UserLiaoPayFlowListModel]()
        for (index, l) in list.enumerated() {
            // 相同月份
            if models.contains(where: { createTime(model: $0) == createTime(model: l) }) {
                models.append(l)
            } else {
                // 月份不同，把models添加到dataSource
                if !models.isEmpty {
                    dataSource.append(models)
                }
                models.removeAll()
                models.append(l)
            }
            /// 循环完成，最后的models还没有添加到dataSources里，添加进去
            if index == list.count - 1 {
                dataSource.append(models)
            }
        }
    }
    
    private func createTime(model: UserLiaoPayFlowListModel) -> (year: String, month: String) {
        return (model.createTime.timeString(with: "yyyy"), model.createTime.timeString(with: "MM"))
    }
    
    private func nowTime() -> (year: String, month: String) {
        let now = Foundation.Date().timeIntervalSince1970
        return (now.timeString(with: "yyyy"), now.timeString(with: "MM"))
    }
}

extension UserLiaoPayFlowController {
    private func initTableView() {
        tableView.tableFooterView = UIView()
        tableView.mj_header = BaseRefreshHeader(refreshingBlock: {
            self.getPayFlowData(page: 1)
        })
        tableView.mj_footer = BaseRefreshAutoFooter(refreshingBlock: {
            self.getPayFlowData(page: 1)
        })
    }
    
    private func headerInSectionView(section: Int) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 40))
        view.backgroundColor = UIColor.groupTableViewBackground
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: view.width - 10, height: 40))
        label.textColor = UIColor.colour.gamut4D4D4D
        label.font = UIFont.systemFont(ofSize: 14)
        if let model = dataSource[section].first {
            if createTime(model: model) == nowTime() { //今年今月
                label.text = "本月"
            } else if createTime(model: model).year != nowTime().year { // 不是今年
                label.text = createTime(model: model).year + " " + createTime(model: model).month
            } else { // 今年非今月
                label.text = createTime(model: model).month
            }
        }
        view.addSubview(label)
        return view
    }
}

