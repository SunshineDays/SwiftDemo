//
//  ForecastDetailMatchView.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/14.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 预测详情比赛对阵view
class ForecastDetailMatchView: UIView {
    
    
    @IBOutlet weak var bettButton: ForecastMatchButton!
    
    @IBOutlet weak var danImageView: UIImageView!
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var homeLogoImageView: UIImageView!
    @IBOutlet weak var homeLabel: UILabel!
    
    @IBOutlet weak var awayLogoImageView: UIImageView!
    @IBOutlet weak var awayLabel: UILabel!
    
    @IBOutlet weak var serialAndLeagueLabel: UILabel!
    @IBOutlet weak var openTimeLabel: UILabel!
    @IBOutlet weak var matchStateLabel: UILabel!
    
    @IBOutlet weak var letballLabel: UILabel!
    @IBOutlet weak var winButton: ForecastMatchButton!
    @IBOutlet weak var drawButton: ForecastMatchButton!
    @IBOutlet weak var lostButton: ForecastMatchButton!
    
    @IBOutlet weak var rLetballLabel: UILabel!
    @IBOutlet weak var rWinButton: ForecastMatchButton!
    @IBOutlet weak var rDrawButton: ForecastMatchButton!
    @IBOutlet weak var rLostButton: ForecastMatchButton!
    
    @IBOutlet weak var spfNotOpenLabel: UILabel!
    @IBOutlet weak var rqspfNotOpenLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = CGRect(x: 0, y: CGFloat(195 * showIndex), width: Screen.currentWidth, height: 195)
    }
    
    /// 初始化哪一个view(用于layoutSubviews)
    public var showIndex = 0
    /// 是否已经支付（未付款的也相当于支付了）
    public var isPayed = Bool()
    
    public var model: ForecastMatchModel! {
        didSet {
            congigView()
        }
    }
}

extension ForecastDetailMatchView {
    
    private func congigView() {
        resultImageView.image = model.result.image
        
        danImageView.isHidden = true
        /// 支付/免费/已经开赛了 可以看
        if isPayed || model.matchTime <= currentTime() {
            danImageView.isHidden = !model.isMustBet
        }
        
        homeLogoImageView.sd_setImage(
            with: URL(string: ImageURLHelper(string: model.homeLogo, w: 80, h: 80).chop().urlString),
            placeholderImage: R.image.empty.teamLogo(), completed: nil)
        homeLabel.text = model.home
        awayLogoImageView.sd_setImage(
            with: URL(string: ImageURLHelper(string: model.awayLogo, w: 80, h: 80).chop().urlString),
            placeholderImage: R.image.empty.teamLogo(), completed: nil)
        awayLabel.text = model.away
        
        serialAndLeagueLabel.text = model.serial + " " + model.leagueName
        openTimeLabel.text = model.matchTime.timeString()
        
        if model.matchTime > currentTime() {
            matchStateLabel.text = "未开赛"
        } else if !model.score.isEmpty {
            matchStateLabel.text = model.score.replacingOccurrences(of: ":", with: "-")
        } else {
            matchStateLabel.text = "未开奖"
        }
        
        rLetballLabel.text = model.letBall.letBallString
        winButton.config(matchModel: model, buttonBetKey: .spf_sp3(sp: 0), isPayed: isPayed)
        drawButton.config(matchModel: model, buttonBetKey: .spf_sp1(sp: 0), isPayed: isPayed)
        lostButton.config(matchModel: model, buttonBetKey: .spf_sp0(sp: 0), isPayed: isPayed)
        rWinButton.config(matchModel: model, buttonBetKey: .rqspf_sp3(sp: 0), isPayed: isPayed)
        rDrawButton.config(matchModel: model, buttonBetKey: .rqspf_sp1(sp: 0), isPayed: isPayed)
        rLostButton.config(matchModel: model, buttonBetKey: .rqspf_sp0(sp: 0), isPayed: isPayed)

        spfNotOpenLabel.isHidden = model.isSpfFixed
        rqspfNotOpenLabel.isHidden = model.isRqspfFixed
    }
}

extension ForecastDetailMatchView {
    
    /// 是否是投注项 红色背景
    private func buttonIsBeton(_ sender: UIButton, isBeton: Bool) {
        sender.setTitleColor(isBeton ? UIColor.white : UIColor.colour.gamut4D4D4D, for: .normal)
        sender.backgroundColor = isBeton ? UIColor.logo : UIColor.colour.gamutF5F5F5
    }
    
    /// 是否是比赛结果 图标(勾）
    private func buttonIsResult(_ sender: UIButton, isResult: Bool) {
        sender.setBackgroundImage(isResult ? R.image.forecast.bet_selected() : nil, for: .normal)
    }
    
    /// 获取当前时间戳
    private func currentTime() -> TimeInterval {
        return Foundation.Date().timeIntervalSince1970
    }
}




