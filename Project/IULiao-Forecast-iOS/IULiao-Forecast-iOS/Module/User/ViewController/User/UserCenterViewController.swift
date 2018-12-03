//
//  UserCenterViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 我的
class UserCenterViewController: BaseTableViewController {
    
    @IBOutlet weak var titleHeaderView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    /// 料豆数量
    @IBOutlet weak var liaoNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData(_:)), name: UserNotification.userLoginSuccessful.notification, object: nil)
        initView()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initDataView()
    }
    
    override func refreshData() {
        initDataView()
    }
    
    private func initDataView() {
        if UserToken.shared.isLogin {
            initNetwork()
        } else {
            avatarImageView.image = R.image.user.avatar()
            nicknameLabel.text = "用户名"
            detailLabel.isHidden = true
            detailImageView.isHidden = true
            liaoNumberLabel.text = ""
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func titleInfoClick(_ sender: UIButton) {
        if UserToken.shared.isLogin {
            let vc = R.storyboard.userInfo.userInfo()!
            navigationController?.pushViewController(vc, animated: true)
        } else {
            NotificationCenter.default.post(name: UserNotification.userShouldLogin.notification, object: self)
        }
    }
}


// MARK:- method
extension UserCenterViewController {
    
    private func initView() {
        let themeView = UIView(frame: CGRect(x: 0, y: -1000, width: Screen.currentWidth, height: 1000))
        themeView.backgroundColor = UIColor.navigationBarTint
        tableView.addSubview(themeView)
        titleHeaderView.backgroundColor = UIColor.navigationBarTint
    }
    
    private func initTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
    
    private func initNetwork() {
        UserInfoHandler().detail(success: { (userInfoModel) in
            self.avatarImageView.sd_setImage(
                with: URL(string: ImageURLHelper(string: userInfoModel.user.avatar, w: 100, h: 100).chop().urlString),
                placeholderImage: R.image.user.avatar(), completed: nil)
            self.nicknameLabel.text = userInfoModel.user.nickname
            self.detailLabel.isHidden = false
            self.detailImageView.isHidden = false
            self.liaoNumberLabel.text = userInfoModel.account.coin.string
        }) { (error) in
            
        }
    }
    
}

extension UserCenterViewController {
    @objc private func refreshData(_ notification: Notification) {
        
    }
}


// MARK:- UITableViewDataSource
extension UserCenterViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            if UserToken.shared.isLogin {
                navigationController?.pushViewController(R.storyboard.userLiao.userLiaoController()!, animated: true)
            } else {
                NotificationCenter.default.post(name: UserNotification.userShouldLogin.notification, object: self)
            }
        case 1:
            let vc = R.storyboard.userSetting.userSetting()!
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
