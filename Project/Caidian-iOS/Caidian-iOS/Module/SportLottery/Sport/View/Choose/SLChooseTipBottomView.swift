//
//  SLBetTipBottomView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/22.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

/// 竞技彩选择页底部 代理
protocol SLChooseTipBottomViewDelegate: class {
    
    /// 清除所有场次按钮点击
    func chooseTipBottomViewClearButtonClick(_ bottomView: SLChooseTipBottomView)
    
    /// 下一步按钮点击
    func chooseTipBottomViewNextButtonClick(_ bottomView: SLChooseTipBottomView)
}

/// 竞技彩选择页底部
class SLChooseTipBottomView: UIView {

    static let defaultHeight: CGFloat = 40
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var betCountLabel: UILabel!
    weak var delegate: SLChooseTipBottomViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {
        contentView = R.nib.slChooseTipBottomView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }

    public func configView(matchCount: Int) {
        let attrStr = NSMutableAttributedString()
        attrStr.append(NSAttributedString(string: "已选", attributes: [:]))
        attrStr.append(NSAttributedString(string: "\(matchCount)", attributes: [.foregroundColor: UIColor.logo]))
        attrStr.append(NSAttributedString(string: "场", attributes: [:]))
        betCountLabel.attributedText = attrStr
    }
    
    @IBAction func nextBtnAction(_ sender: UIButton) {
        delegate?.chooseTipBottomViewNextButtonClick(self)
    }
    
    @IBAction func clearBtnAction(_ sender: UIButton) {
        delegate?.chooseTipBottomViewClearButtonClick(self)
    }
}
