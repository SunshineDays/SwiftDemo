//
//  ViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/9/23.
// 
//

import UIKit
import SwiftyJSON

/// 主tabbar
class TSMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initListener()

#if DEBUG
        let displayMode = UserDefaults.standard.string(forKey: TSSettingKey.debugDisplayMode) ?? "develop"
        if displayMode == "production" {
            production()
        } else {
//            development()
            production()
        }
#else
        production()
#endif

    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK:- method
extension TSMainViewController {

    func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(TSMainViewController.showLoginViewController), name: TSNotification.userShouldLogin.notification, object: nil)
    }

    func production() {

        let piazzaNavCtrl = R.storyboard.piazza.piazzaNav()!
        let liveNavCtrl = R.storyboard.fbLive2.liveNav()!
        let recommendNavCtrl = BaseNavigationController(rootViewController: FBRecommend2HomePageController())
        let liaoNavCtrl = R.storyboard.fbLiao.liaoNav()!
        let userNavCtrl = R.storyboard.user.userNav()!

        piazzaNavCtrl.tabBarItem = UITabBarItem(title: "广场", image: R.image.tabBar.piazza(), selectedImage: R.image.tabBar.piazzaS())
        liveNavCtrl.tabBarItem = UITabBarItem(title: "比分", image: R.image.tabBar.live(), selectedImage: R.image.tabBar.liveS())
        recommendNavCtrl.tabBarItem = UITabBarItem(title: "推荐", image: R.image.tabBar.recommend(), selectedImage: R.image.tabBar.recommendS())
        liaoNavCtrl.tabBarItem = UITabBarItem(title: "爆料", image: R.image.tabBar.liao(), selectedImage: R.image.tabBar.liaoS())
        userNavCtrl.tabBarItem = UITabBarItem(title: "我的", image: R.image.tabBar.user(), selectedImage: R.image.tabBar.userS())

        tabBar.tintColor = baseNavigationBarTintColor
        
        func isShowText(_ isText: Bool) {
            if isText {
                self.viewControllers = [piazzaNavCtrl, liveNavCtrl, liaoNavCtrl, userNavCtrl]
            } else {
                self.viewControllers = [piazzaNavCtrl, liveNavCtrl, recommendNavCtrl, liaoNavCtrl, userNavCtrl]
            }
            self.selectedIndex = 1
            UserDefaults.standard.set(isText, forKey: TSSettingKey.isText)
            UserDefaults.standard.synchronize()
        }
        
        /// 最新版本才有可能是在App Store测试阶段
        if TSAppInfoHelper.appVersion == "2407" {
            let handler = JudgeIsTextHandler()
            handler.getJudgeIsTextData(success: { (model) in
                /// 根据后台的信息是否隐藏推荐板块
                isShowText(!model.show)
            }) { (error) in
                isShowText(false)
            }
        } else {
            isShowText(false)
        }
    }
    
    func development() {

        let piazzaNavCtrl = R.storyboard.piazza.piazzaNav()!
        let liveNavCtrl = R.storyboard.fbLive2.liveNav()!
        let recommendNavCtrl = BaseNavigationController(rootViewController: FBRecommend2HomePageController())
        let leagueNavCtrl = R.storyboard.fbLeagueHome.leagueNav()!
        let userNavCtrl = R.storyboard.user.userNav()!

        let matchCtrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: 1100135, lottery: .jingcai)

        piazzaNavCtrl.tabBarItem = UITabBarItem(title: "广场", image: R.image.tabBar.piazza(), selectedImage: R.image.tabBar.piazzaS())
        liveNavCtrl.tabBarItem = UITabBarItem(title: "比分", image: R.image.tabBar.live(), selectedImage: R.image.tabBar.liveS())
        recommendNavCtrl.tabBarItem = UITabBarItem(title: "推荐", image: R.image.tabBar.recommend(), selectedImage: R.image.tabBar.recommendS())
        leagueNavCtrl.tabBarItem = UITabBarItem(title: "资料库", image: R.image.tabBar.liao(), selectedImage: R.image.tabBar.liaoS())

        userNavCtrl.tabBarItem = UITabBarItem(title: "我的", image: R.image.tabBar.user(), selectedImage: R.image.tabBar.userS())

        tabBar.tintColor = baseNavigationBarTintColor
        viewControllers = [piazzaNavCtrl, liveNavCtrl, recommendNavCtrl, matchCtrl, userNavCtrl]
        selectedIndex = 1
    }

}

// MARK:- notification
extension TSMainViewController {

    /// 显示登录页
    @objc func showLoginViewController() {
        /// 删除极光别名
        let seq = random(min: 10_000_000, max: 99_999_999)
        JPUSHService.deleteAlias({
            (iResCode, iAlias, seq) in
            log.info("删除别名成功")
        }, seq: seq)
        
        let ctrl = UIStoryboard(name: "UserLogin", bundle: nil).instantiateInitialViewController()
        self.selectedViewController?.present(ctrl!, animated: true, completion: nil)
    }


    /// 推送
    func didReceiveRemoteNotification(_ notify: Notification) {
        guard let userInfo = (notify as NSNotification).userInfo else {
            return
        }
        let helper = TSNotificationHelper(apnsUserInfo: userInfo as [NSObject: AnyObject])

        func pushToViewController() {

        }

        if helper.applicationState == .inactive || helper.applicationState == .background || helper.isLaunched {
            pushToViewController()
        } else {
            TSToast.showNotificationWithTitle("点击查看", message: helper.alertMessage, duration: nil, tapBlock: {
                type in
                pushToViewController()
            })
        }
    }
}


class JudgeIsTextHandler: BaseHandler {
    func getJudgeIsTextData(success: @escaping (JudgeIsTextModel) -> Void, failed: @escaping FailedBlock) {
        let router = TSRouter.judgeIsText
        defaultRequestManager.requestWithRouter(router, expires: 0, success: { (json) in
            DispatchQueue.global().async {
                
                var list = [JudgeIsTextModel]()
                for listJson in json.arrayValue {
                    list.append(JudgeIsTextModel(json: listJson))
                    print(listJson)
                }
                
                for l in list {
                    if l.module == "recommend" {
                        DispatchQueue.main.async {
                            success(l)
                        }
                        break
                    } else {
                        break
                    }
                }
            }
        }) { (error) -> Bool in
            failed(error)
            return false
        }
    }
}

class JudgeIsTextModel: BaseModelProtocol {
    var json: JSON
    
    var show: Bool
    
    var platform: String
    
    var module: String
    
    var comment: String
    
    required init(json: JSON) {
        self.json = json
        show = json["show"].intValue == 0 ? false : true
        platform = json["platform"].stringValue
        module = json["module"].stringValue
        comment = json["comment"].stringValue
    }
}
