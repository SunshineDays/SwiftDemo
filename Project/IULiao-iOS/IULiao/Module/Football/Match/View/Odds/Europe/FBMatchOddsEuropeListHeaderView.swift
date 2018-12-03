//
//  FBMatchOddsEuropeListHeaderView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/11.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 指数 欧赔头部
class FBMatchOddsEuropeListHeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var initOddsBtn: UIButton!
    @IBOutlet weak var probabilityBtn: UIButton!
    @IBOutlet weak var kellyBtn: UIButton!
    @IBOutlet weak var jingcaiBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize.zero
    }
    
    var btnClickBlock: ((_ button: UIButton, _ cellType: FBMatchOddsEuropeListViewController.CellType) -> Void)?
    
    func configView(cellType: FBMatchOddsEuropeListViewController.CellType) {
        initOddsBtn.isSelected = false
        probabilityBtn.isSelected = false
        kellyBtn.isSelected = false
        jingcaiBtn.isSelected = false
        
        initOddsBtn.borderColor = TSColor.gray.gamut333333
        probabilityBtn.borderColor = TSColor.gray.gamut333333
        kellyBtn.borderColor = TSColor.gray.gamut333333
        jingcaiBtn.borderColor = TSColor.gray.gamut333333
        
        if cellType == .initOdds {
            initOddsBtn.isSelected = true
            initOddsBtn.borderColor = TSColor.logo
        } else if cellType == .probability {
            probabilityBtn.isSelected = true
            probabilityBtn.borderColor = TSColor.logo
        } else if cellType == .kelly {
            kellyBtn.isSelected = true
            kellyBtn.borderColor = TSColor.logo
        } else if cellType == .jingcai {
            jingcaiBtn.isSelected = true
            jingcaiBtn.borderColor = TSColor.logo
        }
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        var cellType = FBMatchOddsEuropeListViewController.CellType.probability
        if sender == initOddsBtn {
           cellType = .initOdds
        } else if sender == probabilityBtn {
            cellType = .probability
        } else if sender == kellyBtn {
            cellType = .kelly
        } else if sender == jingcaiBtn {
            cellType = .jingcai
        }
        configView(cellType: cellType)
        btnClickBlock?(sender, cellType)
    }
}
