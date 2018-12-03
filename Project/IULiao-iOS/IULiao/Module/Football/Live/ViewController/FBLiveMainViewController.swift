//
//  Created by tianshui on 16/7/7.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import ActionSheetPicker_3_0
import SwiftyJSON
import DZNEmptyDataSet

class FBLiveMainViewController: BaseViewController {
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        liveTitleType = .jingcai
        initRightBarButtonItems()
        initView()
        initListener()
        tableView.mj_header?.beginRefreshing()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        selectTitleView.isHidden = true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Parameter
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    var liveGoalDialogCtrl = FBLiveGoalDialogViewController()
    
    var actionSheetPicker: ActionSheetCustomPicker!
    
    let liveMatchHandler = FBLiveMatchHandler()
    var liveMsgHandler: FBLiveMsgHandler?
    var liveSoundHandler = FBLiveSoundHandler()
    /// 关注/收藏
    private let recommendAttentionHandler = CommonAttentionHandler()
    /// 展开列表
    private let matchStatisticsHandler = FBMatchStatisticsHandler()

    var liveData = FBLiveDataModel2()
    var matchTimer: Timer!
    var dataSource = [FBLiveDataModel2.MatchGroup]()

    /// 展开列表数据模型
    private var statisticsModel: FBMatchStatisticsModel?
    
    /// title选择类型
    private var liveTitleType: Lottery = .jingcai {
        didSet {
            titlesButton.setTitle(liveTitleType.name + " ▼", for: .normal)
            liveData.lottery = liveTitleType
        }
    }
    
    var showIndex = 0
    
    /// title
    lazy var titlesButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: TSScreen.navigationBarHeight(self)))
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight(rawValue: 1))
        button.addTarget(self, action: #selector(titleButtonAction(_:)), for: .touchUpInside)
        navigationItem.titleView = button
        return button
    }()
    
    /// title选择View
    lazy var selectTitleView: FBLiveSelectFromTitleView = {
        let view = FBLiveSelectFromTitleView(frame: CGRect(x: 0, y: TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight, width: TSScreen.currentWidth, height: TSScreen.currentHeight - (TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight)))
        view.initWith(selectedType: liveTitleType) { [weak self](selectedType) in
            if self?.liveData.lottery != selectedType {
                self?.liveData.selectIssue = ""
            }
            self?.liveTitleType = selectedType
            self?.liveData.lottery = selectedType
            self?.tableView.mj_header.beginRefreshing()
        }
        view.isHidden = true
        UIApplication.shared.keyWindow?.addSubview(view)
        return view
    }()
    
}

// MARK: - Init
extension FBLiveMainViewController {
    private func initRightBarButtonItems() {
        let timeSelectItem = UIBarButtonItem(image: R.image.fbLive.filter(), style: .plain, target: self, action: #selector(selectAction(_sender:)))
        let selectItem = UIBarButtonItem(image: R.image.fbLive.issue(), style: .plain, target: self, action: #selector(changIssueAction(_sender:)))
        self.navigationItem.rightBarButtonItems = [timeSelectItem, selectItem]
    }
    
    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        liveMatchHandler.delegate = self
        matchTimer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(loopLiveState), userInfo: nil, repeats: true)
    }
    
    private func initView() {
        func initSegmentedControl() {
            segmentedControl.backgroundColor = UIColor(hex: 0xffffff)
            segmentedControl.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor: UIColor(hex: 0x333333),
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)
            ]
            segmentedControl.selectedTitleTextAttributes = [
                NSAttributedStringKey.foregroundColor: baseNavigationBarTintColor,
                NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
            ]
            segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
            segmentedControl.selectionIndicatorLocation = .down
            segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
            segmentedControl.selectionIndicatorHeight = 2
            segmentedControl.selectionStyle = .fullWidthStripe
            segmentedControl.sectionTitles = FBLiveTabType.allTabs.map { $0.rawValue }
            segmentedControl.indexChangeBlock = {
                [unowned self] index in
                self.liveData.liveTabType = FBLiveTabType.allTabs[Int(index)]
                self.dataSource = self.liveData.matchGroupByDate()
//                self.tableView.reloadData()
                if self.liveData.liveTabType == .attention {
                    self.liveMatchHandler.getAttentionList()
                }
                else {
                    self.liveMatchHandler.getMatchList(issue: self.liveData.selectIssue, lottery: self.liveData.lottery)
                }
                if self.liveData.liveTabType == .attention {
                    self.navigationItem.rightBarButtonItem = nil
                    self.navigationItem.rightBarButtonItem = nil
                }
                else {
                    self.initRightBarButtonItems()
                }
            }
        }
        
        func initTableView() {
            let header = MJRefreshNormalHeader {
                [weak self] in
                if self?.liveData.liveTabType == .attention {
                    self?.liveMatchHandler.getAttentionList()
                }
                else {
                    self?.liveMatchHandler.getMatchList(issue: self?.liveData.selectIssue, lottery: self?.liveData.lottery)
                }
            }
            header?.lastUpdatedTimeKey = "FBLiveMatchListViewController"
            tableView.mj_header = header
            tableView.register(R.nib.fbLiveMatchTableCell2)
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
        }
        
        func initActionSheetPicker() {
            actionSheetPicker = ActionSheetCustomPicker(title: "选择期号", delegate: self, showCancelButton: true, origin: view)
            actionSheetPicker.toolbarButtonsColor = baseNavigationBarTintColor
        }
        
        func initLiveGoalDialogCtrl() {
            addChildViewController(liveGoalDialogCtrl)
            liveGoalDialogCtrl.view.isHidden = true
            view.addSubview(liveGoalDialogCtrl.view)
            liveGoalDialogCtrl.view.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.view).offset(-(TSScreen.tabBarHeight(self) + 30))
                make.left.equalTo(self.view).offset(30)
                make.right.equalTo(self.view).offset(-30)
                make.height.equalTo(44)
            }
        }
        initSegmentedControl()
        initTableView()
        initActionSheetPicker()
        initLiveGoalDialogCtrl()
        titlesButton.addTarget(self, action: #selector(titleButtonAction(_:)), for: .touchUpInside)
    }
}

// MARK: - Request
extension FBLiveMainViewController {
    /// 获取展开的数据信息
    private func getMatchStatisticsData(lottery: Lottery, indexPath: IndexPath) {
        let match = dataSource[indexPath.section].matchList[indexPath.row]
        matchStatisticsHandler.getStatistics(matchId: match.mid, lottery: lottery, success: { [weak self] (matchModel, matchStatisticsModel) in
            self?.statisticsModel = matchStatisticsModel
            
            // 展开一个，关闭一个
            var lastIndexPath = IndexPath()
                        for (i, data) in (self?.dataSource.enumerated())! {
                for (j, matc) in data.matchList.enumerated() {
                    if matc.isExpandStatisticsView {
                        lastIndexPath = IndexPath(row: j, section: i)
                        self?.dataSource[i].matchList[j].isExpandStatisticsView = false
                        break
                    }
                }
            }
            for (i, all) in (self?.liveData.allMatchList.enumerated())! {
                if all.isExpandStatisticsView {
                    self?.liveData.allMatchList[i].isExpandStatisticsView = false
                }
            }
            
            let isExpandStatisticsView = !match.isExpandStatisticsView
            if let index = self?.liveData.allMatchList.index(where: { $0.mid == match.mid }) {
                self?.liveData.allMatchList[index].isExpandStatisticsView = isExpandStatisticsView
            }
            self?.dataSource[indexPath.section].matchList[indexPath.row].isExpandStatisticsView = isExpandStatisticsView
            if lastIndexPath.count != 0 {
                self?.tableView.reloadRows(at: [lastIndexPath, indexPath], with: .fade)
            } else {
                self?.tableView.reloadRows(at: [indexPath], with: .fade)
            }
        }) { (error) in
            
        }
    }
    
    /// 关注
    private func postAttention(sender: UIButton, mid: Int, indexPath: IndexPath) {
        let match = dataSource[indexPath.section].matchList[indexPath.row]
        if sender.isSelected { //取消关注
            
            sender.isSelected = !sender.isSelected
            dataSource[indexPath.section].matchList[indexPath.row].isAttention = false
            liveData.allMatchList[indexPath.row].isAttention = false
            if liveData.liveTabType == .attention {
                dataSource[indexPath.section].matchList.remove(at: indexPath.row)
                if dataSource[indexPath.section].matchList.count == 0 { //如果这一组中没有数据了，将这一组移除
                    dataSource.remove(at: indexPath.section)
                }
                else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                tableView.reloadData()
            }
            if let index = liveData.allMatchList.index(where: { $0.mid == match.mid }) {
                liveData.allMatchList[index].isAttention = false
            }
            
            recommendAttentionHandler.sendUnAttention(module: .live, resourceId: mid, success: { (json) in
                sender.isUserInteractionEnabled = true
            }) { (error) in
                sender.isUserInteractionEnabled = true
            }
        } else { //关注
            sender.isSelected = !sender.isSelected
            dataSource[indexPath.section].matchList[indexPath.row].isAttention = true
            if let index = liveData.allMatchList.index(where: { $0.mid == match.mid }) {
                liveData.allMatchList[index].isAttention = true
            }
            sender.isUserInteractionEnabled = true
            
            recommendAttentionHandler.sendAttention(module: .live, resourceId: mid, success: { (json) in
                sender.isUserInteractionEnabled = true
            }) { (error) in
                sender.isUserInteractionEnabled = true
            }
        }
    }
}

// MARK:- UITableViewDataSource， UITableViewDelegate
extension FBLiveMainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].matchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbLiveMatchTableCell2, for: indexPath)!
        let match = dataSource[indexPath.section].matchList[indexPath.row]
        cell.configCell(match: match, isFirstRow: indexPath.row == 0, statistics: statisticsModel)
        cell.moreButtonClickBlock = { sender in //展开
            self.moreButtonAction(match: match, indexPath: indexPath)
        }
        cell.attentionButtonClickBlock = {sender in //关注
            self.postAttention(sender: sender, mid: match.mid, indexPath: indexPath)
        }
        cell.liveAnimationButtonClickBlock = { sender in //动画直播
            let ctrl = TSEntryViewControllerHelper.fbLiveAnimationViewController(matchId: match.mid)
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        cell.liaoImageViewClickBlock = {
            let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: self.liveData.lottery, selectedTab: .news)
            ctrl.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
        cell.recommendImageViewClickBlock = {
            let vc = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: self.liveData.lottery, selectedTab: .recommend)
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource.count > 0 {
            let match = dataSource[indexPath.section].matchList[indexPath.row]
            let state = match.stateType
            
            let statisticsViewHeight: CGFloat = match.isExpandStatisticsView ? 100 : 0
            let lineHeight: CGFloat = indexPath.row == 0 ? 0 : 5
            var otherInfoHeight: CGFloat = 0
            if UserToken.shared.isLiveShowInfo {
                if state == .uptHalf {
                    // 上半场 有角球
                    if match.homeCorner > 0 || match.awayCorner > 0 {
                        otherInfoHeight = 20
                    }
                } else if state == .over || state == .downHalf || state == .halfTime {
                    otherInfoHeight = 20
                }
            }
            return 50 + otherInfoHeight + statisticsViewHeight + lineHeight
        }
        else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(hex: 0xededed)
        let label = UILabel()
        label.text = dataSource[section].indexTitle
        label.textColor = TSColor.gray.gamut666666
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let match = dataSource[indexPath.section].matchList[indexPath.row]
        var tab: FBMatchMainViewController.MatchType
        tab = .odds(.europe)
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: liveData.lottery, selectedTab: tab)
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)  
    }
    
}

// MARK: - DZNEmptyDataSetSource
extension FBLiveMainViewController: DZNEmptyDataSetSource {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return R.image.fbLive.matchNoMore()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var attributes = [NSAttributedStringKey: Any]()
        attributes[.font] = UIFont.systemFont(ofSize: 14)
        let title = liveData.liveTabType == .attention ? "暂无关注内容" : "暂无内容，请在右上角切换日期"
        return NSAttributedString(string: title, attributes: attributes)
    }
    
}

// MARK:- FBLiveMatchListHandlerDelegate(网络请求)
extension FBLiveMainViewController: FBLiveMatchHandlerDelegate {

    func liveMatchHandler(_ handler: FBLiveMatchHandler, didFetchedData data: FBLiveDataModel2) {
        tableView.emptyDataSetSource = self
        var data = data
        data.lottery = liveData.lottery
        data.liveTabType = liveData.liveTabType
        liveData = data
        liveData.isAttention = liveData.liveTabType == .attention
        dataSource = liveData.matchGroupByDate()
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
        
        liveMsgHandler = FBLiveMsgHandler(liveNum: data.liveNum)
        liveMsgHandler?.start(liveMsgUpdate)
        
//        showassss()
        
    }

    func liveMatchHandler(_ handler: FBLiveMatchHandler, didError error: NSError) {
        dataSource.removeAll()
        tableView.reloadData()
        tableView.emptyDataSetSource = self
        tableView.mj_header?.endRefreshing()
        TSToast.showNotificationWithMessage(error.localizedDescription)
    }
    
    func liveMsgUpdate(_ msgMatchList: [FBLiveMatchModel2], isNeedRefresh: Bool) {
        
//        guard !isNeedRefresh else {
//            tableView.mj_header?.beginRefreshing()
//            return
//        }
        
        // 是否需要reload整个tableView (未开赛变为开赛需要)
        var needReloadAll = false
        var indexPaths = [IndexPath]()
        var scoredMatchs = [FBLiveMatchModel2]()
        
        for msg in msgMatchList {
            var msg = msg
            
            if let index = liveData.allMatchList.index(where: { $0.id == msg.id}) {
                
                var match = liveData.allMatchList[index]
                if match.isNeedExchangeMsg {
                    swap(&msg.homeScore, &msg.awayScore)
                    swap(&msg.homeRed, &msg.awayRed)
                    swap(&msg.homeYellow, &msg.awayYellow)
                    swap(&msg.homeCorner, &msg.awayCorner)
                }
                if match.homeScore == msg.homeScore && match.awayScore == msg.awayScore
                   && match.homeRed == msg.homeRed && match.awayRed == msg.awayRed
                    && match.homeYellow == msg.homeYellow && match.awayYellow == msg.awayYellow
                    && match.homeCorner == msg.homeCorner && match.awayCorner == msg.awayCorner
                   && match.beginTime == msg.beginTime && match.stateType == msg.stateType {
                    continue
                }
                
                if match.stateType == .notStarted && msg.stateType == .uptHalf {
                    // 未开赛变为开赛
                    needReloadAll = true
                }
                // 半场
                if msg.stateType == .halfTime {
                    match.homeHalfScore = match.homeScore
                    match.awayHalfScore = match.awayScore
                }
                
                if let homeScore = msg.homeScore {
                    // 注意: 这里用的是旧的主队比分赋值
                    match.lastHomeScore = match.homeScore
                    match.homeScore = homeScore
                }
                if let awaySocre = msg.awayScore {
                    match.lastAwayScore = match.awayScore
                    match.awayScore = awaySocre
                }
                
                match.beginTime = msg.beginTime ?? match.beginTime
                match.homeRed = msg.homeRed
                match.awayRed = msg.awayRed
                match.homeYellow = msg.homeYellow
                match.awayYellow = msg.awayYellow
                match.homeCorner = msg.homeCorner
                match.awayCorner = msg.awayCorner
                match.stateType = msg.stateType
                
                liveData.allMatchList[index] = match
                
                for (section, group) in dataSource.enumerated() {
                    if let row = group.matchList.index(where: { $0.id == match.id }) {
                        indexPaths.append(IndexPath(row: row, section: section))
                        dataSource[section].matchList[row] = match
                    }
                }
                liveData.allMatchList[index] = match
                
                // 比分变化 上下半场
                if (match.lastHomeScore != match.homeScore || match.lastAwayScore != match.awayScore)
                    && (match.stateType == .uptHalf || match.stateType == .downHalf) {
                    scoredMatchs.append(match)
                }
            }
        }
        
        if !indexPaths.isEmpty {
            // n秒后重新查询这些更新的赛事 并更新cell
            tableView.reloadRows(at: indexPaths, with: .none)
            dispatch_after_time(60_000, block: {
                [weak self] in
                guard let me = self else { return }
                
                let paths = scoredMatchs.compactMap({
                    match -> IndexPath? in
                    var match = match
                    
                    match.lastHomeScore = match.homeScore
                    match.lastAwayScore = match.awayScore
                    if let index = me.liveData.allMatchList.index(where: { $0.id == match.id }) {
                        me.liveData.allMatchList[index] = match
                    }
                    
                    for (section, group) in me.dataSource.enumerated() {
                        if let row = group.matchList.index(where: { $0.id == match.id }) {
                            me.dataSource[section].matchList[row] = match
                            return IndexPath(row: row, section: section)
                        }
                    }
                    return nil
                })
                me.tableView.reloadRows(at: paths, with: .none)
            })
        }

        if !scoredMatchs.isEmpty {
            
            // 弹窗
            liveGoalDialogCtrl.showGoalDialogView(scoredMatchs, autoCloseTimeInterval: 10)
            print("进球", scoredMatchs)
            // 播放声音
            if UserToken.shared.isLivePlaySound {
                liveSoundHandler.playSound()
            }
            // 震动
            if UserToken.shared.isLivePlayVibrate {
                liveSoundHandler.playVibrate()
            }
        }
 
        if needReloadAll {
            dataSource = liveData.matchGroupByDate()
            tableView.reloadData()
        }
    }
    

    
}

// MARK: - FBLiveFilterLeagueViewControllerDelegate(筛选)
extension FBLiveMainViewController: FBLiveFilterLeagueViewControllerDelegate {
    func liveFilterLeagueViewController(dataDidChange data: FBLiveDataModel2) {
        var data = data
        if data.lottery != liveData.lottery {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: false)
        }
        data.liveTabType = liveData.liveTabType
        liveData = data
        
        dataSource = liveData.matchGroupByDate()
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
        liveMsgHandler = FBLiveMsgHandler(liveNum: data.liveNum)
        liveMsgHandler?.start(liveMsgUpdate)
    }
}

// MARK: - ActionSheetCustomPickerDelegate(选择时间)
extension FBLiveMainViewController: ActionSheetCustomPickerDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return liveData.issueList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let issue = liveData.issueList[row]
        return issue == liveData.currentIssue ? "\(issue) 当前期" : issue
    }
    
    func actionSheetPicker(_ actionSheetPicker: AbstractActionSheetPicker!, configurePickerView pickerView: UIPickerView!) {
        if let row = liveData.issueList.index(of: liveData.selectIssue) {
            pickerView.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    func actionSheetPickerDidSucceed(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
        tableView.mj_header?.beginRefreshing()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let issue = liveData.issueList[row]
        liveData.selectIssue = issue
    }
}


// MARK: - Action
extension FBLiveMainViewController {
    /// 展开
    private func moreButtonAction(match: FBLiveMatchModel2, indexPath: IndexPath) {
        if match.isExpandStatisticsView { //将要关闭
            let isExpandStatisticsView = !match.isExpandStatisticsView
            if let index = liveData.allMatchList.index(where: { $0.mid == match.mid }) {
                liveData.allMatchList[index].isExpandStatisticsView = isExpandStatisticsView
            }
            dataSource[indexPath.section].matchList[indexPath.row].isExpandStatisticsView = isExpandStatisticsView
            tableView.reloadRows(at: [indexPath], with: .fade)
        } else { //将要展开
            getMatchStatisticsData(lottery: liveData.lottery, indexPath: indexPath)
        }
    }
    
    /// 改变日期
    @objc private func changIssueAction(_sender: UIBarButtonItem) {
        selectTitleView.isHidden = true
        actionSheetPicker.show()
    }
    
    /// 条件筛选
    @objc private func selectAction(_sender: UIBarButtonItem) {
        let vc = R.storyboard.fbLive2.fbLiveFilterLeagueViewController()!
        vc.initWith(liveData: liveData)
        vc.hidesBottomBarWhenPushed = true
        vc.delegate = self
        navigationController?.show(vc, sender: nil)
    }
    
    /// title点击事件
    @objc private func titleButtonAction(_ sender: UIButton) {
        selectTitleView.isHidden = !selectTitleView.isHidden
    }
    
    /// 从后台转入前台
    @objc func applicationWillEnterForeground() {
        tableView.mj_header?.beginRefreshing()
    }
    
    @objc func loopLiveState() {
        var indexPaths = [IndexPath]()
        
        for (section, matchGroup) in dataSource.enumerated() {
            for (row, match) in matchGroup.matchList.enumerated() {
                if match.stateType == .uptHalf || match.stateType == .downHalf {
                    indexPaths.append(IndexPath(row: row, section: section))
                }
            }
            tableView.reloadRows(at: indexPaths, with: .none)
        }
    }
}


