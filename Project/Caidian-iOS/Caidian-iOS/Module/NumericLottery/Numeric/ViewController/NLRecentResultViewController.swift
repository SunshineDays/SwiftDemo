//
// Created by tianshui on 2018/5/17.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol NLRecentResultViewControllerProtocol {
    var lottery: LotteryType { get set }
    var play: PlayType { get set }
}

/// 数字彩近期开奖结果 投注页下拉展示
class NLRecentResultViewController: TSEmptyViewController, NLRecentResultViewControllerProtocol {

    private var issueList = [LotteryIssueModel]()
    var tableHeight: CGFloat {
        return 10 * tableCellHeight
    }
    private var tableCellHeight: CGFloat = 30
    var tableView = UITableView()
    var lottery = LotteryType.none
    var play = PlayType.none


    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        getData()
    }

    override func getData() {
        TSToast.showLoading(view: view)
        LotteryIssueHandler().recentResultList(
                lottery: lottery,
                success: {
                    issueList in
                    TSToast.hideHud(for: self.view)
                    self.isLoadData = true
                    self.isRequestFailed = false
                    self.issueList = issueList
                    self.tableView.reloadData()
                },
                failed: {
                    error in
                    TSToast.hideHud(for: self.view)
                    TSToast.showText(view: self.view, text: error.localizedDescription)
                    self.isRequestFailed = true
                    self.tableView.reloadData()
                })
    }
}


extension NLRecentResultViewController {

    private func initView() {
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = []

        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}

extension NLRecentResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issueList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("tableView(tableView:indexPath:) has not been implemented")
    }
}

extension NLRecentResultViewController {
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
}
