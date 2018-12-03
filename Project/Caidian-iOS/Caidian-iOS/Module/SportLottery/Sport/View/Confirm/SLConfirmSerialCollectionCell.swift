//
//  SLConfirmSerialCollectionCell.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/25.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞技彩 确认投注 过关方式串关cell
class SLConfirmSerialCollectionCell: UICollectionViewCell {

    static let defaultHeight: CGFloat = 34
    
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var serialBtn: UIButton!
    @IBOutlet weak var checkedImageView: UIImageView!
    
    var serialBtnClickBlock: ((_ btn: UIButton, _ isChecked: Bool) -> Void)?
    
    /// 选中
    var isChecked: Bool = false {
        didSet {
            serialBtn.isSelected = isChecked
            checkedImageView.isHidden = !isChecked
            if isChecked {
                boxView.borderColor = UIColor.logo
            } else {
                boxView.borderColor = UIColor.grayGamut.gamut999999
            }
        }
    }
    
    @IBAction func serialBtnAction(_ sender: UIButton) {
        isChecked = !isChecked
        serialBtnClickBlock?(sender, isChecked)
    }
}
