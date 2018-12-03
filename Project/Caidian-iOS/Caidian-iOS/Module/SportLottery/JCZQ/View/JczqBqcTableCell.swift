//
//  JczqBqcTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩足球 半全场
class JczqBqcTableCell: UITableViewCell, JczqTableCellProtocol {

    @IBOutlet var betKeyBtnList: [UIButton]!
    @IBOutlet weak var bqc_sp33Btn: UIButton!
    @IBOutlet weak var bqc_sp31Btn: UIButton!
    @IBOutlet weak var bqc_sp30Btn: UIButton!
    @IBOutlet weak var bqc_sp13Btn: UIButton!
    @IBOutlet weak var bqc_sp11Btn: UIButton!
    @IBOutlet weak var bqc_sp10Btn: UIButton!
    @IBOutlet weak var bqc_sp03Btn: UIButton!
    @IBOutlet weak var bqc_sp01Btn: UIButton!
    @IBOutlet weak var bqc_sp00Btn: UIButton!
    
    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    @IBOutlet weak var bqcOpenSingleImageView: UIImageView!
    
    @IBOutlet weak var statisticsView: JczpHistoryInfoView!
    @IBOutlet weak var showButton: UIButton!

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
        bqc_sp33Btn.setTitle(match.bqc_sp33.displayName, for: .normal)
        bqc_sp31Btn.setTitle(match.bqc_sp31.displayName, for: .normal)
        bqc_sp30Btn.setTitle(match.bqc_sp30.displayName, for: .normal)
        bqc_sp13Btn.setTitle(match.bqc_sp13.displayName, for: .normal)
        bqc_sp11Btn.setTitle(match.bqc_sp11.displayName, for: .normal)
        bqc_sp10Btn.setTitle(match.bqc_sp10.displayName, for: .normal)
        bqc_sp03Btn.setTitle(match.bqc_sp03.displayName, for: .normal)
        bqc_sp01Btn.setTitle(match.bqc_sp01.displayName, for: .normal)
        bqc_sp00Btn.setTitle(match.bqc_sp00.displayName, for: .normal)
        
        bqc_sp33Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp33 }
        bqc_sp31Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp31 }
        bqc_sp30Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp30 }
        bqc_sp13Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp13 }
        bqc_sp11Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp11 }
        bqc_sp10Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp10 }
        bqc_sp03Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp03 }
        bqc_sp01Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp01 }
        bqc_sp00Btn.isSelected = betKeyList.contains { $0 == match.bqc_sp00 }
    }
    
    /// 销售状态
    private func configSaleStatus(match: JczqMatchModel) {
        bqcOpenSingleImageView.isHidden = !match.jqsFixed
    }
    
    @IBAction func bqc_sp33BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp33 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func bqc_sp31BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp31 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func bqc_sp30BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp30 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func bqc_sp13BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp13 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func bqc_sp11BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp11 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func bqc_sp10BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp10 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func bqc_sp03BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp03 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func bqc_sp01BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp01 {
            sender.isSelected = !sender.isSelected
            betBtnActionBlock?(sender, key)
        }
    }
    @IBAction func bqc_sp00BtnAction(_ sender: UIButton) {
        if let key = matchModel?.bqc_sp00 {
            betBtnActionBlock?(sender, key)
        }
    }

}
