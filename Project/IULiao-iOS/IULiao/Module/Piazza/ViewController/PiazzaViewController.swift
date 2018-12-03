//
//  PiazzaViewCtrl.swift
//  IULiao
//
//  Created by levine on 2017/7/25.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh
//private var kNavbarHeight :CGFloat = 64.0
private let kiPhoneXNavbarHeight :CGFloat = 88.0
private let kTopViewHeight :CGFloat = 85.0
private let kMarginHeight :CGFloat = 6.0
private let kTabbarHeight :CGFloat = 49.0
private let kPage : Int = 1
private let kPageSize : Int = 20
private let kTabbarHeaderMargin:CGFloat = 38.0
enum PiazzaListCellType:Int {
    case liveMatch,singlePic,manyPic
    var cellIdentifier:String {
        switch self {
        case .liveMatch:
            return "PiazzaLiveMatchCell"
        case .singlePic:
            return "PiazzaNewsSinglePicCell"
        case .manyPic:
            return "PiazzaNewsManyPicCell"
        }
    }
}
class PiazzaViewController: BaseViewController {

    
    @IBOutlet weak var rightDebugItem: UIBarButtonItem!
    //MARK: 定义所需变量
    private var newsHandler = PiazzaNewsHandle()
    private var hotLiveMatchHandler = PiazzaLiveMactHandle()
    private var liveMsgHandler: FBLiveMsgHandler?
    private var liveMatchModel: FBLiveMatchModel?
    private var matchTimer = Timer()
    /// 分页信息
    var pageInfo = TSPageInfoModel(page: 1)
    /// 数据源
    var liveData = FBLiveDataModel()
    var newsDataSource = [NewsModel]()//新闻数据源
    var liveMatchSource = [FBLiveMatchModel]()//热门比赛
    override func viewDidLoad() {
        super.viewDidLoad()
#if DEBUG
    rightDebugItem.isEnabled = true
#else
    rightDebugItem.isEnabled = false
    rightDebugItem.title = ""
#endif
        initView()
        initListener()//监听
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)//移除所有的监听
    }
    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    //MARK: 所有的懒加载
    
    private lazy var topView : PiazzaTopView = {

        let topView = Bundle.main.loadNibNamed("PiazzaTopView", owner: nil, options: nil)?.last as! PiazzaTopView
        topView.frame = CGRect(x: 0, y: TSScreen.navigationHeight, width: TSScreen.currentWidth, height: kTopViewHeight)
        return topView
    }()
    private lazy var tableView :UITableView = {
//        if TSScreen.iPhoneXHeight == TSScreen.currentHeight {
//            kNavbarHeight = 88
//        }else {
//            kNavbarHeight = 64
//        }
        let tableView = UITableView(frame: CGRect(x: 0, y: TSScreen.navigationHeight + kTopViewHeight + kMarginHeight, width: TSScreen.currentWidth, height: TSScreen.currentHeight - (TSScreen.navigationHeight + kTopViewHeight + kMarginHeight + kTabbarHeight)), style: .grouped)
        tableView.register(UINib(nibName: PiazzaListCellType.liveMatch.cellIdentifier, bundle: nil), forCellReuseIdentifier: PiazzaListCellType.liveMatch.cellIdentifier)
        tableView.register(UINib(nibName: PiazzaListCellType.singlePic.cellIdentifier, bundle: nil), forCellReuseIdentifier: PiazzaListCellType.singlePic.cellIdentifier)
        tableView.register(UINib(nibName: PiazzaListCellType.manyPic.cellIdentifier, bundle: nil), forCellReuseIdentifier: PiazzaListCellType.manyPic.cellIdentifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: 1))
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private lazy var piazzaTabHeadeview : PiazzaTabHeaderView = PiazzaTabHeaderView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: 0))

}

//MARK:  UI操作扩充类
extension PiazzaViewController {
    private func initView() {
        newsHandler.delegate = self
        hotLiveMatchHandler.delegate = self
//        if TSScreen.iPhoneXHeight == TSScreen.currentHeight {
//            kNavbarHeight = 88
//        }else {
//            kNavbarHeight = 64
//        }
        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(topView)
        view.addSubview(tableView)
       
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(PiazzaViewController.headerRefresh))
//        tableView.mj_footer = RefreshHelper.tableFooterRefersh(target: self, action: #selector(PiazzaViewCtrl.footerRefresh))
        tableView.mj_header.beginRefreshing()
        
        let mjFooter = MJRefreshAutoNormalFooter()
        mjFooter.setRefreshingTarget(self, refreshingAction: #selector(PiazzaViewController.footerRefresh))
//        mjFooter.isAutomaticallyHidden = true
        mjFooter.setTitle("正在玩命加载中", for: MJRefreshState.refreshing)
        mjFooter.setTitle("", for: MJRefreshState.idle)
        mjFooter.setTitle("暂无更多评论", for: MJRefreshState.noMoreData)
        mjFooter.stateLabel.textColor = UIColor(r: 170, g: 170, b: 170)
        mjFooter.triggerAutomaticallyRefreshPercent = 0.2
        tableView.mj_footer  = mjFooter
    }
    
}
//MARK:  操作方法方法
extension PiazzaViewController {
    //刷新方法
    @objc private func headerRefresh() {
        getNewRecommend(pageInfo.resetPage(), pageSize:kPageSize)
        getHotLiveMatch()
        
    }
    @objc private func footerRefresh() {
        getNewRecommend(pageInfo.nextPage(), pageSize: kPageSize)
        
    }
    private func caculateHeight(labelStr:String,font:UIFont,width:CGFloat)->CGFloat {
        let contentStr = labelStr as NSString
        let size = CGSize(width: width, height: 900)
        let strSize = contentStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil).size
        return strSize.height
    }
}
//MARK: 网络请求
extension PiazzaViewController {
    //新闻列表
    private func getNewRecommend(_ page:Int,pageSize:Int) {
        
        newsHandler.executeFetchNewsList(isrecommend: nil, page: pageInfo.page, pageSize: pageInfo.pageSize)
    }
    //最新球赛
    private func getHotLiveMatch() {
        hotLiveMatchHandler.executeFetchMatchList()
    }
}
//MARK: 回传代理
extension PiazzaViewController:PiazzaNewsHandleDelegate,PiazzaLiveMactHandleDelegate {
   
    //新闻列表回传
    func newListHandler(_ handler: PiazzaNewsHandle, didFerchedList list: [NewsModel], andPageInfo pageInfo: TSPageInfoModel) {
         tableView.mj_header.endRefreshing()
         tableView.mj_footer.endRefreshing()
        if self.pageInfo.isFirstPage() {
            self.newsDataSource = list
            self.pageInfo = pageInfo
            tableView.mj_footer.resetNoMoreData()
        }else {
            if pageInfo.hasMorePage() {
                var lists = list
                let min = max(self.newsDataSource.count - self.pageInfo.pageSize, 0)
                for i in min..<self.newsDataSource.count {
                    let news = self.newsDataSource[i]
                    if lists.contains(where: {$0.id == news.id}) {
                        if let index = lists.index(where: {$0.id == news.id}) {
                            lists.remove(at: index)
                        }
                        
                    }
                }
                self.newsDataSource += lists
                tableView.mj_footer.endRefreshing()
            }else {
                tableView.mj_footer.endRefreshingWithNoMoreData()
            }
        
        }
       tableView.reloadData()
        
        
    }
    func newListHandler(_ handler: PiazzaNewsHandle, didError error: NSError) {
        TSToast.showNotificationWithTitle(error.localizedDescription)
    }
    //热门球赛回传
    func liveMatchListHandler(_ handler: PiazzaLiveMactHandle, didFetchDataList listData: FBLiveDataModel, hotDataList hotData: FBLiveMatchModel?, animationUrl url: String?, andBirefList birefList: [PiazzaBirefModel]?, hotLiveMatchType: PiazzaHotMarchType) {
         liveData = listData
         liveMatchSource = listData.allMatchList
         liveMsgHandler = FBLiveMsgHandler(liveNum: liveData.liveNum)
         liveMsgHandler?.start(liveMsgUpdate)
         self.liveMatchModel = hotData
         //liveMsgHandler?.start(liveMsgUpdate(_:isNeedRefresh:))
        if hotLiveMatchType == PiazzaHotMarchType.animation && url != nil {
             piazzaTabHeadeview.piazzaParagram = (PiazzaHotMarchType.animation,hotData,nil,url)
             piazzaTabHeadeview.frame.size.height = TSScreen.currentWidth*9/16
            tableView.tableHeaderView = piazzaTabHeadeview

        }else if hotLiveMatchType == PiazzaHotMarchType.brief {
            let height = caculateHeight(labelStr: (birefList?.first?.content)!, font: UIFont.systemFont(ofSize: 12), width: (TSScreen.currentWidth - kTabbarHeaderMargin))
            piazzaTabHeadeview.frame.size.height = height + kTopViewHeight
            tableView.tableHeaderView = piazzaTabHeadeview
            piazzaTabHeadeview.piazzaParagram = (PiazzaHotMarchType.brief,hotData,birefList?.first,nil)
        }else {
            piazzaTabHeadeview.piazzaParagram = (PiazzaHotMarchType.noMatch,hotData,nil,nil)

            piazzaTabHeadeview.frame.size.height = 0.1
            tableView.tableHeaderView = piazzaTabHeadeview

            
        }
        tableView.reloadData()
    }
   
    func liveMatchListHandler(_ handler: PiazzaLiveMactHandle, didError error: NSError) {
        TSToast.showNotificationWithTitle(error.localizedDescription)
    }
    
    func liveMsgUpdate(_ msgMatchList: [FBLiveMatchModel2], isNeedRefresh: Bool) {
        guard !isNeedRefresh else {
            tableView.mj_header?.beginRefreshing()
            return
        }
        
        var indexPaths = [IndexPath]()
        var scoredMatchs = [FBLiveMatchModel]()
        for msgMatch in msgMatchList {
            var msgMatch = msgMatch
            if let index = liveData.allMatchList.index(where: {$0.id == msgMatch.id}) {
                var match = liveData.allMatchList[index]
                if match.isNeedExchangeMsg {
                    swap(&msgMatch.homeScore, &msgMatch.awayScore)
                    swap(&msgMatch.homeRed, &msgMatch.awayRed)
                }
                if match.homeScore == msgMatch.homeScore && match.awayScore == msgMatch.awayScore
                    && match.homeRed == msgMatch.homeRed && match.awayRed == msgMatch.awayRed
                    && match.beginTime == msgMatch.beginTime && match.stateType == msgMatch.stateType {
                    continue
                }
                if let homeScore = msgMatch.homeScore {
                    // 注意: 这里用的是旧的主队比分赋值
                    match.lastHomeScore = match.homeScore
                    match.homeScore = homeScore
                }
                if let awaySocre = msgMatch.awayScore {
                    match.lastAwayScore = match.awayScore
                    match.awayScore = awaySocre
                }
                
                match.beginTime = msgMatch.beginTime ?? match.beginTime
                match.homeRed = msgMatch.homeRed
                match.awayRed = msgMatch.awayRed
                match.stateType = msgMatch.stateType
                liveData.allMatchList[index] = match
                
                if let row = liveMatchSource.index(where: { $0.id == match.id }) {
                    indexPaths.append(IndexPath(row: row, section: 0))
                    liveMatchSource[row] = match
                }
                
                // 比分变化 上下半场
                if (match.lastHomeScore != match.homeScore || match.lastAwayScore != match.awayScore)
                    && (match.stateType == .uptHalf || match.stateType == .downHalf) {
                    scoredMatchs.append(match)
                }

            }
        }
        tableView.reloadRows(at: indexPaths, with: .none)
    }
}
extension PiazzaViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == PiazzaListCellType.liveMatch.rawValue{
            return  liveMatchSource.count
        }else {
            return newsDataSource.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == PiazzaListCellType.liveMatch.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: PiazzaListCellType.liveMatch.cellIdentifier, for: indexPath) as! PiazzaLiveMatchCell
            cell.configerContent(liveMatchSource[indexPath.row])
            return cell
        }else {
            let newModel = newsDataSource[indexPath.row];
            if (newModel.images?.count)! < 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: PiazzaListCellType.singlePic.cellIdentifier, for: indexPath) as! PiazzaNewsSinglePicCell
                cell.configCelContent(newModel)
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: PiazzaListCellType.manyPic.cellIdentifier, for: indexPath) as! PiazzaNewsManyPicCell
                cell.configCelContent(newModel)
                return cell
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == PiazzaListCellType.liveMatch.rawValue {
            return 40
        }
        else {
            let newModel = newsDataSource[indexPath.row];
            if (newModel.images?.count)! < 3 {
                return 160
            }else if (newModel.images?.count)! >= 3{
                return 120
            }else {
                return 0
            }
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if PiazzaListCellType.liveMatch.rawValue == section{
            if liveMatchModel != nil {
                return 10
            }else {
                return 0
            }
            
        }else {
            return 6
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    } 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == PiazzaListCellType.liveMatch.rawValue {
            guard indexPath.row < liveMatchSource.count else {
                return
            }
            let match = liveMatchSource[indexPath.row]
            
            //比赛结束，选择资讯页面，比赛进行中选择详情页
            let tab: FBMatchMainViewController.MatchType
            if match.stateType == .notStarted {
                tab = .news
            } else if match.stateType == .over {
                tab = .war(.recent)
            } else {
                tab = .analyze(.event)
            }
            let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: .jingcai, selectedTab: tab)
            ctrl.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(ctrl, animated: true)
        }else {
            if let newId = tableView.cellForRow(at: indexPath)?.tag {
                let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: newId)
                ctrl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension PiazzaViewController {

    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        matchTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(loopLiveState), userInfo: nil, repeats: true)
    }
    @objc private func loopLiveState() {
        var indexPaths = [IndexPath]()
        for(row, match) in liveMatchSource.enumerated() {
            if match.stateType == .uptHalf || match.stateType == .downHalf {
                indexPaths.append(IndexPath(row: row, section: 0))
            }
        }
        tableView.reloadRows(at: indexPaths, with: .none)
    }
    /// 从后台转入前台
    @objc func applicationWillEnterForeground() {
        let now = Foundation.Date().timeIntervalSince1970
        let last = tableView.mj_header?.lastUpdatedTime?.timeIntervalSince1970 ?? 0
        // 20分钟自动刷新
        if now - last > 1200 {
            tableView.mj_header?.beginRefreshing()
        }
    }

}
