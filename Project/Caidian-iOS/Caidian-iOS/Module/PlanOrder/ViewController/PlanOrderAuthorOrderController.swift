//
//  PlanOrderAuthorOrderController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/26.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 计划跟单 发起人 计划单历史记录
class PlanOrderAuthorOrderController: BaseViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var footerLabel: UILabel!
    
    private let planOrderHandler = PlanOrderHandler()
    
    private var dataSource = [PlanOrderAuthorOrderModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    public var planId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        let header = BaseRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshData))
        tableView.mj_header = header
        tableView.mj_header.beginRefreshing()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let allTouches = event?.allTouches
        let touch = allTouches?.first ?? UITouch()
        let point = touch.location(in: view)
        let x = point.x
        let y = point.y
        if x < backgroundView.x || x > backgroundView.frame.maxX {
            dismissCtrl()
        }
        if y < backgroundView.y || y > backgroundView.frame.maxY {
            dismissCtrl()
        }
    }
    
    @objc func refreshData() {
        getAuthorOrderListData()
    }
    
    private func dismissCtrl() {
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
}

extension PlanOrderAuthorOrderController {
    private func getAuthorOrderListData() {
        planOrderHandler.planOrderAuthorOrderList(planId: planId, success: { [weak self] (list, remark) in
            self?.tableView.emptyDataSetSource = self
            self?.tableView.mj_header.endRefreshing()
            self?.dataSource = list
            self?.tableView.reloadData()
            self?.footerLabel.text = remark
        }) { [weak self] (error) in
            self?.tableView.mj_header.endRefreshing()
            if let view = self?.view {
                TSToast.showText(view: view, text: error.localizedDescription)
             }
        }
    }
}


extension PlanOrderAuthorOrderController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.planOrderAuthorOrderCell, for: indexPath)!
        cell.configCell(model: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = dataSource.count > 0 ? UIColor(hex: 0xE6E6E6) : UIColor.clear
        return view
    }
}

extension PlanOrderAuthorOrderController: DZNEmptyDataSetSource {
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        var attributes = [NSAttributedStringKey : Any]()
        attributes[.font] = UIFont.systemFont(ofSize: 13)
        attributes[.foregroundColor] = UIColor.darkGray
        return NSAttributedString(string: "暂无记录", attributes: attributes)
    }
}
