//
//  NewsListViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/10/9.
//  Copyright © 2015年 fenlan. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON
import CRToast

private let hotImageSize = CGSize(width: 800, height: 480)
private let kPageSize : Int = 20
/// 资讯 cell 类型
enum NewsListCellType: Int {
    case loopImage = 0
    case ordinary = 1
    case manyFigure = 2
    
    var cellIdentifier: String {
        switch self {
        case .loopImage:
            return "NewsLoopImageCell"
        case .ordinary:
            return "NewsOrdinaryCell"
        case .manyFigure:
            return "NewsManyFigureCell"
        }
    }
}

/// 资讯列表
class NewsListViewController: TSListViewController {
    
    /// 列表请求
    var newsListHandler = NewsListHandler()
    
    /// 焦点图请求
    var newsTopHandler = NewsTopHandler()
    
    /// 焦点图数据
    var hotList = [NewsModel]()
    
    /// 焦点图
//    let cycleScrollView: SDCycleScrollView = {
//        let height = TSScreen.currentWidth / CGFloat(hotImageSize.width) * CGFloat(hotImageSize.height)
//        let v = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: height), imageURLStringsGroup: nil)
//        v?.placeholderImage = R.image.noImage375x225()
//        v?.pageControlStyle = SDCycleScrollViewPageContolStyleClassic
//        v?.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
//        v?.autoScrollTimeInterval = 3.0
//        return v!
//    }()
//    
    
    //获取不同的页面需要传入的 参数值
    var newsParagram:(sport:Int?,taxonomyid:Int?)?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.cycleScrollView.delegate = self
        initView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- method
extension NewsListViewController {
    
    private func initView() {
        
        self.newsListHandler.delegate = self
        self.newsTopHandler.delegate = self
        
        self.firstRefreshing()
        self.initListener()
        tableView.snp.updateConstraints{ (make) in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)

        }
        
        tableView.register(UINib(nibName: NewsListCellType.ordinary.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewsListCellType.ordinary.cellIdentifier)
        tableView.register(UINib(nibName: NewsListCellType.manyFigure.cellIdentifier, bundle: nil), forCellReuseIdentifier: NewsListCellType.manyFigure.cellIdentifier)
        tableView.mj_header?.lastUpdatedTimeKey = "NewsListViewControllerLastUpdatedTimeKey"
    }
    /// notification 通知
    func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    /// 载入数据
    override func loadData(_ page: Int) {
      
        if newsParagram?.0 != nil {
            getNewsData(page, pageSize: kPageSize, sport: newsParagram?.0, taxonomyId: newsParagram?.1)
        }
        if newsParagram?.1 != nil {
            getNewsData(page, pageSize: kPageSize, sport: newsParagram?.0, taxonomyId: newsParagram?.1)
        }else {
            getNewsData(page, pageSize: kPageSize, sport: newsParagram?.0, taxonomyId: newsParagram?.1)
        }
        
    }
    
    private func getNewsData(_ page:Int, pageSize:Int, sport:Int?, taxonomyId:Int?) {
        newsListHandler.executeFetchNewsList(page: page, pageSize: pageSize, taxonomyId: taxonomyId, sport: sport)
        if pageInfo.isFirstPage() {
            self.newsTopHandler.executeFetchNewsTop()
        }
    }
}

// MARK:- tableview
extension NewsListViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let news = self.dataSource[indexPath.row] as! NewsModel
        //多图操作
        if (news.images?.count)!<3{
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCellType.ordinary.cellIdentifier, for: indexPath) as! NewsOrdinaryCell
            let news = self.dataSource[indexPath.row]
            cell.configCell(news: news as! NewsModel)
            return cell
        }
        //单图操作
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsListCellType.manyFigure.cellIdentifier, for: indexPath) as! NewsManyFigureCell
            let news = self.dataSource[indexPath.row]
            cell.configCell(news: news as! NewsModel)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = tableView.cellForRow(at: indexPath)?.tag {
            let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: id)
            navigationController?.pushViewController(ctrl, animated: true)
        }
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let news = self.dataSource[indexPath.row] as! NewsModel
        // 列表
        if (news.images?.count)!>=3{
            return 140
        }else{
            return 94
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.dataSource.count
    
    }

}

/// MARK:- NewsListHandlerDelegate
extension NewsListViewController: NewsListHandlerDelegate {
    
    func newsListHandler(_ handler: NewsListHandler, didFetchedList list: [NewsModel], andPageInfo pageInfo: TSPageInfoModel) {
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
    }
    
    func newsListHandler(_ handler: NewsListHandler, didError error: NSError) {
        TSToast.showNotificationWithMessage(error.localizedDescription)
        self.endRefreshing(isSuccess: false)
    }
}


// MARK:- NewsTopHandlerDelegate
extension NewsListViewController: NewsTopHandlerDelegate {
    func newsTopHandler(_ handler: NewsTopHandler, didFetchedList list: [NewsModel]) {
        self.hotList = list
//        cycleScrollView.titlesGroup = self.hotList.map{$0.title}//返回包含title的数组
//        cycleScrollView.imageURLStringsGroup = self.hotList.map{
//            return TSImageURLHelper(string: $0.img, size: hotImageSize).chop().urlString
//        }
        self.loadingLabel.isHidden = true
//        self.tableView.tableHeaderView = cycleScrollView
        self.tableView.reloadData()
        
    }
}

// MARK:- SDCycleScrollViewDelegate 焦点图代理
//extension NewsListViewController: SDCycleScrollViewDelegate {
//
//    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
//        if index < self.hotList.count {
//            let news = self.hotList[index]
//            pushToNewsDetailViewController(news.id)
//        }
//    }
//}

// MARK:- action
extension NewsListViewController {
    
//    @IBAction func search(_ sender: UIBarButtonItem) {
//        let ctrl = NewsSearchViewController()
//        ctrl.newsSearchType = NewsSearchType.None
//        ctrl.hidesBottomBarWhenPushed = true
//        ctrl.navigationItem.hidesBackButton = true
//        let nav = UINavigationController(rootViewController: ctrl)
//        self.present(nav, animated: true, completion: nil)
//    }
    
}

// MARK:- listener 事件
extension NewsListViewController {
    
    /// 从后台转入前台
    @objc func applicationWillEnterForeground() {
        let now = Foundation.Date().timeIntervalSince1970
        let last = self.tableView.mj_header?.lastUpdatedTime?.timeIntervalSince1970 ?? 0
        // 20分钟自动刷新
        if now - last > 1200 {
            self.tableView.mj_header?.beginRefreshing()
        }
    }
}
