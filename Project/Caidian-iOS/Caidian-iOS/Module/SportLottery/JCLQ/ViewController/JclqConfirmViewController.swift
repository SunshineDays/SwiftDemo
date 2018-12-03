//
//  JczqConfirmViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/25.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩篮球确认投注页
class JclqConfirmViewController: SLConfirmViewController<JclqMatchModel, JclqBetKeyType> {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
}

extension JclqConfirmViewController {
    
    private func initView() {
        title = "竞彩篮球"
        bottomViewHeight = SLConfirmBottomView.defaultTipLabelHeight + SLConfirmBottomView.defaultMultipleViewHeight + SLConfirmBottomView.defaultNextViewHeight
        bottomView.tipLabel.text = "竞彩篮球官方出票时间：周一/二/五 9:00~24:00\n周三/四 7:30~24:00 周六/日 9:00~次日1:00"
        bottomView.isHiddenTipLabel = false
        
        bottomView.multipleStepper.minimumValue = 1
        bottomView.multipleStepper.maximumValue = 9999
    }
}
