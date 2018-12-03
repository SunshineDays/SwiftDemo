//
//  FBOddsMatchListViewController.swift
//  IULiao
//
//  Created by tianshui on 16/7/7.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh
import ActionSheetPicker_3_0

class FBOddsMatchListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var actionSheetPicker: ActionSheetCustomPicker!
    var popoverContentCtrl: TSPopoverContentViewController!
    var popoverBoxCtrl: WYPopoverController!
    
    let oddsMatchListHandler = FBOddsMatchListHandler()

    var oddsData = FBOddsDataModel()
    var matchList = [FBOddsMatchModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initListener()
        tableView.mj_header?.beginRefreshing()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        tableView.reloadData()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FBOddsFilterLeagueSegue" {
            let destinationCtrl = segue.destination as! FBOddsFilterLeagueViewController
            destinationCtrl.oddsData = oddsData
            destinationCtrl.hidesBottomBarWhenPushed = true
            destinationCtrl.delegate = self
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- method
extension FBOddsMatchListViewController {
    
    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        oddsMatchListHandler.delegate = self
    }
    
    private func initView() {
        
        func initTableView() {
            let header = MJRefreshNormalHeader {
                [weak self] in
                self?.oddsMatchListHandler.executeFetchMatchList(self?.oddsData.selectIssue, lottery: self?.oddsData.lottery)
            }
            header?.lastUpdatedTimeKey = "FBOddsMatchListViewController"
            tableView.mj_header = header
            
            tableView.tableFooterView = UIView()
            
            tableView.register(UINib(nibName: FBOddsMatchHeaderView.reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: FBOddsMatchHeaderView.reuseIdentifier)
        }
        
        func initActionSheetPicker() {
            actionSheetPicker = ActionSheetCustomPicker(title: "选择期号", delegate: self, showCancelButton: true, origin: view)
            actionSheetPicker.toolbarButtonsColor = baseNavigationBarTintColor
        }
        
        func initPopoverContentCtrl() {
            popoverContentCtrl = TSPopoverContentViewController()
            popoverContentCtrl.dataSource = ["期号选择", "赔率公司"]
            popoverContentCtrl.onPopoverItemClick = {
                [weak self] index in
                guard let me = self else { return }
                me.popoverBoxCtrl.dismissPopover(animated: true)
                if index == 0 {
                    me.actionSheetPicker.show()
                } else if index == 1 {
                    let ctrl = FBOddsCompanyViewController.instanceOddsCompanyViewController()
                    ctrl.selectCompanys = me.oddsData.companys
                    ctrl.oddsType = me.oddsData.oddsType
                    ctrl.delegate = me
                    me.navigationController?.pushViewController(ctrl, animated: true)
                }
            }
        }
        
        func initPopoverBoxCtrl() {
            popoverBoxCtrl = WYPopoverController(contentViewController: popoverContentCtrl)
            popoverBoxCtrl.theme = WYPopoverThemeDark()
        }
        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        initTableView()
        initActionSheetPicker()
        initPopoverContentCtrl()
        initPopoverBoxCtrl()
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
    
    /// 赛事详情
    @objc func showMatchDetail(_ sender: UIGestureRecognizer) {
        let header = sender.view as? FBOddsMatchHeaderView
        guard let match = header?.match else { return }
        let tab = oddsData.oddsType == .asia ? FBMatchMainViewController.MatchType.odds(.asia) : .odds(.europe)
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: match.id, lottery: oddsData.lottery, selectedTab: tab)
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    /// 赔率历史
    @objc func showOddsHistory(_ sender: UIGestureRecognizer) {
        guard let dict = sender.view?.extraProperty else { return }
        guard let mid = dict["mid"] as? Int else { return }
        guard let cid = dict["cid"] as? Int else { return }
        let ctrl: UIViewController
        if oddsData.oddsType == .asia {
            ctrl = TSEntryViewControllerHelper.fbMatchOddsAsiaCompanyViewController(matchId: mid, companyId: cid, lottery: oddsData.lottery, selectedTab: .history)
        } else {
            ctrl = TSEntryViewControllerHelper.fbMatchOddsEuropeCompanyViewController(matchId: mid, companyId: cid, lottery: oddsData.lottery, selectedTab: .history)
        }
        ctrl.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
    /// 显示相同赔率
    @objc func showSameOdds(_ sender: UIGestureRecognizer) {
        guard let dict = sender.view?.extraProperty else { return }
        guard let mid = dict["mid"] as? Int else { return }
        guard let cid = dict["cid"] as? Int else { return }
        let ctrl: UIViewController
        if oddsData.oddsType == .asia {
            ctrl = TSEntryViewControllerHelper.fbMatchOddsAsiaCompanyViewController(matchId: mid, companyId: cid, lottery: oddsData.lottery, selectedTab: .sameOdds)
        } else {
            ctrl = TSEntryViewControllerHelper.fbMatchOddsEuropeCompanyViewController(matchId: mid, companyId: cid, lottery: oddsData.lottery, selectedTab: .sameOdds)
        }
        navigationController?.pushViewController(ctrl, animated: true)
    }
    
}

// MARK:- action
extension FBOddsMatchListViewController {
    
    @IBAction func showPopoverCtrl(_ sender: UIBarButtonItem) {
        popoverBoxCtrl.presentPopover(from: sender, permittedArrowDirections: .any, animated: true, options: .fadeWithScale)
    }
    
}

// MARK:- FBOddsCompanyViewControllerDelegate
extension FBOddsMatchListViewController: FBOddsCompanyViewControllerDelegate {
    
    func oddsCompanyViewController(companyDidChange companys: [CompanyModel], withOddsType oddsType: OddsType) {
        oddsData.companys = companys
        oddsData.oddsType = oddsType
        tableView.reloadData()
    }
}

// MARK:- FBOddsFilterLeagueViewControllerDelegate
extension FBOddsMatchListViewController: FBOddsFilterLeagueViewControllerDelegate {
    func oddsFilterLeagueViewController(dataDidChange data: FBOddsDataModel) {
        if data.lottery != oddsData.lottery && matchList.count > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .none, animated: false)
        }
        oddsData = data
        matchList = oddsData.filterMatchList()
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
    }
}

// MARK:- UITableViewDataSource
extension FBOddsMatchListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oddsData.companys.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FBOddsMatchHeaderView.reuseIdentifier) as! FBOddsMatchHeaderView
        let match = matchList[section]
        header.configCell(match: match, oddsType: oddsData.oddsType)
        header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showMatchDetail)))
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FBOddsMatchTableCell", for: indexPath) as! FBOddsMatchTableCell
        guard (indexPath as NSIndexPath).section < matchList.count && (indexPath as NSIndexPath).row < oddsData.companys.count else {
            return cell
        }
        
        let match = matchList[(indexPath as NSIndexPath).section]
        let company = oddsData.companys[(indexPath as NSIndexPath).row]
        var dict: [String: AnyObject] = ["mid": match.mid as AnyObject]
        
        if oddsData.oddsType == .europe {
            let europes = match.europes
            var odds: FBOddsEuropeSetModel? = nil
            if let index = europes.index(where: { $0.company == company }) {
                odds = europes[index]
                dict.updateValue(odds!.company.cid as AnyObject, forKey: "cid")
            }
            cell.configCell(company: company, europe: odds)
        } else {
            let asias = match.asias
            var odds: FBOddsAsiaSetModel? = nil
            if let index = asias.index(where: { $0.company == company }) {
                odds = asias[index]
                dict.updateValue(odds!.company.cid as AnyObject, forKey: "cid")
            }
            cell.configCell(company: company, asia: odds)
        }
        
        cell.companyView.extraProperty = dict
        cell.oddsView.extraProperty    = dict
        cell.sameButton.extraProperty  = dict
        
        cell.companyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showOddsHistory)))
        cell.oddsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showOddsHistory)))
        cell.sameButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showSameOdds)))
        return cell
    }
    
    // 去除tableview 分割线不紧挨着左边
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
}

// MARK:- FBOddsMatchListHandlerDelegate
extension FBOddsMatchListViewController: FBOddsMatchListHandlerDelegate {
    
    func oddsMatchListHandler(_ handler: FBOddsMatchListHandler, didFetchedData data: FBOddsDataModel) {
        var data = data
        data.lottery  = oddsData.lottery
        data.companys = oddsData.companys
        data.oddsType = oddsData.oddsType
        oddsData = data
        
        matchList = oddsData.filterMatchList()
        tableView.reloadData()
        tableView.mj_header?.endRefreshing()
        
    }
    
    func oddsMatchListHandler(_ handler: FBOddsMatchListHandler, didError error: NSError) {
        tableView.mj_header?.endRefreshing()
        TSToast.showNotificationWithMessage(error.localizedDescription)
    }
    
}

// MARK:- ActionSheetCustomPickerDelegate
extension FBOddsMatchListViewController: ActionSheetCustomPickerDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return oddsData.issueList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let string = oddsData.issueList[row]
        return string == oddsData.currentIssue ? "\(string) 当前期" : string
    }
    
    func actionSheetPicker(_ actionSheetPicker: AbstractActionSheetPicker!, configurePickerView pickerView: UIPickerView!) {
        if let row = oddsData.issueList.index(of: oddsData.selectIssue) {
            pickerView.selectRow(row, inComponent: 0, animated: false)
        }
    }
    
    func actionSheetPickerDidSucceed(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
        tableView.mj_header?.beginRefreshing()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let issue = oddsData.issueList[row]
        oddsData.selectIssue = issue
    }
}

