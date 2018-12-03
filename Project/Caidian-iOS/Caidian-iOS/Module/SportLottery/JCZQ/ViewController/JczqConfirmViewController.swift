//
//  JczqConfirmViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/25.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 竞彩足球确认投注页
class JczqConfirmViewController: SLConfirmViewController<JczqMatchModel, JczqBetKeyType> {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
}

extension JczqConfirmViewController {
    
    private func initView() {
        title = "竞彩足球"
        bottomViewHeight = SLConfirmBottomView.defaultTipLabelHeight + SLConfirmBottomView.defaultMultipleViewHeight + SLConfirmBottomView.defaultNextViewHeight
        bottomView.tipLabel.text = "竞彩足球官方出票时间：\n周一至周五9:00~24:00 周六/日9:00~次日1:00"
        bottomView.isHiddenTipLabel = false
        
        bottomView.multipleStepper.minimumValue = 1
        bottomView.multipleStepper.maximumValue = 9999
    }
}
