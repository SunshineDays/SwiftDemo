//
//  PiazzaTopView.swift
//  IULiao
//
//  Created by levine on 2017/7/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class PiazzaTopView: UIView {

    //新闻中心 时间
    @IBAction func newsButtonAction(_ sender: UIButton) {
         pushNextViewController(ctrl: NewsTopicViewController())
    }
    
    //爆料
    @IBAction func brokenButtonAction(_ sender: UIButton) {
    
    }
    
    //指数中心
    @IBAction func centerButtonAction(_ sender: UIButton) {
        pushNextViewController(ctrl: R.storyboard.fbOdds.fbOddsMatchListViewController()!)
    }
    
    //必发指数
    @IBAction func betirButtonAction(_ sender: UIButton) {
        let ctrl = TSEntryViewControllerHelper.fbLeagueHomeViewController()
        pushNextViewController(ctrl: ctrl)
    }
    
    private func pushNextViewController(ctrl:UIViewController) {
        ctrl.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(ctrl, animated: true)
    }
}
