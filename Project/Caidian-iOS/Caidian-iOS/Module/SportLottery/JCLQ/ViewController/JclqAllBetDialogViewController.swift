//
//  JclqAllBetDialogViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/20.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩足球所有投注弹窗 代理
protocol JclqAllBetDialogViewControllerDelegate: class {
    
    /// 确定按钮点击
    func jclqAllBetDialogViewControllerConfirmButtonClick(_ ctrl: JclqAllBetDialogViewController, match: JclqMatchModel, betKeyList: [JclqBetKeyType])
    /// 取消按钮点击
    func jclqAllBetDialogViewControllerCancelButtonClick(_ ctrl: JclqAllBetDialogViewController)
}

/// 竞彩足球所有投注弹窗
class JclqAllBetDialogViewController: BaseViewController {
    
    @IBOutlet var betKeyBtnList: [UIButton]!
    
    @IBOutlet weak var sf_sp3Btn: UIButton!
    @IBOutlet weak var sf_sp0Btn: UIButton!
    
    @IBOutlet weak var rfsf_sp3Btn: UIButton!
    @IBOutlet weak var rfsf_sp0Btn: UIButton!
    
    @IBOutlet weak var dxf_sp3Btn: UIButton!
    @IBOutlet weak var dxf_sp0Btn: UIButton!
    
    @IBOutlet weak var sfc_sp01Btn: UIButton!
    @IBOutlet weak var sfc_sp02Btn: UIButton!
    @IBOutlet weak var sfc_sp03Btn: UIButton!
    @IBOutlet weak var sfc_sp04Btn: UIButton!
    @IBOutlet weak var sfc_sp05Btn: UIButton!
    @IBOutlet weak var sfc_sp06Btn: UIButton!

    @IBOutlet weak var sfc_sp11Btn: UIButton!
    @IBOutlet weak var sfc_sp12Btn: UIButton!
    @IBOutlet weak var sfc_sp13Btn: UIButton!
    @IBOutlet weak var sfc_sp14Btn: UIButton!
    @IBOutlet weak var sfc_sp15Btn: UIButton!
    @IBOutlet weak var sfc_sp16Btn: UIButton!

    
    @IBOutlet weak var sfSingleImageView: UIImageView!
    @IBOutlet weak var rfsfSingleImageView: UIImageView!
    @IBOutlet weak var dxfSingleImageView: UIImageView!
    @IBOutlet weak var sfcSingleImageView: UIImageView!
    
    @IBOutlet weak var sfFixedNotOpenLabel: UILabel!
    @IBOutlet weak var rfsfFixedNotOpenLabel: UILabel!
    @IBOutlet weak var dxfFixedNotOpenLabel: UILabel!
    @IBOutlet weak var sfcFixedNotOpenLabel: UILabel!
    
    @IBOutlet weak var homeNameLabel: UILabel!
    @IBOutlet weak var awayNameLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var sfView: UIView!
    @IBOutlet weak var dxfView: UIView!
    
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sfcViewTopConstraint: NSLayoutConstraint!
    
    var match: JclqMatchModel!
    var betKeyList: [JclqBetKeyType]!
    var playType = PlayType.hh
    weak var delegate: JclqAllBetDialogViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var contentViewMaxHeight: CGFloat!
        if playType == .bb_sfc {
            sfcViewTopConstraint.constant = 10
            contentViewMaxHeight = CGFloat(40 + 40 * 4 + 2 * 10 + 40 + 1 / UIScreen.main.scale * 3)
        } else {
            sfcViewTopConstraint.constant = CGFloat(40 * 3 + 3 * 10 + 1 / UIScreen.main.scale * 1)
            contentViewMaxHeight = CGFloat(40 + 40 * 7 + 4 * 10 + 40 + 1 / UIScreen.main.scale * 4)
        }
        let offset = floor((view.height - ceil(contentViewMaxHeight)) / 2)
        if offset > contentViewTopConstraint.constant {
            contentViewTopConstraint.constant = offset
            contentViewBottomConstraint.constant = offset
        }
    }

}

extension JclqAllBetDialogViewController {
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        delegate?.jclqAllBetDialogViewControllerCancelButtonClick(self)
    }
    
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        delegate?.jclqAllBetDialogViewControllerConfirmButtonClick(self, match: match, betKeyList: betKeyList)
    }
}

extension JclqAllBetDialogViewController {
    
    /// 投注项被点击
    private func betKeyBtnAction(sender: UIButton, key: JclqBetKeyType) {
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
        
        homeNameLabel.text = "\(match.home)(主)"
        awayNameLabel.text = "\(match.away)(客)"
        
        // 玩法(隐藏内容)
        if playType == .bb_sfc {
            sfView.isHidden = true
            dxfView.isHidden = true
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
        sfSingleImageView.isHidden = !match.sfSingle
        rfsfSingleImageView.isHidden = !match.rfsfSingle
        dxfSingleImageView.isHidden = !match.dxfSingle
        sfcSingleImageView.isHidden = !match.sfcSingle
        
        // 过关
        sfFixedNotOpenLabel.isHidden = match.sfFixed
        rfsfFixedNotOpenLabel.isHidden = match.rfsfFixed
        dxfFixedNotOpenLabel.isHidden = match.dxfFixed
        sfcFixedNotOpenLabel.isHidden = match.sfcFixed
        
        // sp
        sf_sp3Btn.setTitle("主胜\n\(match.sf_sp3.sp.decimal(2))", for: .normal)
        sf_sp0Btn.setTitle("主负\n\(match.sf_sp0.sp.decimal(2))", for: .normal)
        
        let attr = NSMutableAttributedString()
        let letBall = match.letBall > 0 ? "+\(match.letBall)" : "\(match.letBall)"
        let sp3 = match.rfsf_sp3.sp.decimal(2)
        attr.append(NSAttributedString(string: "主胜"))
        attr.append(NSAttributedString(string: "(\(letBall))\n", attributes: [.foregroundColor: match.letBall > 0 ? UIColor.letBall.gt0 : UIColor.letBall.lt0]))
        attr.append(NSAttributedString(string: sp3))
        rfsf_sp3Btn.setAttributedTitle(attr, for: .normal)
        let selectedAttr = NSAttributedString(string: "主胜(\(letBall))\n\(sp3)", attributes: [.foregroundColor: UIColor.white])
        rfsf_sp3Btn.setAttributedTitle(selectedAttr, for: .highlighted)
        rfsf_sp3Btn.setAttributedTitle(selectedAttr, for: .selected)
        
        rfsf_sp0Btn.setTitle("主负\n\(match.rfsf_sp0.sp.decimal(2))", for: .normal)
        
        dxf_sp3Btn.setTitle("大于\(match.dxfNum)\n\(match.dxf_sp3.sp.decimal(2))", for: .normal)
        dxf_sp0Btn.setTitle("小于\(match.dxfNum)\n\(match.dxf_sp0.sp.decimal(2))", for: .normal)
        
        sfc_sp01Btn.setTitle("1-5\n\(match.sfc_sp01.sp.decimal(2))", for: .normal)
        sfc_sp02Btn.setTitle("6-10\n\(match.sfc_sp02.sp.decimal(2))", for: .normal)
        sfc_sp03Btn.setTitle("11-15\n\(match.sfc_sp03.sp.decimal(2))", for: .normal)
        sfc_sp04Btn.setTitle("16-20\n\(match.sfc_sp04.sp.decimal(2))", for: .normal)
        sfc_sp05Btn.setTitle("21-25\n\(match.sfc_sp05.sp.decimal(2))", for: .normal)
        sfc_sp06Btn.setTitle("26+\n\(match.sfc_sp06.sp.decimal(2))", for: .normal)
        
        sfc_sp11Btn.setTitle("1-5\n\(match.sfc_sp11.sp.decimal(2))", for: .normal)
        sfc_sp12Btn.setTitle("6-10\n\(match.sfc_sp12.sp.decimal(2))", for: .normal)
        sfc_sp13Btn.setTitle("11-15\n\(match.sfc_sp13.sp.decimal(2))", for: .normal)
        sfc_sp14Btn.setTitle("16-20\n\(match.sfc_sp14.sp.decimal(2))", for: .normal)
        sfc_sp15Btn.setTitle("21-25\n\(match.sfc_sp15.sp.decimal(2))", for: .normal)
        sfc_sp16Btn.setTitle("26+\n\(match.sfc_sp16.sp.decimal(2))", for: .normal)
        
        // 选中
        sf_sp3Btn.isSelected = betKeyList.contains(where: { $0 == match.sf_sp3 })
        sf_sp0Btn.isSelected = betKeyList.contains(where: { $0 == match.sf_sp0 })
        
        rfsf_sp3Btn.isSelected = betKeyList.contains(where: { $0 == match.rfsf_sp3 })
        rfsf_sp0Btn.isSelected = betKeyList.contains(where: { $0 == match.rfsf_sp0 })
        
        dxf_sp3Btn.isSelected = betKeyList.contains(where: { $0 == match.dxf_sp3 })
        dxf_sp0Btn.isSelected = betKeyList.contains(where: { $0 == match.dxf_sp0 })
        
        sfc_sp01Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp01 })
        sfc_sp02Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp02 })
        sfc_sp03Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp03 })
        sfc_sp04Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp04 })
        sfc_sp05Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp05 })
        sfc_sp06Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp06 })
        
        sfc_sp11Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp11 })
        sfc_sp12Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp12 })
        sfc_sp13Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp13 })
        sfc_sp14Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp14 })
        sfc_sp15Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp15 })
        sfc_sp16Btn.isSelected = betKeyList.contains(where: { $0 == match.sfc_sp16 })
    }
}

extension JclqAllBetDialogViewController {

    @IBAction func sf_sp3BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sf_sp3)
    }
    @IBAction func sf_sp0BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sf_sp0)
    }
    
    @IBAction func rfsf_sp3BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.rfsf_sp3)
    }
    @IBAction func rfsf_sp0BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.rfsf_sp0)
    }
    
    @IBAction func dxf_sp3BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.dxf_sp3)
    }
    @IBAction func dxf_sp0BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.dxf_sp0)
    }
    
    @IBAction func sfc_sp01BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp01)
    }
    @IBAction func sfc_sp02BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp02)
    }
    @IBAction func sfc_sp03BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp03)
    }
    @IBAction func sfc_sp04BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp04)
    }
    @IBAction func sfc_sp05BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp05)
    }
    @IBAction func sfc_sp06BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp06)
    }
    
    @IBAction func sfc_sp11BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp11)
    }
    @IBAction func sfc_sp12BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp12)
    }
    @IBAction func sfc_sp13BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp13)
    }
    @IBAction func sfc_sp14BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp14)
    }
    @IBAction func sfc_sp15BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp15)
    }
    @IBAction func sfc_sp16BtnAction(_ sender: UIButton) {
        betKeyBtnAction(sender: sender, key: match.sfc_sp16)
    }
    
}
