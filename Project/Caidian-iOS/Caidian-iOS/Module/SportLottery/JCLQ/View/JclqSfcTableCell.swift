//
//  JclqBfTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩篮球 胜分差
class JclqSfcTableCell: UITableViewCell, JclqTableCellProtocol {

    @IBOutlet weak var sfcOpenSingleImageView: UIImageView!
    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    @IBOutlet weak var moreBtn: UIButton!
    
    static let defaultHeight: CGFloat = 92 // 8 + 34 + 35 + 15
    
    private var matchModel: JclqMatchModel?
    public var moreBtnActionBlock: ((_ btn: UIButton) -> Void)?
    public var betBtnActionBlock: ((_ btn: UIButton, _ bet: JclqBetKeyType) -> Void)?

    public func configCell(match: JclqMatchModel, betKeyList: [JclqBetKeyType]) {
        matchModel = match
        
        // 单关
        sfcOpenSingleImageView.isHidden = !match.sfcSingle
        
        configSp(match: match, betKeyList: betKeyList)
        
        let date = "\(Date(timeIntervalSince1970: match.saleEndTime).string(format: "HH:mm")) 截止"
        leagueView.configView(serial: match.serial, leagueName: match.leagueName, color: match.color, date: date)
        teamView.configBasketballView(homeName: match.home, awayName: match.away)
    }
    
    /// sp
    private func configSp(match: JclqMatchModel, betKeyList: [JclqBetKeyType]) {
        if betKeyList.count > 0 {
            moreBtn.borderColor = UIColor.logo
            let title = betKeyList.map { $0.name }.joined(separator: "，")
            moreBtn.setTitle(title, for: .normal)
            moreBtn.setTitleColor(UIColor.logo, for: .normal)
        } else {
            moreBtn.borderColor = UIColor.lightGray
            moreBtn.setTitle("点击选择胜负差投注", for: .normal)
            moreBtn.setTitleColor(UIColor.grayGamut.gamut333333, for: .normal)
        }
    }
    
    @IBAction func moreBtnAction(_ sender: UIButton) {
        moreBtnActionBlock?(sender)
    }
}
