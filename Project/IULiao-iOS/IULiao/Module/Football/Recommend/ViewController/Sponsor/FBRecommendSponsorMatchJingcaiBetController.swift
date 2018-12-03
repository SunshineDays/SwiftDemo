//
//  FBRecommendSponsorMatchJingcaiBetController.swift
//  IULiao
//
//  Created by bin zhang on 2018/5/4.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 发起推荐 发布竞彩推荐
class FBRecommendSponsorMatchJingcaiBetController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var leagueBackgroundConstraint: NSLayoutConstraint!
    @IBOutlet weak var leagueBackgroundView: UIView!
    
    @IBOutlet weak var date1Label: UILabel!
    @IBOutlet weak var leagueName1Label: UILabel!
    @IBOutlet weak var time1Label: UILabel!
    @IBOutlet weak var homeTeam1Label: UILabel!
    @IBOutlet weak var awayTeam1Label: UILabel!
    @IBOutlet weak var result1Label: UILabel!
    
    @IBOutlet weak var league2View: UIView!
    
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var leagueName2Label: UILabel!
    @IBOutlet weak var time2Label: UILabel!
    @IBOutlet weak var homeTeam2Label: UILabel!
    @IBOutlet weak var awayTeam2Label: UILabel!
    @IBOutlet weak var result2Label: UILabel!

    @IBOutlet weak var reasonTextView: UITextView!
    
    @IBOutlet weak var footerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var hitPercentStateLabel: UILabel!
    @IBOutlet weak var foldLabel: UILabel!
    
    @IBAction func confirmAction(_ sender: UIButton) {
        confirmAction()
    }
    
    /**
     * models - 选中的模型数组
     */
    public func initWith(models: [FBRecommendSponsorMatchModel]) {
        self.models = models
    }
    
    private let matchHandler = FBRecommendSponsorMatchHandler()

    private var models = [FBRecommendSponsorMatchModel]()
}

// MARK: - Init
extension FBRecommendSponsorMatchJingcaiBetController {
    private func initView() {
        if models.count == 1 {
            initLeague1View()
            leagueBackgroundConstraint.constant = 90
            league2View.isHidden = true
        }
        if models.count == 2 {
            initLeague1View()
            initLeague2View()
        }
        initNavigationItemTitle()
        initFooterView()
        initLeageBackgroundView()
    }
    
    /// 标题
    private func initNavigationItemTitle() {
        if models.count == 1 {
            navigationItem.title = models[0].home + " VS " + models[0].away
        }
        if models.count == 2 {
            navigationItem.title = "竞彩2串1"
        }
    }
    
    /// 阴影
    private func initLeageBackgroundView() {
        leagueBackgroundView.layer.shadowColor = UIColor(hex: 0x040000).cgColor
        leagueBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 1)
        leagueBackgroundView.layer.shadowOpacity = 0.5
    }
    
    /// 初始化第一场比赛的信息
    private func initLeague1View() {
        let model = models[0]
        date1Label.text = model.serial
        leagueName1Label.text = model.lName
        leagueName1Label.textColor = UIColor(rgba: model.color)
        time1Label.text = TSUtils.timeMonthDayHourMinute(TimeInterval(model.mTime), withFormat: "HH:mm")
        homeTeam1Label.text = model.home
        awayTeam1Label.text = model.away
        result1Label.text = resultLabelText(model: model)
    }
    
    /// 初始化第二场比赛的信息
    private func initLeague2View() {
        let model = models[1]
        date2Label.text = model.serial
        leagueName2Label.text = model.lName
        leagueName2Label.textColor = UIColor(rgba: model.color)
        time2Label.text = TSUtils.timeMonthDayHourMinute(TimeInterval(model.mTime), withFormat: "HH:mm")
        homeTeam2Label.text = model.home
        awayTeam2Label.text = model.away
        result2Label.text = resultLabelText(model: model)
    }
    
    private func initFooterView() {
        // 适配 iPhone X
        footerViewHeightConstraint.constant = TSScreen.statusBarHeight > 20 ? 48 + 12 : 48
        if models.count == 1 {
            let array = arrayWithModel(model: models[0])
            numberLabel.text = String(format: "%d", array.count)
            if array.count == 1 {
                hitPercentStateLabel.text = "盈利率为:"
                foldLabel.text = array[0].decimal(2)
            }
            if array.count == 2 {
                hitPercentStateLabel.text = "盈利率范围为:"
                foldLabel.text = array.min()!.decimal(2) + "~" + array.max()!.decimal(2)
            }
        }
        if models.count == 2 {
            let array1 = arrayWithModel(model: models[0])
            let array2 = arrayWithModel(model: models[1])
            
            numberLabel.text = String(format: "%d", array1.count * array2.count)
            if array1.count == 1 && array2.count == 1 {
                hitPercentStateLabel.text = "盈利率为:"
                foldLabel.text = String(format: "%.2f", array1[0] * array2[0])
            }
            else {
                hitPercentStateLabel.text = "盈利率范围为:"
                foldLabel.text = String(format: "%.2f~%.2f", array1.min()! * array2.min()!, array1.max()! * array2.max()!)
            }
        }
    }
}

// MARK: - Request
extension FBRecommendSponsorMatchJingcaiBetController {
    /// 发起
    private func postMatchBet(json: String) {
        matchHandler.postMatchBetResult(json: json, success: { [weak self] (json) in
            self?.navigationController?.popViewController(animated: true)
            FBProgressHUD.showSuccessInfor(text: "发布推荐成功")
        }) { (error) in
            TSToast.showNotificationWithTitle(error.localizedDescription)
        }
    }
}

// MARK: - Action
extension FBRecommendSponsorMatchJingcaiBetController {
    /// 发起
    private func confirmAction() {
        let model1 = models[0]
       
        let dic = NSMutableDictionary()
        dic.setValue(reasonTextView.text, forKey: "reason")
        dic.setValue(models.count == 1 ? RecommendDetailOddsType.single.rawValue : RecommendDetailOddsType.serial.rawValue, forKey: "oddstype")
        dic.setValue(model1.mid, forKey: "mid")
        dic.setValue(betonWithModel(model: model1), forKey: "beton")
        dic.setValue(oddsDic(model: model1), forKey: "odds")
        if models.count == 2 {
            let model2 = models[1]
            dic.setValue(model2.mid, forKey: "mid2")
            dic.setValue(betonWithModel(model: model2), forKey: "beton2")
            dic.setValue(oddsDic(model: model2), forKey: "odds2")
        }
        let data = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
        let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) ?? ""
        
        postMatchBet(json: jsonString as String)
    }
}

// MARK: - Method
extension FBRecommendSponsorMatchJingcaiBetController {
    /// odds
    private func oddsDic(model: FBRecommendSponsorMatchModel) -> NSMutableDictionary {
        let odds = NSMutableDictionary()
        odds.setValue(String(format: "%d", model.odds.letBall), forKey: "letball")
        odds.setValue(model.odds.win.decimal(2), forKey: "win")
        odds.setValue(model.odds.draw.decimal(2), forKey: "draw")
        odds.setValue(model.odds.lost.decimal(2), forKey: "lost")
        odds.setValue(model.odds.letWin.decimal(2), forKey: "letwin")
        odds.setValue(model.odds.letDraw.decimal(2), forKey: "letdraw")
        odds.setValue(model.odds.letLost.decimal(2), forKey: "letlost")
        return odds
    }
    
    /// 用户选中的信息
    private func resultLabelText(model: FBRecommendSponsorMatchModel) -> String {
        var result = ""
        if model.selectedType.isWin {
            result = result + "胜(" + model.odds.win.decimal(2) + ")、"
        }
        if model.selectedType.isDraw {
            result = result + "平(" + model.odds.draw.decimal(2) + ")、"
        }
        if model.selectedType.isLost {
            result = result + "负(" + model.odds.lost.decimal(2) + ")、"
        }
        if model.selectedType.isLetWin {
            result = result + (model.odds.letBall > 0 ? String(format: "主+%d球 ", model.odds.letBall) : String(format: "主%d球 ", model.odds.letBall))
            result = result + "胜(" + model.odds.letWin.decimal(2) + ")、"
        }
        if model.selectedType.isLetDraw {
            result = result + (model.odds.letBall > 0 ? String(format: "主+%d球 ", model.odds.letBall) : String(format: "主%d球 ", model.odds.letBall))
            result = result + "平(" + model.odds.letDraw.decimal(2) + ")、"
        }
        if model.selectedType.isLetLost {
            result = result + (model.odds.letBall > 0 ? String(format: "主+%d球 ", model.odds.letBall) : String(format: "主%d球 ", model.odds.letBall))
            result = result + "负(" + model.odds.letLost.decimal(2) + ")、"
        }
        if !result.isEmpty {
            result.removeLast()
        }
        return result
    }
    
    private func betonWithModel(model: FBRecommendSponsorMatchModel) -> String {
        var result = ""
        if model.selectedType.isWin {
            result = result + String(format: "win=%.2f", model.odds.win) + ","
        }
        if model.selectedType.isDraw {
            result = result + String(format: "draw=%.2f", model.odds.draw) + ","
        }
        if model.selectedType.isLost {
            result = result + String(format: "lost=%.2f", model.odds.lost) + ","
        }
        if model.selectedType.isLetWin {
            result = result + String(format: "letwin=%.2f", model.odds.letWin) + ","
        }
        if model.selectedType.isLetDraw {
            result = result + String(format: "letdraw=%.2f", model.odds.letDraw) + ","
        }
        if model.selectedType.isLetLost {
            result = result + String(format: "letlost=%.2f", model.odds.letLost) + ","
        }
        if !result.isEmpty {
            result.removeLast()
        }
        return result
    }
    
    private func arrayWithModel(model: FBRecommendSponsorMatchModel) -> [Double] {
        var result = [Double]()
        if model.selectedType.isWin {
            result.append(model.odds.win)
        }
        if model.selectedType.isDraw {
            result.append(model.odds.draw)
        }
        if model.selectedType.isLost {
            result.append(model.odds.lost)
        }
        if model.selectedType.isLetWin {
            result.append(model.odds.letWin)
        }
        if model.selectedType.isLetDraw {
            result.append(model.odds.letDraw)
        }
        if model.selectedType.isLetLost {
            result.append(model.odds.letLost)
        }
        return result
    }
    
    
}






