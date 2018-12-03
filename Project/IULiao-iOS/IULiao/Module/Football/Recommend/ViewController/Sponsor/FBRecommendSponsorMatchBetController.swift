//
//  FBRecommendSponsorMatchBetController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/17.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发布成功
typealias FBRecommendSponsorMatchBetType = (_ oddsType: RecommendDetailOddsType) -> Void

/// 发起推荐 发布足球推荐
class FBRecommendSponsorMatchBetController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: 0xF2F2F2)
        initView()
        initNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /**
     * mid - 联赛id
     * @return 选择类型
     */
    public func initWith(mid: Int, matchBetType: @escaping FBRecommendSponsorMatchBetType) {
        mId = mid
        self.matchBetType = matchBetType
    }
    
    private var mId: Int = 0
    
    /// 返回发布的类型
    private var matchBetType: FBRecommendSponsorMatchBetType!
    
    private let matchHandler = FBRecommendSponsorMatchHandler()
    
    private var matchOddsType = FBMatchOddsViewController.OddsType.europe

    /// 选中的信息
    private var selectedInfoDic = NSMutableDictionary()
        
    /// 记录用户点击了哪一行
    private var selectedRow = 0
    
    private var matchModel: FBRecommendSponsorMatchBetModel! = nil {
        didSet {
            
        }
    }
    
    private var europeFlagArray = [[Bool]]()
    private var asiaFlagArray = [[Bool]]()
    private var daXiaoFlagArray = [[Bool]]()
    
    private var europeDataSource = [FBRecommendSponsorMatchBetEuropeModel]()
    private var asiaDataSource = [FBRecommendSponsorMatchBetAsiaModel]()
    private var daXiaoDataSource = [FBRecommendSponsorMatchBetDaXiaoModel]()

    private lazy var segmentedControl: HMSegmentedControl = {
        let segmentedControl = HMSegmentedControl.init(frame: CGRect.init(x: 0, y: TSScreen.statusBarHeight + TSScreen.navigationBarHeight(self), width: TSScreen.currentWidth, height: 40))
        segmentedControl.backgroundColor = UIColor.white
        segmentedControl.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0x333333),
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
        segmentedControl.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hex: 0xFF974B),
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)
        ]
        segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        segmentedControl.selectionIndicatorColor = baseNavigationBarTintColor
        segmentedControl.selectionIndicatorLocation = .down
        segmentedControl.selectionIndicatorHeight = 3
        segmentedControl.selectionStyle = .fullWidthStripe
        var index = Int()
        if daXiaoDataSource.count > 0 {
            index = 2
        }
        if asiaDataSource.count > 0 {
            index = 1
        }
        if europeDataSource.count > 0 {
            index = 0
        }
        segmentedControl.selectedSegmentIndex = index

        segmentedControl.sectionTitles = ["欧赔", "亚盘", "大小球"]
        segmentedControl.indexChangeBlock = { index in
            // 清除选中数据
            self.selectedInfoDic.removeAllObjects()
            self.selectedRow = 0
            
            self.europeFlagArray.removeAll()
            self.asiaFlagArray.removeAll()
            self.daXiaoFlagArray.removeAll()
            
            for _ in self.europeDataSource {
                self.europeFlagArray.append([false, false, false])
            }
            self.asiaDataSource = self.matchModel.asiaList
            for _ in self.asiaDataSource {
                self.asiaFlagArray.append([false, false])
            }
            self.daXiaoDataSource = self.matchModel.daXiaoList
            for _ in self.daXiaoDataSource {
                self.daXiaoFlagArray.append([false, false])
            }
            
            self.tableView.reloadData()
            switch index {
            case 0: self.matchOddsType = .europe
            case 1: self.matchOddsType = .asia
            case 2: self.matchOddsType = .bigSmall
            default: break
            }
        }
        self.view.addSubview(segmentedControl)
        return segmentedControl
    }()
    
    private lazy var tableHeaderView: FBRecommendSponsorMatchBetHeaderView = {
        let view = R.nib.fbRecommendSponsorMatchBetHeaderView.firstView(owner: nil)!
        view.matchDataButton.addTarget(self, action: #selector(matchDetailAction(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var tableFooterView: FBRecommendSponsorMatchBetFooterView = {
        let view = R.nib.fbRecommendSponsorMatchBetFooterView.firstView(owner: nil)!
        view.confirmButton.addTarget(self, action: #selector(confirmAction(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: segmentedControl.frame.maxY + 5, width: TSScreen.currentWidth, height: TSScreen.currentHeight - segmentedControl.height - 5 - TSScreen.navigationBarHeight(self) - TSScreen.statusBarHeight), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.register(R.nib.fbRecommendSponsorMatchBetEuropeCell)
        tableView.register(R.nib.fbRecommendSponsorMatchBetCell)
        tableView.separatorStyle = .none
        tableView.tableHeaderView = tableHeaderView
        tableView.tableFooterView = tableFooterView
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        return tableView
    }()
}

// MARK: - Init
extension FBRecommendSponsorMatchBetController {
    private func initView() {
//        tableView.reloadData()
    }
    
    private func initNetwork() {
        getMatchBetData()
    }
}

// MARK: - Request
extension FBRecommendSponsorMatchBetController {
    /// 获取投注详情数据
    private func getMatchBetData() {
        FBProgressHUD.showProgress()
        matchHandler.getMatchBet(mId: mId, success: { [weak self] (model) in
            FBProgressHUD.isHidden()
            self?.matchModel = model
            self?.europeDataSource = model.europeList
            if let europes = self?.europeDataSource {
                for _ in europes {
                    self?.europeFlagArray.append([false, false, false])
                }
            }
            self?.asiaDataSource = model.asiaList
            if let asias = self?.asiaDataSource {
                for _ in asias {
                    self?.asiaFlagArray.append([false, false])
                }
            }
            self?.daXiaoDataSource = model.daXiaoList
            if let daXiaos = self?.daXiaoDataSource {
                for _ in daXiaos {
                    self?.daXiaoFlagArray.append([false, false])
                }
            }
            self?.tableView.reloadData()
        }) { (error) in
            FBProgressHUD.isHidden()
        }
    }
    
    /// 投注发布
    private func postMatchBetSelectedData() {
        let result = jsonString()
        matchHandler.postMatchBetResult(json: result.0, success: { [weak self] (json) in
            self?.matchBetType(result.1)
            self?.navigationController?.popViewController(animated: true)
            FBProgressHUD.showSuccessInfor(text: "发布推荐成功")
        }) { (error) in
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FBRecommendSponsorMatchBetController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            return asiaDataSource.count + 1
        case 2:
            return daXiaoDataSource.count + 1
        default:
            return europeDataSource.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentedControl.selectedSegmentIndex {
        case 1: //亚盘
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendSponsorMatchBetCell, for: indexPath)!
            if indexPath.row == 0 {
                cell.setupConfigTitleView(titles: ["主队", "盘口", "客队"])
            }
            else {
                cell.setupConfigView(asiaModel: asiaDataSource[indexPath.row - 1])
                cell.setupFlag(flags: asiaFlagArray[indexPath.row - 1])
                cell.homeTeamButton.tag = indexPath.row - 1
                cell.awayTeamButton.tag = indexPath.row - 1
                cell.homeTeamButton.addTarget(self, action: #selector(homeTeamButtonAction(_:)), for: .touchUpInside)
                cell.awayTeamButton.addTarget(self, action: #selector(awayTeamButtonAction(_:)), for: .touchUpInside)
            }
            return cell
        case 2: //大小球
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendSponsorMatchBetCell, for: indexPath)!
            if indexPath.row == 0 {
                cell.setupConfigTitleView(titles: ["大球", "盘口", "小球"])
            }
            else {
                cell.setupConfigView(daXiaoModel: daXiaoDataSource[indexPath.row - 1])
                cell.setupFlag(flags: daXiaoFlagArray[indexPath.row - 1])
                cell.homeTeamButton.tag = indexPath.row - 1 + 100
                cell.awayTeamButton.tag = indexPath.row - 1 + 100
                cell.homeTeamButton.addTarget(self, action: #selector(homeTeamButtonAction(_:)), for: .touchUpInside)
                cell.awayTeamButton.addTarget(self, action: #selector(awayTeamButtonAction(_:)), for: .touchUpInside)
            }
            return cell
        default: //欧赔
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.fbRecommendSponsorMatchBetEuropeCell, for: indexPath)!
            if indexPath.row == 0 {
                cell.setupConfigTitleView(titles: ["让球数", "主胜", "平局", "主负"])
            }
            else {
                cell.setupConfigView(model: europeDataSource[indexPath.row - 1])
                cell.setupFlag(flags: europeFlagArray[indexPath.row - 1])
                cell.winButton.tag = indexPath.row - 1
                cell.drawButton.tag = indexPath.row - 1
                cell.lostButton.tag = indexPath.row - 1
                cell.winButton.addTarget(self, action: #selector(winButtonAction(_:)), for: .touchUpInside)
                cell.drawButton.addTarget(self, action: #selector(drawButtonAction(_:)), for: .touchUpInside)
                cell.lostButton.addTarget(self, action: #selector(lostButtonAction(_:)), for: .touchUpInside)
            }
            return cell
        }
    }
}



// MARK: - Action
extension FBRecommendSponsorMatchBetController {
    /// 主胜
    @objc private func winButtonAction(_ button: UIButton) {
        changeEuropeFlag(tag: button.tag, index: 0)
    }
    
    /// 平局
    @objc private func drawButtonAction(_ button: UIButton) {
        changeEuropeFlag(tag: button.tag, index: 1)
    }
    
    /// 主负
    @objc private func lostButtonAction(_ button: UIButton) {
        changeEuropeFlag(tag: button.tag, index: 2)
    }
    
    /// 主队(亚盘) 大球(大小球)
    @objc private func homeTeamButtonAction(_ button: UIButton) {
        if button.tag >= 100 { //大小球
            changeDaXiaoFlag(tag: button.tag - 100, index: 0)
        }
        else { //亚盘
            changeAsiaFlag(tag: button.tag, index: 0)
        }
    }
    
    /// 客队(亚盘) 小球(大小球)
    @objc private func awayTeamButtonAction(_ button: UIButton) {
        if button.tag >= 100 { //大小球
            changeDaXiaoFlag(tag: button.tag - 100, index: 1)
        }
        else { //亚盘
            changeAsiaFlag(tag: button.tag, index: 1)
        }
    }
    
    /// 确认发布
    @objc private func confirmAction(_ button: UIButton) {
        if selectedInfoDic.allKeys.count == 0 {
            FBProgressHUD.showInfor(text: "请选择一种投注")
        }
        else {
            postMatchBetSelectedData()
        }
    }
    
    /// 本场赛事资料
    @objc private func matchDetailAction(_ button: UIButton) {
        let vc = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: matchModel.match.mid, lottery: .all, selectedTab: .odds(matchOddsType))
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Method
extension FBRecommendSponsorMatchBetController {
    /// 大小球
    private func changeDaXiaoFlag(tag: Int, index: Int) {
        selectedRow = tag
        // 清空选中的数据
        selectedInfoDic.removeAllObjects()
        daXiaoFlagArray.removeAll()
        for _ in daXiaoDataSource {
            daXiaoFlagArray.append([false, false])
        }
        // 选中的模型
        let model = daXiaoDataSource[tag]
        // 记录选中的数据类型，用字典保存
        var resultValue = Double()
        var resultKey = String()
        switch index {
        case 0:
            resultKey = "big"
            resultValue = model.big
        case 1:
            resultKey = "small"
            resultValue = model.small
        default:
            break
        }
        selectedInfoDic.removeObject(forKey: resultKey)
        selectedInfoDic.addEntries(from: [resultKey : resultValue])
        daXiaoFlagArray[tag][index] = !daXiaoFlagArray[tag][index]
        tableView.reloadData()
    }
    
    /// 亚盘
    private func changeAsiaFlag(tag: Int, index: Int) {
        selectedRow = tag
        // 清空选中的数据
        selectedInfoDic.removeAllObjects()
        asiaFlagArray.removeAll()
        for _ in asiaDataSource {
            asiaFlagArray.append([false, false])
        }
        // 选中的模型
        let model = asiaDataSource[tag]
        // 记录选中的数据类型，用字典保存
        var resultValue = Double()
        var resultKey = String()
        switch index {
        case 0:
            resultKey = "above"
            resultValue = model.above
        case 1:
            resultKey = "below"
            resultValue = model.below
        default:
            break
        }
        selectedInfoDic.removeObject(forKey: resultKey)
        selectedInfoDic.addEntries(from: [resultKey : resultValue])
        asiaFlagArray[tag][index] = !asiaFlagArray[tag][index]
        tableView.reloadData()
    }
    
    /// 欧赔
    private func changeEuropeFlag(tag: Int, index: Int) {
        // 点击其它行清空数据
        if selectedRow != tag {
            selectedRow = tag
            selectedInfoDic.removeAllObjects()
            europeFlagArray.removeAll()
            for _ in europeDataSource {
                europeFlagArray.append([false, false, false])
            }
        }
        // 选中的模型
        let model = europeDataSource[tag]
        // 记录选中的数据类型，用字典保存
        var resultValue = Double()
        var resultKey = String()
        switch index {
        case 0:
            resultKey = "win"
            resultValue = model.win
        case 1:
            resultKey = "draw"
            resultValue = model.draw
        case 2:
            resultKey = "lost"
            resultValue = model.lost
        default:
            break
        }
        // 判断字典中是否包含这个数据
        var isHave = false
        for key in selectedInfoDic.allKeys {
            if key as! String == resultKey {
                isHave = true
                break
            }
        }
        if isHave {
            selectedInfoDic.removeObject(forKey: resultKey)
            europeFlagArray[tag][index] = !europeFlagArray[tag][index]
            tableView.reloadData()
        }
        else {
            if selectedInfoDic.allValues.count < 2 {
                if selectedInfoDic.allValues.count == 1 {
                    let value: Double = selectedInfoDic.allValues[0] as! Double
                    if value * resultValue / (value + resultValue) < 1.5 {
                        FBProgressHUD.showInfor(text: "双选返还率不能低于1.5")
                    }
                    else {
                        selectedInfoDic.addEntries(from: [resultKey : resultValue])
                        europeFlagArray[tag][index] = !europeFlagArray[tag][index]
                        tableView.reloadData()
                    }
                }
                else {
                    selectedInfoDic.addEntries(from: [resultKey : resultValue])
                    europeFlagArray[tag][index] = !europeFlagArray[tag][index]
                    tableView.reloadData()
                }
            }
            else {
                FBProgressHUD.showInfor(text: "最多选择两种")
            }
        }
    }
    
    /// 把数据转换成json字符串
    private func jsonString() -> (String, RecommendDetailOddsType) {
        var beton = ""
        for dic in selectedInfoDic {
            beton = beton + (dic.key as! String) + String(format: "=%.2f", dic.value as! Double) + ","
        }
        if !beton.isEmpty {
            beton.removeLast()
        }
        let dic = NSMutableDictionary()
        dic.setValue(mId, forKey: "mid")
        dic.setValue(beton, forKey: "beton")
        dic.setValue(tableFooterView.reasonTextView.text, forKey: "reason")
        
        // 类型
        var oddsType = RecommendDetailOddsType.europe
        let odds = NSMutableDictionary()
        switch segmentedControl.selectedSegmentIndex {
        case 0: //欧赔
            oddsType = .europe
            odds.setValue(europeDataSource[selectedRow].letBall, forKey: "letball")
            odds.setValue(String(format: "%.2f", europeDataSource[selectedRow].win), forKey: "win")
            odds.setValue(String(format: "%.2f", europeDataSource[selectedRow].draw), forKey: "draw")
            odds.setValue(String(format: "%.2f", europeDataSource[selectedRow].lost), forKey: "lost")
        case 1: //亚盘
            oddsType = .asianPlate
            odds.setValue(String(format: "%.2f", asiaDataSource[selectedRow].above), forKey: "above")
            odds.setValue(asiaDataSource[selectedRow].bet, forKey: "bet")
            odds.setValue(String(format: "%.2f", asiaDataSource[selectedRow].below), forKey: "below")
            odds.setValue(asiaDataSource[selectedRow].type, forKey: "type")
            odds.setValue(asiaDataSource[selectedRow].handicap, forKey: "handicap")
        case 2: //大小球
            oddsType = .sizePlate
            odds.setValue(String(format: "%.2f", daXiaoDataSource[selectedRow].small), forKey: "small")
            odds.setValue(daXiaoDataSource[selectedRow].bet, forKey: "bet")
            odds.setValue(String(format: "%.2f", daXiaoDataSource[selectedRow].big), forKey: "big")
            odds.setValue(daXiaoDataSource[selectedRow].handicap, forKey: "handicap")
        default:
            break
        }
        dic.setValue(oddsType.rawValue, forKey: "oddstype")
        dic.setValue(odds, forKey: "odds")
        
        let data = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) ?? ""
        
        return ((jsonString as String), oddsType)
    }
    
}





