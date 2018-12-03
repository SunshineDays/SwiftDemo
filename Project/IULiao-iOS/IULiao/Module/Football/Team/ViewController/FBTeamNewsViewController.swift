//
// Created by tianshui on 2017/11/8.
// Copyright (c) 2017 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SwiftyJSON

/// 球队新闻
class FBTeamNewsViewController: TSListViewController, FBTeamViewControllerProtocol {
    
    var teamId: Int!

    /// 列表请求
    var teamHandler = FBTeamHandler()

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
extension FBTeamNewsViewController {

    private func initView() {
        tableView.register(R.nib.newsOrdinaryCell)

        tableView.mj_header?.lastUpdatedTimeKey = description

        firstRefreshing()
    }

    /// 载入数据
    override func loadData(_ page: Int) {
        
        teamHandler.getNewsList(
            teamId: teamId,
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
                    var lists = list as [NewsModel]
                    let min = max(self.dataSource.count - pageInfo.pageSize, 0)
                    for i in min..<self.dataSource.count {
                        let news = self.dataSource[i] as! NewsModel
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
extension FBTeamNewsViewController {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.newsOrdinaryCell, for: indexPath)!
        let news = dataSource[indexPath.row] as! NewsModel
        cell.configCell(news: news)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let news = dataSource[indexPath.row] as! NewsModel
        let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: news.id)
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

}

