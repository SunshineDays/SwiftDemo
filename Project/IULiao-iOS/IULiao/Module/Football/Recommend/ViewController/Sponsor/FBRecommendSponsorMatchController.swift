//
//  FBRecommendSponsorMatchController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/13.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh

/// 发起推荐 足球列表
class FBRecommendSponsorMatchController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "赛事选择"
        initNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private let matchHandler = FBRecommendSponsorMatchHandler()
    
    private var dataSource: [[FBRecommendSponsorMatchModel]]! = nil {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var allArray: [FBRecommendSponsorMatchModel]! = nil {
        didSet {
            buildDataSource(array: allArray)
        }
    }
    
    /// 赛事筛选模型数组
    private var selectedArray = [FBRecommendSponsorMatchModel]()
    
    private var selectedLotteryType: Lottery = .all
    
    /// 记录列表展开状态
    private var flagArray = [Bool]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight, width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.navigationBarHeight(self) - TSScreen.statusBarHeight), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.fbRecommendSponsorMatchCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.getMatchListData()
        })
        if #available(iOS 11.0, *) {
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        }
        self.view.addSubview(tableView)
        return tableView
    }()
}

// MARK: - Init
extension FBRecommendSponsorMatchController {
    private func initNetwork() {
        FBProgressHUD.showProgress()
        getMatchListData()
    }
}

// MARK: - Request
extension FBRecommendSponsorMatchController {
    /// 赛事列表
    private func getMatchListData() {
        matchHandler.getMatchList(success: { [weak self] (list) in
            self?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: R.image.fbRecommend2.screen(), style: .plain, target: self, action: #selector(self?.rightAction))
            self?.allArray = list
            self?.tableView.mj_header.endRefreshing()
            FBProgressHUD.isHidden()
        }) { [weak self] (error) in
            self?.tableView.mj_header.endRefreshing()
            FBProgressHUD.isHidden()
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FBRecommendSponsorMatchController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagArray[section] == false ? dataSource[section].count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendSponsorMatchCell, for: indexPath)!
        cell.setupConfigView(model: dataSource[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = R.nib.fbRecommendSponsorMatchtHeaderSectionView.firstView(owner: nil)
        view?.setupConfigView(models: dataSource[section])
        view?.titleButton.tag = section
        view?.selectButton.isSelected = flagArray[section]
        view?.headerViewExpandBlock = {
            self.flagArray[section] = !self.flagArray[section]
            tableView.reloadSections(IndexSet.init(integer: section), with: .none)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = FBRecommendSponsorMatchBetController()
        let model = dataSource[indexPath.section][indexPath.row]
        vc.navigationItem.title = model.home + " VS " + model.away
        vc.initWith(mid: model.mid) { (oddsType) in
            switch oddsType {
            case .europe:
                self.dataSource[indexPath.section][indexPath.row].isBetEurope = true
            case .asianPlate:
                self.dataSource[indexPath.section][indexPath.row].isBetAsia = true
            case .sizePlate:
                self.dataSource[indexPath.section][indexPath.row].isBetDaXiao = true
            default:
                break
            }
            self.tableView.reloadRows(at: [IndexPath.init(row: indexPath.row, section: indexPath.section)], with: .automatic)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Action
extension FBRecommendSponsorMatchController {
    @objc private func rightAction() {
        let vc = FBRecommendSponsorMatchSelectController()
        vc.initWithModels(allArray: allArray, selectedArray: selectedArray, lotteryType: selectedLotteryType) { (selectedModels, lotteryType) in
            self.selectedLotteryType = lotteryType
            if selectedModels.count > 0 {
                self.selectedArray = selectedModels
                self.buildDataSource(array: selectedModels)
            }
            else {
                self.selectedArray.removeAll()
                switch lotteryType {
                case .all:
                    self.buildDataSource(array: self.allArray)
                case .jingcai:
                    var array = [FBRecommendSponsorMatchModel]()
                    for model in self.allArray {
                        if model.isJingCai == 1 {
                            array.append(model)
                        }
                    }
                    self.buildDataSource(array: array)
                case .beidan:
                    var array = [FBRecommendSponsorMatchModel]()
                    for model in self.allArray {
                        if model.isBeiDan == 1 {
                            array.append(model)
                        }
                    }
                    self.buildDataSource(array: array)
                default: break
                }
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Method
extension FBRecommendSponsorMatchController {
    ///  把数据按照日期分组整理
    private func buildDataSource(array: [FBRecommendSponsorMatchModel]) {
        let resultArray = NSMutableArray()
        let modelArray = NSMutableArray()
        var startTime = TSUtils.timeMonthDayHourMinute(TimeInterval(array[0].mTime), withFormat: "yyyy-MM-dd")
        for i in 0 ..< array.count {
            let model = array[i]
            let time = TSUtils.timeMonthDayHourMinute(TimeInterval(model.mTime), withFormat: "yyyy-MM-dd")
            // 把数据按照日期分组
            if startTime == time {
                modelArray.add(model)
            }
            else {
                resultArray.add(modelArray.copy())
                modelArray.removeAllObjects()
                modelArray.add(model)
            }
            if i == array.count - 1 {
                resultArray.add(modelArray.copy())
            }
            startTime = time
        }
        flagArray.removeAll()
        for _ in resultArray {
            self.flagArray.append(false)
        }
        self.dataSource = resultArray as! [[FBRecommendSponsorMatchModel]]
    }
}

