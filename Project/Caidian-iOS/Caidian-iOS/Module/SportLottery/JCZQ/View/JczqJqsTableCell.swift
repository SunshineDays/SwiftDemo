//
//  JczqJqsTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/2.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩足球 进球数
class JczqJqsTableCell: UITableViewCell, JczqTableCellProtocol {
    
    @IBOutlet var betKeyBtnList: [UIButton]!
    @IBOutlet weak var jqs_sp0Btn: UIButton!
    @IBOutlet weak var jqs_sp1Btn: UIButton!
    @IBOutlet weak var jqs_sp2Btn: UIButton!
    @IBOutlet weak var jqs_sp3Btn: UIButton!
    @IBOutlet weak var jqs_sp4Btn: UIButton!
    @IBOutlet weak var jqs_sp5Btn: UIButton!
    @IBOutlet weak var jqs_sp6Btn: UIButton!
    @IBOutlet weak var jqs_sp7Btn: UIButton!
    
    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    @IBOutlet weak var jqsOpenSingleImageView: UIImageView!
    
    @IBOutlet weak var showButton: UIButton!
    
    @IBOutlet weak var statisticsView: JczpHistoryInfoView!
    
    @IBAction func showAction(_ sender: UIButton) {
        showBlock?(sender)
    }
    public var showBlock: ((_ sender: UIButton) -> Void)?
    
    private var matchModel: JczqMatchModel?
    static var defaultHeight: CGFloat = 106 + 15
    
    var betBtnActionBlock: ((UIButton, JczqBetKeyType) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        showButton.setImage(R.image.lottery.show_down(), for: .normal)
        showButton.setImage(R.image.lottery.show_up(), for: .selected)
        // button2行文字居中
        for btn in betKeyBtnList {
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.textAlignment = .center
        }
    }

    func configCell(match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        matchModel = match
        
        configSp(match: match, betKeyList: betKeyList)
        configSaleStatus(match: match)
        
        let date = "\(Date(timeIntervalSince1970: match.saleEndTime).string(format: "HH:mm")) 截止"
        leagueView.configView(serial: match.serial, leagueName: match.leagueName, color: match.color, date: date)
        teamView.configFootballView(homeName: match.home, awayName: match.away)
    }
    
    /// sp
    private func configSp(match: JczqMatchModel, betKeyList: [JczqBetKeyType]) {
        jqs_sp0Btn.setTitle(match.jqs_sp0.displayName, for: .normal)
        jqs_sp1Btn.setTitle(match.jqs_sp1.displayName, for: .normal)
        jqs_sp2Btn.setTitle(match.jqs_sp2.displayName, for: .normal)
        jqs_sp3Btn.setTitle(match.jqs_sp3.displayName, for: .normal)
        jqs_sp4Btn.setTitle(match.jqs_sp4.displayName, for: .normal)
        jqs_sp5Btn.setTitle(match.jqs_sp5.displayName, for: .normal)
        jqs_sp6Btn.setTitle(match.jqs_sp6.displayName, for: .normal)
        jqs_sp7Btn.setTitle(match.jqs_sp7.displayName, for: .normal)
        
        jqs_sp0Btn.isSelected = betKeyList.contains { $0 == match.jqs_sp0 }
        jqs_sp1Btn.isSelected = betKeyList.contains { $0 == match.jqs_sp1 }
        jqs_sp2Btn.isSelected = betKeyList.contains { $0 == match.jqs_sp2 }
        jqs_sp3Btn.isSelected = betKeyList.contains { $0 == match.jqs_sp3 }
        jqs_sp4Btn.isSelected = betKeyList.contains { $0 == match.jqs_sp4 }
        jqs_sp5Btn.isSelected = betKeyList.contains { $0 == match.jqs_sp5 }
        jqs_sp6Btn.isSelected = betKeyList.contains { $0 == match.jqs_sp6 }
        jqs_sp7Btn.isSelected = betKeyList.contains { $0 == match.jqs_sp7 }
    }
    
    /// 销售状态
    private func configSaleStatus(match: JczqMatchModel) {
        jqsOpenSingleImageView.isHidden = !match.jqsFixed
    }
    
    @IBAction func jqs_sp0BtnAction(_ sender: UIButton) {
        if let key = matchModel?.jqs_sp0 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func jqs_sp1BtnAction(_ sender: UIButton) {
        if let key = matchModel?.jqs_sp1 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func jqs_sp2BtnAction(_ sender: UIButton) {
        if let key = matchModel?.jqs_sp2 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func jqs_sp3BtnAction(_ sender: UIButton) {
        if let key = matchModel?.jqs_sp3 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func jqs_sp4BtnAction(_ sender: UIButton) {
        if let key = matchModel?.jqs_sp4 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func jqs_sp5BtnAction(_ sender: UIButton) {
        if let key = matchModel?.jqs_sp5 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func jqs_sp6BtnAction(_ sender: UIButton) {
        if let key = matchModel?.jqs_sp6 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func jqs_sp7BtnAction(_ sender: UIButton) {
        if let key = matchModel?.jqs_sp7 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
}
