//
//  ForecastMatchButton.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/22.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 对阵投注项按钮
class ForecastMatchButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        /// 清除掉button的赋值，防止在xib中赋值导致按钮文字闪动
        setTitle(nil, for: .normal)
        backgroundColor = nil
        setBackgroundImage(nil, for: .normal)
        layer.cornerRadius = 3
        tintColor = UIColor.clear
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    /// 设置投注按钮
    ///
    /// - Parameters:
    ///   - model: ForecastMatchModel
    ///   - betKey: JczqBetKeyType（当前按钮的类型，为了方便，sp=0）
    public func config(matchModel model: ForecastMatchModel, buttonBetKey betKey: JczqBetKeyType, isPayed: Bool) {
        switch betKey {
        case .spf_sp3(sp: 0):
            
            setTitle("胜 " + model.spfSp3.decimal(2), for: .normal)
        case .spf_sp1(sp: 0):
            setTitle("平  " + model.spfSp1.decimal(2), for: .normal)
        case .spf_sp0(sp: 0):
            setTitle("负  " + model.spfSp0.decimal(2), for: .normal)
        case .rqspf_sp3(sp: 0):
            setTitle("胜  " + model.rqspfSp3.decimal(2), for: .normal)
        case .rqspf_sp1(sp: 0):
            setTitle("平  " + model.rqspfSp1.decimal(2), for: .normal)
        case .rqspf_sp0(sp: 0):
            setTitle("负  " + model.rqspfSp0.decimal(2), for: .normal)
        default:
            break
        }
        
        /// 支付/免费/已经开赛了 可以看投注项
        if isPayed || model.matchTime < Foundation.Date().timeIntervalSince1970 {
            var isBet = false
            for bet in model.beton {
                if bet.betKey == betKey {
                    isBet = true
                }
            }
            isBeton(isBet)
        } else {
            isBeton(false)
        }

        /// 如果有比分，显示比赛结果
        if !model.score.isEmpty {
            let homeScore = model.score.score.home
            let awayScore = model.score.score.away
            
            switch betKey {
            case .spf_sp3(sp: 0):
                isResult(homeScore > awayScore)
            case .spf_sp1(sp: 0):
                isResult(homeScore == awayScore)
            case .spf_sp0(sp: 0):
                isResult(homeScore < awayScore)
            case .rqspf_sp3(sp: 0):
                isResult(homeScore + model.letBall > awayScore)
            case .rqspf_sp1(sp: 0):
                isResult(homeScore + model.letBall == awayScore)
            case .rqspf_sp0(sp: 0):
                isResult(homeScore + model.letBall < awayScore)
            default:
                isResult(false)
            }
        } else {
            isResult(false)
        }
    }
}

extension ForecastMatchButton {

    /// 是否是投注项 红色背景
    private func isBeton(_ isBeton: Bool) {
        setTitleColor(isBeton ? UIColor.white : UIColor.colour.gamut4D4D4D, for: .normal)
        backgroundColor = isBeton ? UIColor.logo : UIColor.colour.gamutF5F5F5
    }
    
    /// 是否是比赛结果 图标(勾）
    private func isResult(_ isResult: Bool) {
        setBackgroundImage(isResult ? R.image.forecast.bet_selected() : nil, for: .normal)
    }
}


