//
//  FBRecommendSponsorMatchJingcaiController.swift
//  IULiao
//
//  Created by bin zhang on 2018/5/2.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MJRefresh

/// 发起推荐 竞彩列表
class FBRecommendSponsorMatchJingcaiController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        navigationItem.title = "赛事选择"
        initView()
        initNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private let matchHandler = FBRecommendSponsorMatchHandler()
    
    /// 请求到的所有数据
    private var requestArray = [FBRecommendSponsorMatchModel]()
    /// 上个界面选择的数据
    private var selectedArray = [FBRecommendSponsorMatchModel]()
    /// 刷新界面的数据
    private var dataSource = [[FBRecommendSponsorMatchModel]]() {
        didSet {
            
        }
    }
    /// 记录列表展开状态
    private var flagArray = [Bool]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: TSScreen.navigationBarHeight(self) + TSScreen.statusBarHeight, width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.navigationBarHeight(self) - TSScreen.statusBarHeight - footerView.height), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.fbRecommendSponsorMatchJingcaiCell)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.initNetwork()
        })
        if #available(iOS 11.0, *) {
            tableView.estimatedRowHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.estimatedSectionHeaderHeight = 0
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.view.addSubview(tableView)
        return tableView
    }()

    private lazy var footerView: FBRecommendSponsorMatchJIngcaiFooterView = {
        let view = R.nib.fbRecommendSponsorMatchJIngcaiFooterView.firstView(owner: nil)!
        let height: CGFloat = TSScreen.statusBarHeight > 20 ? 48 + 12 : 48
        view.frame = CGRect(x: 0, y: TSScreen.currentHeight - height, width: TSScreen.currentWidth, height: height)
        view.nextButton.addTarget(self, action: #selector(nextAction(_:)), for: .touchUpInside)
        view.clearButton.addTarget(self, action: #selector(clearAction(_:)), for: .touchUpInside)
        self.view.addSubview(view)
        return view
    }()
    
}

// MARK: - Init
extension FBRecommendSponsorMatchJingcaiController {
    private func initView() {
//        tableView.reloadData()
    }
    
    private func initNetwork() {
        FBProgressHUD.showProgress()
        getMatchListData()
    }
}

// MARK: - Request
extension FBRecommendSponsorMatchJingcaiController {
    /// 赛事列表
    private func getMatchListData() {
        matchHandler.getMatchJingcaiList(success: { [weak self] (list) in
            self?.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: R.image.fbRecommend2.screen(), style: .plain, target: self, action: #selector(self?.rightAction))
            FBProgressHUD.isHidden()
            self?.requestArray = list
            self?.buildDataSource(array: list)
            self?.tableView.mj_header.endRefreshing()
        }) { [weak self] (error) in
            FBProgressHUD.isHidden()
            TSToast.showNotificationWithTitle(error.localizedDescription)
            self?.tableView.mj_header.endRefreshing()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FBRecommendSponsorMatchJingcaiController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flagArray[section] == false ? dataSource[section].count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendSponsorMatchJingcaiCell, for: indexPath)!
        cell.setupConfigView(model: dataSource[indexPath.section][indexPath.row])
        cell.selectedModelType = { sender, model in
            self.changeDataSource(selectedModel: model, dataSourceModels: self.dataSource, indexPath: indexPath, cell: cell, sender: sender)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = R.nib.fbRecommendSponsorMatchtHeaderSectionView.firstView(owner: nil)
        view?.setupConfigViewWithJingcai(models: dataSource[section])
        view?.titleButton.tag = section
        view?.selectButton.isSelected = flagArray[section]
        view?.headerViewExpandBlock = {
            self.flagArray[section] = !self.flagArray[section]
            tableView.reloadSections(IndexSet.init(integer: section), with: .automatic)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - Action
extension FBRecommendSponsorMatchJingcaiController {
    /// 赛事筛选
    @objc private func rightAction() {
        let vc = FBRecommendSponsorMatchSelectController()
        vc.initWithModels(allArray: requestArray, selectedArray: selectedArray, lotteryType: nil) { (selectedModels, lotteryType) in
            if selectedModels.count > 0 {
                self.clear()
                self.selectedArray = selectedModels
                self.buildDataSource(array: selectedModels)
            }
            else {
                self.selectedArray.removeAll()
                self.buildDataSource(array: self.requestArray)
            }
            var selectedModels = [FBRecommendSponsorMatchModel]()
            for model in self.selectedArray {
                if model.selectedType.isWin || model.selectedType.isDraw || model.selectedType.isLost || model.selectedType.isLetWin || model.selectedType.isLetDraw || model.selectedType.isLetLost {
                    selectedModels.append(model)
                }
            }
            var isDan = false
            for model in selectedModels {
                if (model.spfFixed == 1 && model.spfSingle == 1) || (model.rqspfFixed == 1 && model.rqspfSingle == 1) {
                    isDan = true
                }
            }
            self.changeFooterView(isDan: isDan, selectedModels: selectedModels)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 清空选中
    @objc private func clearAction(_ sender: UIButton) {
        clear()
    }
    
    /// 下一步
    @objc private func nextAction(_ sender: UIButton) {
        let vc = R.storyboard.fbRecommendSponsorMatchJingcaiBet.fbRecommendSponsorMatchJingcaiBetController()!
        vc.initWith(models: selectedArrayWithModels())
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Method
extension FBRecommendSponsorMatchJingcaiController {
    /// 清空选中
    private func clear() {
        for i in 0 ..< dataSource.count {
            for j in 0 ..< dataSource[i].count {
                dataSource[i][j].selectedType.isWin = false
                dataSource[i][j].selectedType.isDraw = false
                dataSource[i][j].selectedType.isLost = false
                dataSource[i][j].selectedType.isLetWin = false
                dataSource[i][j].selectedType.isLetDraw = false
                dataSource[i][j].selectedType.isLetLost = false
            }
        }
        tableView.reloadData()
        nextButton(isSelected: false)
        footerView.numberLabel.text = "0"
    }
    
    ///  把数据按照日期分组整理
    private func buildDataSource(array: [FBRecommendSponsorMatchModel]) {
        let resultArray = NSMutableArray()
        let modelArray = NSMutableArray()
        var startDay = String()
        if array.count > 0 {
            let startH = TSUtils.timeMonthDayHourMinute(TimeInterval(array[0].mTime), withFormat: "HH")
            if Int(startH) ?? 0 < 12 {
                startDay = TSUtils.timeMonthDayHourMinute(TimeInterval(array[0].mTime - 12 * 60 * 60), withFormat: "yyyy-MM-dd")
            }
            else {
                startDay = TSUtils.timeMonthDayHourMinute(TimeInterval(array[0].mTime), withFormat: "yyyy-MM-dd")
            }
            for i in 0 ..< array.count {
                let model = array[i]
                let day = TSUtils.timeMonthDayHourMinute(TimeInterval(model.mTime - 12 * 60 * 60), withFormat: "yyyy-MM-dd")
                // 把数据按照日期分组
                
                if startDay == day {
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
                startDay = day
            }
            flagArray.removeAll()
            for _ in resultArray {
                flagArray.append(false)
            }
            dataSource = resultArray as! [[FBRecommendSponsorMatchModel]]
            
            tableView.reloadData()
        }
    }
    
    private func changeDataSource(selectedModel: FBRecommendSponsorMatchModel, dataSourceModels: [[FBRecommendSponsorMatchModel]], indexPath: IndexPath, cell: FBRecommendSponsorMatchJingcaiCell, sender: UIButton) {
        var modelss = dataSourceModels
        modelss[indexPath.section][indexPath.row] = selectedModel
        /// 所有选中的模型数组
        var selectedModels = [FBRecommendSponsorMatchModel]()
        for models in modelss {
            for model in models {
                if model.selectedType.isWin || model.selectedType.isDraw || model.selectedType.isLost || model.selectedType.isLetWin || model.selectedType.isLetDraw || model.selectedType.isLetLost {
                    selectedModels.append(model)
                }
            }
        }
        if selectedModels.count == 0 {
            nextButton(isSelected: false)
            reloadDataSource(dataSource: modelss, indexPath: indexPath)
        }
        else if selectedModels.count == 1 {
            /// 选中的数据模型
            let model = selectedModels[0]
            var number = [Double]()
            if model.selectedType.isWin {
                number.append(model.odds.win)
            }
            if model.selectedType.isDraw {
                number.append(model.odds.draw)
            }
            if model.selectedType.isLost {
                number.append(model.odds.lost)
            }
            if model.selectedType.isLetWin {
                number.append(model.odds.letWin)
            }
            if model.selectedType.isLetDraw {
                number.append(model.odds.letDraw)
            }
            if model.selectedType.isLetLost {
                number.append(model.odds.letLost)
            }
            
            if number.count == 1 {
                if isDan(model: model) {
                    nextButton(isSelected: true)
                    reloadDataSource(dataSource: modelss, indexPath: indexPath)
                }
                else if isLetDan(model: model) {
                    nextButton(isSelected: true)
                    reloadDataSource(dataSource: modelss, indexPath: indexPath)
                }
                else {
                    nextButton(isSelected: false)
                    reloadDataSource(dataSource: modelss, indexPath: indexPath)
                }
            }
            else if number.count == 2 {
                // 如果选择的是单
                if isDan(model: model) {
                    // 如果选择的是不同行(只选择一场比赛时，选择同行按钮不能点击)
                    if model.selectedType.isLetWin || model.selectedType.isLetDraw || model.selectedType.isLetLost {
                        nextButton(isSelected: false)
                        reloadDataSource(dataSource: modelss, indexPath: indexPath)
                    }
                    else {
                        if number[0] * number[1] / (number[0] + number[1]) < 1 {
                            FBProgressHUD.showInfor(text: "双选返还率不能低于1.0")
                            self.dataSource[indexPath.section][indexPath.row] = self.senderModel(cell: cell, sender: sender, selectedModel: selectedModel)
                        }
                        else {
                            nextButton(isSelected: true)
                            reloadDataSource(dataSource: modelss, indexPath: indexPath)
                        }
                    }
                }
                else {
                    if number[0] * number[1] / (number[0] + number[1]) < 1 {
                        FBProgressHUD.showInfor(text: "双选返还率不能低于1.0")
                        self.dataSource[indexPath.section][indexPath.row] = self.senderModel(cell: cell, sender: sender, selectedModel: selectedModel)
                    }
                    else {
                        nextButton(isSelected: false)
                        reloadDataSource(dataSource: modelss, indexPath: indexPath)
                    }
                }
            }
            else {
                FBProgressHUD.showInfor(text: "同一场比赛最多选择2项")
                self.dataSource[indexPath.section][indexPath.row] = self.senderModel(cell: cell, sender: sender, selectedModel: selectedModel)
                }
        }
        else if selectedModels.count == 2 {
            var numbers = [[Double](), [Double]()]
            for i in 0 ..< selectedModels.count {
                let model = selectedModels[i]
                if model.selectedType.isWin {
                    numbers[i].append(model.odds.win)
                }
                if model.selectedType.isDraw {
                    numbers[i].append(model.odds.draw)
                }
                if model.selectedType.isLost {
                    numbers[i].append(model.odds.lost)
                }
                if model.selectedType.isLetWin {
                    numbers[i].append(model.odds.letWin)
                }
                if model.selectedType.isLetDraw {
                    numbers[i].append(model.odds.letDraw)
                }
                if model.selectedType.isLetLost {
                    numbers[i].append(model.odds.letLost)
                }
            }
        
            if numbers[0].count > 2 || numbers[1].count > 2 {
                FBProgressHUD.showInfor(text: "同一场比赛最多选择2项")
                self.dataSource[indexPath.section][indexPath.row] = self.senderModel(cell: cell, sender: sender, selectedModel: selectedModel)
            }
            else {
                reloadDataSource(dataSource: modelss, indexPath: indexPath)
                nextButton(isSelected: true)
            }
        }
        else {
            FBProgressHUD.showInfor(text: "最多选择两场比赛")
            self.dataSource[indexPath.section][indexPath.row] = self.senderModel(cell: cell, sender: sender, selectedModel: selectedModel)
        }
    }
    
    private func senderModel(cell: FBRecommendSponsorMatchJingcaiCell, sender: UIButton, selectedModel: FBRecommendSponsorMatchModel) -> FBRecommendSponsorMatchModel {
        let model = selectedModel
        switch sender {
        case cell.winButton:
            model.selectedType.isWin = !selectedModel.selectedType.isWin
        case cell.drawButton:
            model.selectedType.isDraw = !selectedModel.selectedType.isDraw
        case cell.lostButton:
            model.selectedType.isLost = !selectedModel.selectedType.isLost
        case cell.letWinButton:
            model.selectedType.isLetWin = !selectedModel.selectedType.isLetWin
        case cell.letDrawButton:
            model.selectedType.isLetDraw = !selectedModel.selectedType.isLetDraw
        case cell.letLostButton:
            model.selectedType.isLetLost = !selectedModel.selectedType.isLetLost
        default:
            break
        }
        return model
    }
    
    private func isDan(model: FBRecommendSponsorMatchModel) -> Bool {
        var isDan = false
        if model.spfFixed == 1 && model.spfSingle == 1 && (model.selectedType.isWin || model.selectedType.isDraw || model.selectedType.isLost) {
            isDan = true
        }
        return isDan
    }
    
    private func isLetDan(model: FBRecommendSponsorMatchModel) -> Bool {
        var isLetDan = false
        if model.rqspfFixed == 1 && model.rqspfSingle == 1 && (model.selectedType.isLetWin || model.selectedType.isLetDraw || model.selectedType.isLetLost) {
            isLetDan = true
        }
        return isLetDan
    }
    
    
    private func reloadDataSource(dataSource: [[FBRecommendSponsorMatchModel]], indexPath: IndexPath) {
        self.dataSource = dataSource
        tableView.reloadRows(at: [indexPath], with: .none)
        var selectedModels = [FBRecommendSponsorMatchModel]()
        for models in self.dataSource {
            for model in models {
                if model.selectedType.isWin || model.selectedType.isDraw || model.selectedType.isLost || model.selectedType.isLetWin || model.selectedType.isLetDraw || model.selectedType.isLetLost {
                    selectedModels.append(model)
                }
            }
        }
        footerView.numberLabel.text = "\(selectedModels.count)"
    }
    
    private func nextButton(isSelected: Bool) {
        footerView.nextButton.isSelected = isSelected
        footerView.nextButton.isUserInteractionEnabled = isSelected
    }
    
    /// 获取选中的模型数组
    private func selectedArrayWithModels() -> [FBRecommendSponsorMatchModel] {
        var selectedArray = [FBRecommendSponsorMatchModel]()
        for models in dataSource {
            for model in models {
                if !(!model.selectedType.isWin && !model.selectedType.isDraw && !model.selectedType.isLost && !model.selectedType.isLetWin && !model.selectedType.isLetDraw && !model.selectedType.isLetLost) {
                    selectedArray.append(model)
                }
            }
        }
        return selectedArray
    }
    
    /// 改变下一步按钮的选中状态
    private func changeFooterView(isDan: Bool, selectedModels: [FBRecommendSponsorMatchModel]) {
        if isDan {
            // 根据数据刷新按钮状态
            footerView.nextButton.isSelected = selectedModels.count >= 1
        }
        else {
            // 根据数据刷新按钮状态
            footerView.nextButton.isSelected = selectedModels.count == 2
        }
        footerView.nextButton.isUserInteractionEnabled = footerView.nextButton.isSelected
        
        footerView.numberLabel.text = "\(selectedModels.count)"
        

    }
    
}
