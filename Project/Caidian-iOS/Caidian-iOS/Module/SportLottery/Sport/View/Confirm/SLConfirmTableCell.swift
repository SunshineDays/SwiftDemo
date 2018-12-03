//
//  SLBetTableCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/24.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol SLConfirmTableCellDelegate: class {
    
    /// 胆按钮点击
    func confirmTableCellMustBetButtonClick(_ cell: SLConfirmTableCell, isSelected: Bool)
    
    /// 删除按钮点击
    func confirmTableCellDeleteButtonClick(_ cell: SLConfirmTableCell)
}
/// 确认投注cell
class SLConfirmTableCell: UITableViewCell {

    @IBOutlet weak var leagueView: SLLeagueInfoView!
    @IBOutlet weak var teamView: SLTeamNameView!
    @IBOutlet weak var mustBetBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var betLabel: UILabel!
    
    private var betText = ""
    weak var delegate: SLConfirmTableCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rect = (betText as NSString).boundingRect(with: CGSize(width: betLabel.width, height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: betLabel.font], context: nil)
        
        // 一行居中 多行两端对齐
        if rect.height > 20 {
            betLabel.textAlignment = .justified
        } else {
            betLabel.textAlignment = .center
        }
    }
    
    func configCell<MatchModel: SLMatchModelProtocol, BetType: SLBetKeyProtocol>(combination: SLBuyModel<MatchModel, BetType>.MatchCombination, canSetMustBet: Bool = false) {
        
        configCell(isMustBet: combination.isMustBet, canSetMustBet: canSetMustBet)
        configMatch(match: combination.match, betKeyList: combination.betKeyList)
        configBetKeyList(betKeyList: combination.betKeyList)
    }
    
    func configCell(isMustBet: Bool, canSetMustBet: Bool)  {
        if isMustBet {
            mustBetBtn.isEnabled = true
            mustBetBtn.isSelected = isMustBet
        } else {
            mustBetBtn.isEnabled = canSetMustBet
            mustBetBtn.isSelected = false
        }
    }
    
    private func configMatch<MatchModel: SLMatchModelProtocol, BetType: SLBetKeyProtocol>(match: MatchModel, betKeyList: [BetType]) {
        var date = ""
        var weekday = ""
        var xid = ""
        if let match = match as? JczqMatchModel {
            // 如果有让球胜平负玩法则显示让球
            let isShowLetBall = betKeyList.contains(where: { $0.playType == .fb_rqspf })
            weekday = String(match.serial.prefix(2))
            xid = String(match.serial.suffix(3))
            date = Date(timeIntervalSince1970: match.matchTime).string(format: "MM-dd")
            teamView.configFootballView(homeName: match.home, awayName: match.away, letBall: isShowLetBall ? Int(match.letBall) : 0)
        }
        if let match = match as? JclqMatchModel {
            // 如果有让分胜负玩法则显示让球
            let isShowLetBall = betKeyList.contains(where: { $0.playType == .bb_rfsf })
            weekday = String(match.serial.prefix(2))
            xid = String(match.serial.suffix(3))
            date = Date(timeIntervalSince1970: match.matchTime).string(format: "MM-dd")
            teamView.configBasketballView(homeName: match.home, awayName: match.away, letScore: isShowLetBall ? match.letBall : 0)
        }
        leagueView.configView(date: date, weekday: weekday, xid: xid)
    }
    
    private func configBetKeyList<BetType: SLBetKeyProtocol>(betKeyList: [BetType]) {
        let str = betKeyList.map {
            "\($0.name)" + "(\($0.sp))"
        }.joined(separator: "，")
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 3
        let attr = NSAttributedString(string: str, attributes: [NSAttributedStringKey.paragraphStyle: paragraph])
        betLabel.attributedText = attr
        
        betText = str
    }
    
    @IBAction func mustBetBtnAction(_ sender: UIButton) {
        let isSelected = !sender.isSelected
        sender.isSelected = isSelected
        delegate?.confirmTableCellMustBetButtonClick(self, isSelected: isSelected)
    }
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
        delegate?.confirmTableCellDeleteButtonClick(self)
    }
}
