//
//  TSMainViewController2.swift
//  HuaXia
//
//  Created by tianshui on 16/3/3.
// 
//

import UIKit

/// 含有引导页的主入口
class TSMainViewController2: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainCtrl = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        let guideCtrl = UIStoryboard(name: "Guide", bundle: nil).instantiateInitialViewController() as! TSGuideViewController
        
        guideCtrl.enterBlock = {
            () -> Void in
            let version = Bundle.main.object(forInfoDictionaryKey: String(kCFBundleVersionKey)) as! String
            UserDefaults.standard.set(version, forKey: TSSettingKey.guideViewRunedVersion)
        }
    
        self.addChildViewController(mainCtrl!)
        self.view.addSubview(mainCtrl!.view)
        
        self.addChildViewController(guideCtrl)
        self.view.addSubview(guideCtrl.view)
        UIApplication.shared.isStatusBarHidden = true
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

}
