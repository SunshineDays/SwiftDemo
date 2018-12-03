//
//  JczqAllBetDialogViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/20.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩足球所有投注弹窗 代理
protocol JczqAllBetDialogViewControllerDelegate: class {
    
    /// 确定按钮点击
    func jczqAllBetDialogViewControllerConfirmButtonClick(_ ctrl: JczqAllBetDialogViewController, match: JczqMatchModel, betKeyList: [JczqBetKeyType])
    /// 取消按钮点击
    func jczqAllBetDialogViewControllerCancelButtonClick(_ ctrl: JczqAllBetDialogViewController)
}

/// 竞彩足球所有投注弹窗
class JczqAllBetDialogViewController: BaseViewController {
    
    @IBOutlet var betKeyBtnList: [UIButton]!
    
    @IBOutlet weak var spf_sp3Btn: UIButton!
    @IBOutlet weak var spf_sp1Btn: UIButton!
    @IBOutlet weak var spf_sp0Btn: UIButton!
    
    @IBOutlet weak var rqspf_sp3Btn: UIButton!
    @IBOutlet weak var rqspf_sp1Btn: UIButton!
    @IBOutlet weak var rqspf_sp0Btn: UIButton!
    
    @IBOutlet weak var jqs_sp0Btn: UIButton!
    @IBOutlet weak var jqs_sp1Btn: UIButton!
    @IBOutlet weak var jqs_sp2Btn: UIButton!
    @IBOutlet weak var jqs_sp3Btn: UIButton!
    @IBOutlet weak var jqs_sp4Btn: UIButton!
    @IBOutlet weak var jqs_sp5Btn: UIButton!
    @IBOutlet weak var jqs_sp6Btn: UIButton!
    @IBOutlet weak var jqs_sp7Btn: UIButton!
    
    @IBOutlet weak var bqc_sp00Btn: UIButton!
    @IBOutlet weak var bqc_sp01Btn: UIButton!
    @IBOutlet weak var bqc_sp03Btn: UIButton!
    @IBOutlet weak var bqc_sp10Btn: UIButton!
    @IBOutlet weak var bqc_sp11Btn: UIButton!
    @IBOutlet weak var bqc_sp13Btn: UIButton!
    @IBOutlet weak var bqc_sp30Btn: UIButton!
    @IBOutlet weak var bqc_sp31Btn: UIButton!
    @IBOutlet weak var bqc_sp33Btn: UIButton!
    
    @IBOutlet weak var bf_sp00Btn: UIButton!
    @IBOutlet weak var bf_sp01Btn: UIButton!
    @IBOutlet weak var bf_sp02Btn: UIButton!
    @IBOutlet weak var bf_sp03Btn: UIButton!
    @IBOutlet weak var bf_sp04Btn: UIButton!
    @IBOutlet weak var bf_sp05Btn: UIButton!
    @IBOutlet weak var bf_sp10Btn: UIButton!
    @IBOutlet weak var bf_sp11Btn: UIButton!
    @IBOutlet weak var bf_sp12Btn: UIButton!
    @IBOutlet weak var bf_sp13Btn: UIButton!
    @IBOutlet weak var bf_sp14Btn: UIButton!
    @IBOutlet weak var bf_sp15Btn: UIButton!
    @IBOutlet weak var bf_sp20Btn: UIButton!
    @IBOutlet weak var bf_sp21Btn: UIButton!
    @IBOutlet weak var bf_sp22Btn: UIButton!
    @IBOutlet weak var bf_sp23Btn: UIButton!
    @IBOutlet weak var bf_sp24Btn: UIButton!
    @IBOutlet weak var bf_sp25Btn: UIButton!
    @IBOutlet weak var bf_sp30Btn: UIButton!
    @IBOutlet weak var bf_sp31Btn: UIButton!
    @IBOutlet weak var bf_sp32Btn: UIButton!
    @IBOutlet weak var bf_sp33Btn: UIButton!
    @IBOutlet weak var bf_sp40Btn: UIButton!
    @IBOutlet weak var bf_sp41Btn: UIButton!
    @IBOutlet weak var bf_sp42Btn: UIButton!
    @IBOutlet weak var bf_sp50Btn: UIButton!
    @IBOutlet weak var bf_sp51Btn: UIButton!
    @IBOutlet weak var bf_sp52Btn: UIButton!
    
    @IBOutlet weak var bf_spA0Btn: UIButton!
    @IBOutlet weak var bf_spA1Btn: UIButton!
    @IBOutlet weak var bf_spA3Btn: UIButton!
    
    @IBOutlet weak var spfSingleImageView: UIImageView!
    @IBOutlet weak var rqspfSingleImageView: UIImageView!
    @IBOutlet weak var jqsSingleImageView: UIImageView!
    @IBOutlet weak var bqcSingleImageView: UIImageView!
    @IBOutlet weak var bfSingleImageView: UIImageView!
    
    @IBOutlet weak var spfFixedNotOpenLabel: UILabel!
    @IBOutlet weak var rqspfFixedNotOpenLabel: UILabel!
    @IBOutlet weak var jqsFixedNotOpenLabel: UILabel!
    @IBOutlet weak var bqcFixedNotOpenLabel: UILabel!
    @IBOutlet weak var bfFixedNotOpenLabel: UILabel!
    
    @IBOutlet weak var zeroLetBallLabel: UILabel!
    @IBOutlet weak var otherLetBallLabel: UILabel!
    
    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var awayNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var bfLabel: UILabel!
    @IBOutlet weak var spfView: UIView!
    @IBOutlet weak var jqsView: UIView!
    @IBOutlet weak var bqcView: UIView!
    
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bfViewTopConstraint: NSLayoutConstraint!
    
    var match: JczqMatchModel!
    var betKeyList: [JczqBetKeyType]!
    var playType = PlayType.hh
    weak var delegate: JczqAllBetDialogViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     return
        initView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var contentViewMaxHeight: CGFloat!
        if playType == .fb_bf {
            bfViewTopConstraint.constant = 10
            contentViewMaxHeight = CGFloat(40 + 38 * 7 + 2 * 10 + 40 + 1 / UIScreen.main.scale * 6)
        } else {
            bfViewTopConstraint.constant = CGFloat(38 * 6 + 4 * 10 + 1 / UIScreen.main.scale * 3)
            contentViewMaxHeight = CGFloat(40 + 38 * 13 + 5 * 10 + 40 + 1 / UIScreen.main.scale * 9)
        }
        let offset = (view.height - contentViewMaxHeight) / 2
        if offset > contentViewTopConstraint.constant {
            contentViewTopConstraint.constant = offset
            contentViewBottomConstraint.constant = offset
        }
    }

}

extension JczqAllBetDialogViewController {
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        delegate?.jczqAllBetDialogViewControllerCancelButtonClick(self)
    }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        delegate?.jczqAllBetDialogViewControllerConfirmButtonClick(self, match: match, betKeyList: betKeyList)
    }
}

extension JczqAllBetDialogViewController {
    
    /// 投注项被点击
    private func betKeyBtnAction(sender: UIButton, key: JczqBetKeyType) {
        let currentIsSelected = sender.isSelected
        if currentIsSelected {
            if let index = betKeyList.index(where: { $0 == key}) {
                betKeyList.remove(at: index)
            }
        } else {
            if !betKeyList.contains(where: { $0 == key }) {
                betKeyList.append(key)
            }
        }
        sender.isSelected = !currentIsSelected
    }
    
    private func initView() {
        
        homeNameLabel.text = match.home
        awayNameLabel.text = match.away
        
        // 玩法(隐藏内容)
        if playType == .fb_bf {
            spfView.isHidden = true
            jqsView.isHidden = true
            bqcView.isHidden = true
            bfLabel.isHidden = true
            scrollView.isScrollEnabled = false
        } else {
            scrollView.isScrollEnabled = true
        }
        
        // button2行文字居中
        for btn in betKeyBtnList {
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.textAlignment = .center
        }
        
        // 单关
        spfSingleImageView.isHidden = !match.spfSingle
        rqspfSingleImageView.isHidden = !match.rqspfSingle
        jqsSingleImageView.isHidden = !match.jqsSingle
        bqcSingleImageView.isHidden = !match.bqcSingle
        bfSingleImageView.isHidden = !match.bfSingle
        
        // 过关
        spfFixedNotOpenLabel.isHidden = match.spfFixed
        rqspfFixedNotOpenLabel.isHidden = match.rqspfFixed
        jqsFixedNotOpenLabel.isHidden = match.jqsFixed
        bqcFixedNotOpenLabel.isHidden = match.bqcFixed
        bfFixedNotOpenLabel.isHidden = match.bfFixed
        
        // 胜平负 固定过关
        if match.spfFixed {
            zeroLetBallLabel.text = "0"
        } else {
            zeroLetBallLabel.text = "-"
        }
        
        // 让球胜平负 固定过关
        if match.rqspfFixed {
            let letBall = Int(match.letBall)
            if letBall > 0 {
                otherLetBallLabel.text = "+\(letBall)"
                otherLetBallLabel.backgroundColor = UIColor.letBall.gt0
            } else if letBall < 0 {
                otherLetBallLabel.text = "\(letBall)"
                otherLetBallLabel.backgroundColor = UIColor.letBall.lt0
            }
        } else {
            otherLetBallLabel.text = "-"
            otherLetBallLabel.backgroundColor = UIColor.letBall.zero
        }
        
        // 过关
        
        // sp
        
        spf_sp3Btn.setTitle(match.spf_sp3.displayName, for: .normal)
        spf_sp1Btn.setTitle(match.spf_sp1.displayName, for: .normal)
        spf_sp0Btn.setTitle(match.spf_sp0.displayName, for: .normal)
        
        rqspf_sp3Btn.setTitle(match.rqspf_sp3.displayName, for: .normal)
        rqspf_sp1Btn.setTitle(match.rqspf_sp1.displayName, for: .normal)
        rqspf_sp0Btn.setTitle(match.rqspf_sp0.displayName, for: .normal)
        
        jqs_sp0Btn.setTitle(match.jqs_sp0.displayName, for: .normal)
        jqs_sp1Btn.setTitle(match.jqs_sp1.displayName, for: .normal)
        jqs_sp2Btn.setTitle(match.jqs_sp2.displayName, for: .normal)
        jqs_sp3Btn.setTitle(match.jqs_sp3.displayName, for: .normal)
        jqs_sp4Btn.setTitle(match.jqs_sp4.displayName, for: .normal)
        jqs_sp5Btn.setTitle(match.jqs_sp5.displayName, for: .normal)
        jqs_sp6Btn.setTitle(match.jqs_sp6.displayName, for: .normal)
        jqs_sp7Btn.setTitle(match.jqs_sp7.displayName, for: .normal)
        
        bqc_sp00Btn.setTitle(match.bqc_sp00.displayName, for: .normal)
        bqc_sp01Btn.setTitle(match.bqc_sp01.displayName, for: .normal)
        bqc_sp03Btn.setTitle(match.bqc_sp03.displayName, for: .normal)
        bqc_sp10Btn.setTitle(match.bqc_sp10.displayName, for: .normal)
        bqc_sp11Btn.setTitle(match.bqc_sp11.displayName, for: .normal)
        bqc_sp13Btn.setTitle(match.bqc_sp13.displayName, for: .normal)
        bqc_sp30Btn.setTitle(match.bqc_sp30.displayName, for: .normal)
        bqc_sp31Btn.setTitle(match.bqc_sp31.displayName, for: .normal)
        bqc_sp33Btn.setTitle(match.bqc_sp33.displayName, for: .normal)
        
        bf_sp00Btn.setTitle(match.bf_sp00.displayName, for: .normal)
        bf_sp01Btn.setTitle(match.bf_sp01.displayName, for: .normal)
        bf_sp02Btn.setTitle(match.bf_sp02.displayName, for: .normal)
        bf_sp03Btn.setTitle(match.bf_sp03.displayName, for: .normal)
        bf_sp04Btn.setTitle(match.bf_sp04.displayName, for: .normal)
        bf_sp05Btn.setTitle(match.bf_sp05.displayName, for: .normal)
        bf_sp10Btn.setTitle(match.bf_sp10.displayName, for: .normal)
        bf_sp11Btn.setTitle(match.bf_sp11.displayName, for: .normal)
        bf_sp12Btn.setTitle(match.bf_sp12.displayName, for: .normal)
        bf_sp13Btn.setTitle(match.bf_sp13.displayName, for: .normal)
        bf_sp14Btn.setTitle(match.bf_sp14.displayName, for: .normal)
        bf_sp15Btn.setTitle(match.bf_sp15.displayName, for: .normal)
        bf_sp20Btn.setTitle(match.bf_sp20.displayName, for: .normal)
        bf_sp21Btn.setTitle(match.bf_sp21.displayName, for: .normal)
        bf_sp22Btn.setTitle(match.bf_sp22.displayName, for: .normal)
        bf_sp23Btn.setTitle(match.bf_sp23.displayName, for: .normal)
        bf_sp24Btn.setTitle(match.bf_sp24.displayName, for: .normal)
        bf_sp25Btn.setTitle(match.bf_sp25.displayName, for: .normal)
        bf_sp30Btn.setTitle(match.bf_sp30.displayName, for: .normal)
        bf_sp31Btn.setTitle(match.bf_sp31.displayName, for: .normal)
        bf_sp32Btn.setTitle(match.bf_sp32.displayName, for: .normal)
        bf_sp33Btn.setTitle(match.bf_sp33.displayName, for: .normal)
        bf_sp40Btn.setTitle(match.bf_sp40.displayName, for: .normal)
        bf_sp41Btn.setTitle(match.bf_sp41.displayName, for: .normal)
        bf_sp42Btn.setTitle(match.bf_sp42.displayName, for: .normal)
        bf_sp50Btn.setTitle(match.bf_sp50.displayName, for: .normal)
        bf_sp51Btn.setTitle(match.bf_sp51.displayName, for: .normal)
        bf_sp52Btn.setTitle(match.bf_sp52.displayName, for: .normal)
        bf_spA3Btn.setTitle(match.bf_spA3.displayName, for: .normal)
        bf_spA1Btn.setTitle(match.bf_spA1.displayName, for: .normal)
        bf_spA0Btn.setTitle(match.bf_spA0.displayName, for: .normal)
        
        // 选中
        spf_sp3Btn.isSelected = betKeyList.contains(where: { $0 == match.spf_sp3})
        spf_sp1Btn.isSelected = betKeyList.contains(where: { $0 == match.spf_sp1})
        spf_sp0Btn.isSelected = betKeyList.contains(where: { $0 == match.spf_sp0})
        
        rqspf_sp3Btn.isSelected = betKeyList.contains(where: { $0 == match.rqspf_sp3})
        rqspf_sp1Btn.isSelected = betKeyList.contains(where: { $0 == match.rqspf_sp1})
        rqspf_sp0Btn.isSelected = betKeyList.contains(where: { $0 == match.rqspf_sp0})
        
        jqs_sp0Btn.isSelected = betKeyList.contains(where: { $0 == match.jqs_sp0})
        jqs_sp1Btn.isSelected = betKeyList.contains(where: { $0 == match.jqs_sp1})
        jqs_sp2Btn.isSelected = betKeyList.contains(where: { $0 == match.jqs_sp2})
        jqs_sp3Btn.isSelected = betKeyList.contains(where: { $0 == match.jqs_sp3})
        jqs_sp4Btn.isSelected = betKeyList.contains(where: { $0 == match.jqs_sp4})
        jqs_sp5Btn.isSelected = betKeyList.contains(where: { $0 == match.jqs_sp5})
        jqs_sp6Btn.isSelected = betKeyList.contains(where: { $0 == match.jqs_sp6})
        jqs_sp7Btn.isSelected = betKeyList.contains(where: { $0 == match.jqs_sp7})
        
        bqc_sp00Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp00})
        bqc_sp01Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp01})
        bqc_sp03Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp03})
        bqc_sp10Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp10})
        bqc_sp11Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp11})
        bqc_sp13Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp13})
        bqc_sp30Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp30})
        bqc_sp31Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp31})
        bqc_sp33Btn.isSelected = betKeyList.contains(where: { $0 == match.bqc_sp33})
        
        bf_sp00Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp00})
        bf_sp01Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp01})
        bf_sp02Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp02})
        bf_sp03Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp03})
        bf_sp04Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp04})
        bf_sp05Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp05})
        bf_sp10Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp10})
        bf_sp11Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp11})
        bf_sp12Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp12})
        bf_sp13Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp13})
        bf_sp14Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp14})
        bf_sp15Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp15})
        bf_sp20Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp20})
        bf_sp21Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp21})
        bf_sp22Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp22})
        bf_sp23Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp23})
        bf_sp24Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp24})
        bf_sp25Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp25})
        bf_sp30Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp30})
        bf_sp31Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp31})
        bf_sp32Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp32})
        bf_sp33Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp33})
        bf_sp40Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp40})
        bf_sp41Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp41})
        bf_sp42Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp42})
        bf_sp50Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp50})
        bf_sp51Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp51})
        bf_sp52Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_sp52})
        bf_spA0Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_spA0})
        bf_spA1Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_spA1})
        bf_spA3Btn.isSelected = betKeyList.contains(where: { $0 == match.bf_spA3})
    }
}

extension JczqAllBetDialogViewController {

    @IBAction func spf_sp3BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.spf_sp3)
    }
    @IBAction func spf_sp1BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.spf_sp1)
    }
    @IBAction func spf_sp0BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.spf_sp0)
    }
    
    @IBAction func rqspf_sp3BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.rqspf_sp3)
    }
    @IBAction func rqspf_sp1BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.rqspf_sp1)
    }
    @IBAction func rqspf_sp0BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.rqspf_sp0)
    }
    
    @IBAction func jqs_sp0BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.jqs_sp0)
    }
    @IBAction func jqs_sp1BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.jqs_sp1)
    }
    @IBAction func jqs_sp2BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.jqs_sp2)
    }
    @IBAction func jqs_sp3BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.jqs_sp3)
    }
    @IBAction func jqs_sp4BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.jqs_sp4)
    }
    @IBAction func jqs_sp5BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.jqs_sp5)
    }
    @IBAction func jqs_sp6BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.jqs_sp6)
    }
    @IBAction func jqs_sp7BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.jqs_sp7)
    }
    
    @IBAction func bqc_sp00BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp00)
    }
    @IBAction func bqc_sp01BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp01)
    }
    @IBAction func bqc_sp03BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp03)
    }
    @IBAction func bqc_sp10BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp10)
    }
    @IBAction func bqc_sp11BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp11)
    }
    @IBAction func bqc_sp13BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp13)
    }
    @IBAction func bqc_sp30BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp30)
    }
    @IBAction func bqc_sp31BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp31)
    }
    @IBAction func bqc_sp33BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bqc_sp33)
    }
    
    @IBAction func bf_sp00BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp00)
    }
    @IBAction func bf_sp01BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp01)
    }
    @IBAction func bf_sp02BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp02)
    }
    @IBAction func bf_sp03BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp03)
    }
    @IBAction func bf_sp04BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp04)
    }
    @IBAction func bf_sp05BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp05)
    }
    @IBAction func bf_sp10BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp10)
    }
    @IBAction func bf_sp11BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp11)
    }
    @IBAction func bf_sp12BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp12)
    }
    @IBAction func bf_sp13BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp13)
    }
    @IBAction func bf_sp14BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp14)
    }
    @IBAction func bf_sp15BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp15)
    }
    @IBAction func bf_sp20BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp20)
    }
    @IBAction func bf_sp21BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp21)
    }
    @IBAction func bf_sp22BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp22)
    }
    @IBAction func bf_sp23BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp23)
    }
    @IBAction func bf_sp24BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp24)
    }
    @IBAction func bf_sp25BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp25)
    }
    @IBAction func bf_sp30BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp30)
    }
    @IBAction func bf_sp31BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp31)
    }
    @IBAction func bf_sp32BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp32)
    }
    @IBAction func bf_sp33BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp33)
    }
    @IBAction func bf_sp40BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp40)
    }
    @IBAction func bf_sp41BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp41)
    }
    @IBAction func bf_sp42BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp42)
    }
    @IBAction func bf_sp50BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp50)
    }
    @IBAction func bf_sp51BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp51)
    }
    @IBAction func bf_sp52BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_sp52)
    }
    @IBAction func bf_spA3BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_spA3)
    }
    @IBAction func bf_spA1BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_spA1)
    }
    @IBAction func bf_spA0BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.bf_spA0)
    }
}
