//
// Created by tianshui on 2017/11/8.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SwiftyJSON

/// 球员 比赛表现
class FBPlayerMatchListViewController: TSListViewController, FBPlayerViewControllerProtocol {
    
    var playerId: Int!
    var contentScrollView: UIScrollView {
        return tableView
    }

    /// 列表请求
    var playerHandler = FBPlayerHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.updateConstraints{ (make) in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
}

// MARK:- method
extension FBPlayerMatchListViewController {

    private func initView() {
        tableView.separatorStyle = .none
        tableView.register(R.nib.fbPlayerMatchTableCell)

        tableView.mj_header?.lastUpdatedTimeKey = description

        firstRefreshing()
    }

    /// 载入数据
    override func loadData(_ page: Int) {

        playerHandler.getMatchList(
                playerId: playerId,
                page: page,
                pageSize: 20,
                success: {
                    list, pageInfo in
                    if self.pageInfo.isFirstPage() {
                        // 第一页直接赋值
                        self.pageInfo.pageCount = pageInfo.pageCount
                        self.pageInfo.dataCount = pageInfo.dataCount
                        self.dataSource = list
                    } else {
                        // 其他页要判断是否有重复
                        var lists = list as [FBPlayerMatchModel]
                        let min = max(self.dataSource.count - pageInfo.pageSize, 0)
                        for i in min..<self.dataSource.count {
                            let news = self.dataSource[i] as! FBPlayerMatchModel
                            if lists.contains(where: {$0.id == news.id}) {
                                if let index = lists.index(where: {$0.id == news.id}) {
                                    lists.remove(at: index)
                                }
                            }
                        }
                        self.dataSource += lists as [BaseModelProtocol]
                    }

                    self.tableView.reloadData()
                    self.endRefreshing(isSuccess: true)
                },
                failed: {
                    error in
                    TSToast.showNotificationWithMessage(error.localizedDescription)
                    self.endRefreshing(isSuccess: false)
                })

    }
}

// MARK:- tableview
extension FBPlayerMatchListViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbPlayerMatchTableCell, for: indexPath)!
        let match = dataSource[indexPath.row] as! FBPlayerMatchModel
        cell.configCell(match: match)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let match = dataSource[indexPath.row] as! FBPlayerMatchModel
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: nil)
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

}

