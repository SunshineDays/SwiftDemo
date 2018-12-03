//
//  FBLeagueHomeContinentViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/10/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 资料库首页 大洲
class FBLeagueHomeContinentViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    var continent: FBLeagueHomeDataModel.Continent!
    
    private var viewControllerCaches = [Int: UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        setupViewController(index: sender.selectedSegmentIndex)
    }
}

extension FBLeagueHomeContinentViewController {
    
    private func initView() {
        setupViewController(index: 0)
    }
    
    private func setupViewController(index: Int) {
        if let cacheCtrl = viewControllerCaches[index] {
            contentView.bringSubview(toFront: cacheCtrl.view)
            return
        }
        
        var ctrl: UIViewController!
        if index == 0 {
            let vc = R.storyboard.fbLeagueHome.fbLeagueHomeCountryViewController()!
            vc.leagueCountry = continent.countries ?? []
            ctrl = vc
        } else {
            let vc = R.storyboard.fbLeagueHome.fbLeagueHomeRegionViewController()!
            vc.leagueList = continent.regionLeagues
            ctrl = vc
        }
        addChildViewController(ctrl)
        contentView.addSubview(ctrl.view)
        ctrl.view.snp.makeConstraints {
            make in
            make.edges.equalTo(contentView)
        }
        viewControllerCaches[index] = ctrl
    }
}
