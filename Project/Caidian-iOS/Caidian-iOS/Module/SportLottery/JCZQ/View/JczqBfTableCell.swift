//
//  JczqBfTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩足球比分
class JczqBfTableCell: UITableViewCell, JczqTableCellProtocol {

    @IBOutlet weak var bfOpenSingleImageView: UIImageView!
    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var statisticsView: JczpHistoryInfoView!
    @IBOutlet weak var showButton: UIButton!

    @IBAction func showAction(_ sender: UIButton) {
        showBlock?(sender)
    }
    public var showBlock: ((_ sender: UIButton) -> Void)?
    
    static let defaultHeight: CGFloat = 78 + 15
    
    private var matchModel: JczqMatchModel?
    public var moreBtnActionBlock: ((_ btn: UIButton) -> Void)?
    public var betBtnActionBlock: ((_ btn: UIButton, _ bet: JczqBetKeyType) -> Void)?

    public func configCell(match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        matchModel = match
        
        // 单关
        bfOpenSingleImageView.isHidden = !match.bfSingle
        
        configSp(match: match, betKeyList: betKeyList)
        
        let date = "\(Date(timeIntervalSince1970: match.saleEndTime).string(format: "HH:mm")) 截止"
        leagueView.configView(serial: match.serial, leagueName: match.leagueName, color: match.color, date: date)
        teamView.configFootballView(homeName: match.home, awayName: match.away)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showButton.setImage(R.image.bet.serialArrowDown(), for: .normal)
        showButton.setImage(R.image.bet.serialArrowUp(), for: .selected)
    }
    
    /// sp
    private func configSp(match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        if betKeyList.count > 0 {
            moreBtn.borderColor = UIColor.logo
            let title = betKeyList.map { $0.name }.joined(separator: "，")
            moreBtn.setTitle(title, for: .normal)
            moreBtn.setTitleColor(UIColor.logo, for: .normal)
        } else {
            moreBtn.borderColor = UIColor.lightGray
            moreBtn.setTitle("点击选择比分投注", for: .normal)
            moreBtn.setTitleColor(UIColor.grayGamut.gamut333333, for: .normal)
        }
    }
    
    @IBAction func moreBtnAction(_ sender: UIButton) {
        moreBtnActionBlock?(sender)
    }
}
