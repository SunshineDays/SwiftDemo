//
//  Home3ViewController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/25.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class Home3ViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    
    private lazy var tableHeaderView: HomeTableHeaderView = {
        let view = R.nib.homeTableHeaderView.firstView(owner: nil)!
        view.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: HomeTableHeaderView.headerViewHeight)
        view.cycleScrollView.delegate = self
        view.delegate = self
        view.initData()
        return view
    }()
    
    private lazy var navigationView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.statusBarHeight + 44))
        view.backgroundColor = UIColor.navigationBarTintColor
        view.alpha = 0
        self.view.addSubview(view)
        let label = UILabel(frame: CGRect(x: 0, y: TSScreen.statusBarHeight, width: TSScreen.currentWidth, height: 44))
        label.text = "购彩大厅"
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 1))
        label.textAlignment = .center
        view.addSubview(label)
        return view
    }()
    
    private let homeHandler = HomeHandler()
    private let planOrderHandler = PlanOrderHandler()
    private let updateCheckHandler = UpdateCheckHandler()
    
    /// 计划单id
    private let planID = 1
    
    /// 轮播图and轮播消息
    private var homeMainModel: HomeMainModel! {
        didSet {
            tableHeaderView.configView(model: homeMainModel)
            if let lotterySale = homeMainModel.lotterySale {
                lotteryDataSource = lotterySale.home
            }
        }
    }
    
    /// 彩种数组
    private var lotteryDataSource = [HomeLotteryModel]() {
        didSet { tableHeaderView.configView(list: lotteryDataSource) }
    }
    
    /// 热门单关赛事
    private var hotSingleList = [JczqMatchModel]() {
        didSet { tableView.reloadData() }
    }
    
    /// 复制跟单
    private var copyOrderList = [CopyOrderModel]() {
        didSet { tableView.reloadData() }
    }
    
    /// 计划跟单
    private var planOrderList = [PlanOrderDetailModel]() {
        didSet { tableView.reloadData() }
    }
    
    /// 计划单详情
    private var planModel: PlanModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.show(animated: true)
        initView()
        updateCheck()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        refreshData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }
    
    /// 刷新数据
    @objc private func refreshData() {
        initNetwork()
    }
}

extension Home3ViewController {
    private func initView() {
        initTableView()
    }
    
    private func initTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.homeSingleHotCell)
        tableView.register(R.nib.homeTableViewThreeCell)
        tableView.register(R.nib.planOrderCopyTableCell)
        if #available(iOS 11.0, *) {
            tableViewTopConstraint.constant = -TSScreen.statusBarHeight
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        let view = UIView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: HomeTableHeaderView.headerViewHeight))
        view.addSubview(tableHeaderView)
        tableView.tableHeaderView = view
        tableView.tableFooterView = UIView()
    }
}

extension Home3ViewController {
    private func initNetwork() {
        // 头部信息
        homeHandler.getMainHome(success: { (model) in
            self.homeMainModel = model
            self.hud.hide(animated: true)
        }) { (error) in
            TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
            self.hud.hide(animated: true)
        }
        
        // 热门单关赛事
        homeHandler.getJcSingleMatchList(success: { (list) in
            self.hotSingleList = list
        }) { (error) in
            
        }
        
        // 今日热单
        homeHandler.getCopyHotOrderList(page: 1, pageSize: 5, success: { (list, pageInfo) in
            self.copyOrderList = list
        }) { (error) in
            TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        }
        
        // 计划单
        planOrderHandler.planOrderHomeData(success: { (detailModel, planModel) in
            self.planModel = planModel
            self.planOrderList.removeAll()
            if detailModel.title.isEmpty { return }
            self.planOrderList.append(detailModel)
        }) { (error) in
            TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        }
    }
    
    ///  检查更新
    private func updateCheck() {
        updateCheckHandler.updateCheck(success: { (model, build) in
            if model.build > build {
                let view = R.nib.updateCheckView.firstView(owner: nil)!
                view.initWith(model: model)
                UIApplication.shared.keyWindow?.addSubview(view)
            }
        }) { (error) in
            
        }
    }
    
    /// 彩种（本地数据）
//    private func initLotteryData() {
//        let data = readLocalData(fileName: "HomeJson", type: "json", directory: "Resource.bundle")
//        let json = JSON(data ?? Data())
//        lotteryDataSource = json.arrayValue.map {
//            return HomeLotteryModel(json: $0)
//        }
//    }
}



// MARK: - SDCycleScrollViewDelegate
extension Home3ViewController: SDCycleScrollViewDelegate {
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didScrollTo index: Int) {
        
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        /// banner 跳转
        if cycleScrollView == tableHeaderView.cycleScrollView {
             let  url = homeMainModel.scrollList[index].urlScheme
             TSEntryViewControllerHelper().openControllerFromUrl(schemeUrlString: url,urlString: homeMainModel.scrollList[index].url)
        }
    }
}

// MARK: - HomeTableHeaderViewDelegate
extension Home3ViewController: HomeTableHeaderViewDelegate {
    func homeTableHeaderView(_ view: HomeTableHeaderView, footballClickButton sneder: UIButton, index: Int) {
        pushViewController(with: index)
    }
    
    func homeTableHeaderView(_ view: HomeTableHeaderView, basketballClickButton sneder: UIButton, index: Int) {
        pushViewController(with: index)
    }
    
    func pushViewController(with index: Int) {
        if !lotteryDataSource[index].isSale {
            TSToast.showText(view: self.view, text: "暂停销售")
            return
        }
        let lottery = lotteryDataSource[index].lotteryId
        var playType = PlayType.hh
        switch index {
        case 2: playType = PlayType.fb_spf
        case 3: playType = PlayType.fb_bqc
        case 4: playType = PlayType.fb_bf
        case 5: playType = PlayType.fb_jqs
        default: playType = PlayType.hh
        }
        let jczqCtrl = TSEntryViewControllerHelper.lotteryViewController(lottery: lottery, playType: playType)
        jczqCtrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(jczqCtrl, animated: true)
    }
}

// MARK: - HomeSingleHotCellDelegate
extension Home3ViewController: HomeSingleHotCellDelegate {
    /// 立即投注
    func homeSingleHotCell(_ cell: HomeSingleHotCell, betModel: SLBuyModel<JczqMatchModel, JczqBetKeyType>, didClickBetButton button: UIButton) {
        let ctrl = R.storyboard.lotteryBuy.lotteryBuyViewController()!
        ctrl.buyModel = betModel
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
}

// MARK: - UITableViewDelegate, UITaleViewDataSoure
extension Home3ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: //热门单关
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeSingleHotCell, for: indexPath)!
            if let model = hotSingleList.first {
                cell.isHidden = false
                cell.delegate = self
                cell.configCell(match: model)
            } else {
                cell.isHidden = true
            }
            return cell
        case 1: //热门跟单
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeTableViewThreeCell, for: indexPath)!
            if let match = copyOrderList.first {
                cell.isHidden = false
                cell.configCell(copyOrderModel: match, isHideHotImage: false)
                cell.followOrderBlock = { sender in
                    self.startCopyOrderDetailViewController()
                }
                cell.avatarBlock = { sender in
                    let vc = R.storyboard.copyOrder.userCopyOrderDetailController()!
                    vc.initWith(userId: self.copyOrderList[indexPath.row].userId)
                    vc.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                cell.isHidden = true
            }
            return cell
        case 2: //热门计划单
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.planOrderCopyTableCell, for: indexPath)!
            if let plan = planOrderList.first {
                cell.isHidden = false
                cell.configView(planDetailModel: plan, planModel: planModel)
                cell.followBtnActionBlock = { sender in
                    self.startPlanOrderDetailViewController()
                }
            } else {
                cell.isHidden =  true
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return hotSingleList.isEmpty ? 0 : 215
        case 1:
            return copyOrderList.isEmpty ? 0 : 130
        case 2:
            if let model = planOrderList.first {
                var money = 0
                model.buyList.forEach { money += $0.buyMoney }
                return money > 0 ? 190 : 190 - 41
            } else {
                return 0
            }
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return hotSingleList.isEmpty ? 0 : 10
        case 1:
            return copyOrderList.isEmpty ? 0 : 10 - 3
        case 2:
            return planOrderList.isEmpty ? 0 : 10
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 1: //复制跟单
            startCopyOrderDetailViewController()
        case 2: //计划跟单
            startPlanOrderDetailViewController()
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        navigationView.alpha = y > 0 ? y / 100 : 0
    }
}

extension Home3ViewController {
    /// 复制跟单页面
    func startCopyOrderDetailViewController() {
        let ctrl = CopyOrderDetailViewController()
        ctrl.orderId = copyOrderList.first!.orderId
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    ///计划单页面
    func startPlanOrderDetailViewController() {
        let ctrl = TSEntryViewControllerHelper.planOrderDetailViewController(planDetailId: self.planOrderList.first!.id)
        ctrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ctrl, animated: true)
    }
}

/// 获取collectionView的本地数据
extension Home3ViewController {
    /**
     * 读取本地文件   转化为model
     * fileNameStr  文件名
     * type         文件类型
     **/
    private func readLocalData(fileName: String, type: String, directory: String) -> Any? {
        let jsonPath = Bundle.main.path(forResource: fileName, ofType: type, inDirectory: directory)
        let url = URL(fileURLWithPath: jsonPath!)
        do {
            let data = try Data(contentsOf: url)
            let dicrArr = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            return dicrArr
        } catch {
            return nil
        }
    }
}
