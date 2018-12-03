//
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import SwiftyJSON
import ActionSheetPicker_3_0

/// 赛事分析页 推荐
class FBMatchRecommendViewController: TSEmptyViewController, TSNestInnerScrollViewProtocol, FBMatchViewControllerProtocol {

    private var tableView = UITableView()
    private var headerView: FBMatchRecommendHeaderView?
    
    var matchId: Int!
    var lottery: Lottery?
    
    var scroller: UIScrollView {
        return tableView
    }
    var didScroll: ((UIScrollView) -> Void)?

    private let recommendHandler = FBMatchRecommendHandler()
    
    /// 源数据
    private var recommendList = [FBMatchRecommendModel]() {
        didSet {

        }
    }
    
    /// 源数据
    private var recommendJingcaiList = [FBMatchRecommendModel]() {
        didSet {

        }
    }
    
    /// 计算后数据
    private var dataSource = [FBMatchRecommendModel]()
    
    private var matchInfo = FBMatchModel(json: JSON.null)
    private let playTabs: [FBRecommendModel2.PlayType] = [.none, .europe, .asia, .bigSmall]
    private let sortTabs: [SortType] = [.payoff, .hitPercent, .hits, .createTime]
    private var selectedPlayType = FBRecommendModel2.PlayType.none {
        didSet {
            filterRecommedList()
            tableView.reloadData()
            if dataSource.count > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
        }
    }
    private var selectedSortType = SortType.payoff {
        didSet {
            filterRecommedList()
            tableView.reloadData()
        }
    }

    private var oddsType: RecommendDetailOddsType = .football
    
    private lazy var headerTitleView: FBMatchRecommendSelectHeaderView = {
        let view = R.nib.fbMatchRecommendSelectHeaderView.firstView(owner: nil)!
        view.setupConfigView(oddsType: oddsType, selectedType: { (selectedOddsType) in
            self.oddsType = selectedOddsType
            self.headerView?.playTypeButton.isHidden = selectedOddsType != .football
            if selectedOddsType == .football && self.recommendList.count == 0 {
                self.initNetwork()
            }
            if selectedOddsType == .jingcai && self.recommendJingcaiList.count == 0 {
                self.initNetwork()
            }
            else {
                self.filterRecommedList()
                self.tableView.reloadData()
            }
            
        })
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initNetwork()
    }

    enum SortType {
        case payoff, hitPercent, hits, createTime

        var title: String {
            switch self {
            case .payoff: return "盈利率"
            case .hitPercent: return "命中率"
            case .hits: return "人气"
            case .createTime: return "发布时间"
            }
        }
    }

    override func getData() {
        isLoadData = false
        
        view.bringSubview(toFront: hud)
        hud.offset.y = -(FBMatchMainHeaderViewController.maxHeight / 2)
        hud.show(animated: true)
        
        recommendHandler.getRecommendList(matchId: matchId, lottery: lottery, oddsType: oddsType, success: { (matchModel, recommendList, pageInfo) in
            self.isRequestFailed = false
            self.isLoadData = true
            self.matchInfo = matchModel
            if self.oddsType == .jingcai {
                self.recommendJingcaiList = recommendList
            } else {
                self.recommendList = recommendList
            }
            self.filterRecommedList()
            self.tableView.reloadData()
            self.hud.hide(animated: true)
        }) { (error) in
            self.isRequestFailed = true
            self.filterRecommedList()
            self.tableView.reloadData()
            self.hud.hide(animated: true)
        }
    }
}

extension FBMatchRecommendViewController {
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.fbMatchRecommendTableCell)
        tableView.register(R.nib.fbRecommend2BunchCell)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            make in
            make.top.equalTo(view).offset(40)
            make.bottom.left.right.equalToSuperview()
        }
        view.addSubview(headerTitleView)
        headerTitleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    private func initNetwork() {
        getData()
    }
    
    private func filterRecommedList() {
        var data: [FBMatchRecommendModel]!
        if oddsType != .jingcai {
            if selectedPlayType == .none {
                data = recommendList
            } else {
                data = recommendList.filter { $0.recommend.playType == selectedPlayType }
            }
        }
        else {
            data = recommendJingcaiList
        }
        
        switch selectedSortType {
        case .payoff:
            data.sort(by: { $0.user.day7PayoffPercent > $1.user.day7PayoffPercent })
        case .hitPercent:
            data.sort(by: { $0.user.day7HitPercent > $1.user.day7HitPercent })
        case .hits:
            data.sort(by: { $0.recommend.hits > $1.recommend.hits })
        case .createTime:
            data.sort(by: { $0.recommend.createTime > $1.recommend.createTime })
        }
        dataSource = data
    }
    
    @objc private func playTypeClick() {
        // 不要把actionSheetPicker当做成员变量 会内存泄露
        let actionSheetPicker = ActionSheetCustomPicker(title: "选择玩法", delegate: self, showCancelButton: false, origin: view)
        actionSheetPicker?.toolbarButtonsColor = TSColor.logo
        actionSheetPicker?.show()
    }
}

extension FBMatchRecommendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scroller)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !isLoadData {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !isLoadData {
            return 0
        }
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.row]
        let jingcaiHeight: CGFloat = model.recommend.oddsType == .single ? 170 : 250
        return oddsType == .football ? 120 : jingcaiHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if oddsType == .football {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbMatchRecommendTableCell, for: indexPath)!
            let recommend = dataSource[indexPath.row]
            cell.configCell(recommend: recommend)
            cell.userAvatarClickBlock = {
                [weak self] in
                let vc = FBRecommendExpertController()
                vc.initWith(userId: recommend.user.id, oddsType: .football)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            tableView.separatorStyle = .none
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommend2BunchCell, for: indexPath)!
            tableView.separatorStyle = .singleLine
            cell.setupConfigViewWithRecommendFromJingcai(model: dataSource[indexPath.row])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isLoadData && recommendList.count > 0 {
            return 30
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isLoadData || recommendList.isEmpty {
            return nil
        }
        if headerView == nil {
            headerView = R.nib.fbMatchRecommendHeaderView.firstView(owner: nil)
            headerView?.playTypeButton.isHidden = oddsType != .football
            headerView?.segmentedControl.sectionTitles = sortTabs.map { $0.title }
            headerView?.segmentedControl.indexChangeBlock = {
                [weak self] index in
                self?.selectedSortType = self?.sortTabs[Int(index)] ?? .payoff
            }
            headerView?.playTypeButton.addTarget(self, action: #selector(playTypeClick), for: .touchUpInside)
        }
        headerView?.segmentedControl.selectedSegmentIndex = sortTabs.index(of: selectedSortType) ?? 0
        headerView?.playTypeButton.setTitle(selectedPlayType.name ?? "全部", for: .normal)
        headerView?.playTypeButton.layoutImageViewPosition(.right, withOffset: 6)
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FBRecommendDetailController()
        vc.hidesBottomBarWhenPushed = true
        vc.initWith(resourceId: dataSource[indexPath.row].recommend.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK:- ActionSheetCustomPickerDelegate
extension FBMatchRecommendViewController: ActionSheetCustomPickerDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return playTabs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return playTabs[row].name ?? "全部"
    }
    
    func actionSheetPicker(_ actionSheetPicker: AbstractActionSheetPicker!, configurePickerView pickerView: UIPickerView!) {
        let row = playTabs.index(of: selectedPlayType) ?? 0
        pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPlayType = playTabs[row]
    }
}

extension FBMatchRecommendViewController {
    
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed || isLoadData && recommendList.isEmpty
    }
    
    override func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -(FBMatchMainHeaderViewController.maxHeight / 2)
    }
}
