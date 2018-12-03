//
//  HomeSingleHotCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/19.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol HomeSingleHotCellDelegate: class {
    func homeSingleHotCell(_ cell: HomeSingleHotCell, betModel: SLBuyModel<JczqMatchModel, JczqBetKeyType>, didClickBetButton button: UIButton)
}

/// 首页 热门单关
class HomeSingleHotCell: UITableViewCell {

    @IBOutlet weak var homeLogoImageView: UIImageView!
    @IBOutlet weak var awayLogoImageView: UIImageView!
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var winView: UserRechargeMoneyView!
    @IBOutlet weak var drawView: UserRechargeMoneyView!
    @IBOutlet weak var lostView: UserRechargeMoneyView!
    
    @IBOutlet weak var money20View: UserRechargeMoneyView!
    @IBOutlet weak var money50View: UserRechargeMoneyView!
    @IBOutlet weak var money100View: UserRechargeMoneyView!
    
    @IBOutlet weak var betButton: UIButton!
    
    private var spViewArr = [UserRechargeMoneyView]()
    private var moneyViewArr = [UserRechargeMoneyView]()
    
    private var matchModel: JczqMatchModel?
    
    public weak var delegate: HomeSingleHotCellDelegate?
    
    public func configCell(match: JczqMatchModel) {
        matchModel = match
        initWithModel(match: match)
        money20View.isChecked = true
        money50View.isChecked = false
        money100View.isChecked = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension HomeSingleHotCell {
    private func initView() {
        spViewArr.append(winView)
        spViewArr.append(drawView)
        spViewArr.append(lostView)
        
        money20View.text = "20元"
        money50View.text = "50元"
        money100View.text = "100元"
        money20View.isChecked = true
        
        moneyViewArr.append(money20View)
        moneyViewArr.append(money50View)
        moneyViewArr.append(money100View)
        
        spViewArr.forEach {
            it in
            it.serialBtnClickBlock = {
                [weak self] btn, isChecked in
                self?.setSpView(spView: it)
            }
        }
        
        moneyViewArr.forEach { view in
            view.serialBtnClickBlock = {
                [weak self] btn, isChecked in
                self?.setMoneyView(moneyView: view)
            }
        }
    }
}

extension HomeSingleHotCell {
    private func initWithModel(match: JczqMatchModel) {
        homeLogoImageView.sd_setImage(with: TSImageURLHelper(string: match.homeLogo, w: 120, h: 120).url, placeholderImage: R.image.empty.image50x50())
        awayLogoImageView.sd_setImage(with: TSImageURLHelper(string: match.awayLogo, w: 120, h: 120).url, placeholderImage: R.image.empty.image50x50())
        
        leagueNameLabel.text = match.leagueName
        endTimeLabel.text = TSUtils.timestampToString(match.saleEndTime, withFormat: "MM-dd HH:mm", isIntelligent: false) + " 截止"
        
        if match.rqspfSingle {
            let minValue = [match.rqspf_sp3.sp, match.rqspf_sp1.sp, match.rqspf_sp0.sp].min()
            switch minValue {
            case match.rqspf_sp3.sp: setSpView(spView: winView)
            case match.rqspf_sp1.sp: setSpView(spView: drawView)
            default: setSpView(spView: lostView)
            }
            
            var letBallColor = UIColor.grayGamut.gamut333333
            var letBallString: String = ""
            let letBall = Int(match.letBall)
            
            if (letBall > 0) {
                letBallColor = UIColor.matchResult.win
                letBallString = "+\(letBall)"
            } else if (letBall < 0) {
                letBallString = "\(letBall)"
                letBallColor = UIColor.matchResult.lost
            } else {
                letBallString = ""
                letBallColor = UIColor.grayGamut.gamut333333
            }
            
            self.setLetBall(letBallColor: letBallColor, letBallString: "\n(\(letBallString)) ", label: winView, matchName: match.home, typeName: "胜", jczqBetKeyType: match.rqspf_sp3)
            self.setLetBall(letBallColor: letBallColor, letBallString: "(\(letBallString)) ", label: drawView, matchName: "", typeName: "平", jczqBetKeyType: match.rqspf_sp1)
            self.setLetBall(letBallColor: letBallColor, letBallString: "\n(\(letBallString)) ", label: lostView, matchName: match.away, typeName: "负", jczqBetKeyType: match.rqspf_sp0)
        } else {
            
            winView.text = "\(match.home)\n 胜 \(match.spf_sp3.sp.decimal(2))"
            drawView.text = "平 \(match.spf_sp1.sp.decimal(2))"
            lostView.text = "\(match.away)\n 负 \(match.spf_sp0.sp.decimal(2))"
            
            let minValue = [match.spf_sp3.sp, match.spf_sp1.sp, match.spf_sp0.sp].min()
            switch minValue {
            case match.spf_sp3.sp: setSpView(spView: winView)
            case match.spf_sp1.sp: setSpView(spView: drawView)
            default: setSpView(spView: lostView)
            }
        }
//        setSpView(spView: money20View)
    }
}

extension HomeSingleHotCell {
    /// 选中状态切换
    private func setSpView(spView: UserRechargeMoneyView) {
        spViewArr.forEach { view in
            view.isChecked = view == spView
        }
    }
    
    private func setMoneyView(moneyView: UserRechargeMoneyView) {
        moneyViewArr.forEach { view in
            view.isChecked = view == moneyView
        }
    }
    
    /// 立即投注
    @IBAction func betAction(_ sender: UIButton) {
        if let match = matchModel {
            let moneyAndSP = getTotalMoneyAndSP(match: match)
            let money = moneyAndSP.0
            let sp: JczqBetKeyType = moneyAndSP.1
            var buyModel = SLBuyModel<JczqMatchModel, JczqBetKeyType>()
            buyModel.lottery = .jczq
            buyModel.play = .hh
            buyModel.multiple = money / 2
            if let match = matchModel {
                buyModel.changeBetKey(match: match, key: sp)
            }
            delegate?.homeSingleHotCell(self, betModel: buyModel, didClickBetButton: sender)
        }
    }
}

extension HomeSingleHotCell {
    /// 获取今日单关焦点赛事的选中项和金额
    private func getTotalMoneyAndSP(match: JczqMatchModel) -> (Int, JczqBetKeyType) {
        let moneyView = moneyViewArr.first { view in
            view.isChecked
        }
        var money = 20
        switch moneyView {
        case money50View: money = 50
        case money100View: money = 100
        default: money = 20
        }
        
        let betView = spViewArr.first { view in
            view.isChecked
        }

        if match.rqspfSingle {
            switch betView {
            case winView: return (money, match.rqspf_sp3)
            case drawView:return (money, match.rqspf_sp1)
            default:return (money, match.rqspf_sp0)
            }
        } else {
            switch betView {
            case winView: return (money, match.spf_sp3)
            case drawView:return (money, match.spf_sp1)
            default:return (money, match.spf_sp0)
            }
        }
    }
}

extension HomeSingleHotCell {
    /**
     * letBallColor : 让球颜色
     * letBallString 让球显示的文字
     * label : View
     * matchName : 队名
     * typeName : 胜平负
     * jczqBetKeyType : 投注type
     */
    private func setLetBall(letBallColor: UIColor, letBallString: String, label: UserRechargeMoneyView, matchName: String, typeName: String, jczqBetKeyType: JczqBetKeyType) {
        
        /// 未点击时候的显示
        let attrStr = NSMutableAttributedString()
        attrStr.append(NSAttributedString(string: "\(matchName)", attributes: [:]))
        attrStr.append(NSAttributedString(string: letBallString, attributes: [NSAttributedStringKey.foregroundColor: letBallColor]))
        attrStr.append(NSAttributedString(string: "\(typeName) \(jczqBetKeyType.sp.decimal(2))", attributes: [:]))
        label.attributedNormalTitle = attrStr
        
        /// 选中到时候显示
        let attrFocusedStr = NSMutableAttributedString()
        attrFocusedStr.append(NSAttributedString(string: "\(matchName)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
        attrFocusedStr.append(NSAttributedString(string: letBallString, attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
        attrFocusedStr.append(NSAttributedString(string: "\(typeName) \(jczqBetKeyType.sp.decimal(2))", attributes: [NSAttributedStringKey.foregroundColor: UIColor.logo]))
        label.attributedFocusedTitle = attrFocusedStr
    }
}


