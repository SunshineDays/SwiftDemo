//
//  NLChooseTipBottomView.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/18.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 数字彩选择页底部
class NLChooseTipBottomView: UIView {

    static let defaultHeight: CGFloat = 40
    
    @IBOutlet var contentView: UIView!
    
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
        contentView = R.nib.nlChooseTipBottomView().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
}
