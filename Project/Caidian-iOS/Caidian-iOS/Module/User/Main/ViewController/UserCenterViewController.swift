//
//  UserCenterViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/6/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户中心 已登录
class UserCenterViewController: BaseTableViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet var fixedButtons: [UIButton]!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var rewardLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var bindBankLabel: UILabel!

    private var userInfoHandle = UserInfoHandler()
    var userInfo: UserInfoModel? {
        didSet {
            guard let userInfo = userInfo else {
                return
            }

            nicknameLabel.text = userInfo.nickname

            genderImageView.isHidden = userInfo.gender == .none
            genderImageView.image = userInfo.gender == .female ? R.image.user.infoGenderFemale() : R.image.user.infoGenderMale()

            if let url = userInfo.avatar {
                let urlString = URL(string: TSImageURLHelper(string: url, size: CGSize(width: 160, height: 160)).chop().urlString)
                avatarImageView.sd_setImage(with: urlString, placeholderImage: R.image.user.noAvatar(), options: [.retryFailed, .progressiveDownload], completed: nil)
            }

            phoneLabel.text = userInfo.secretPhone

            realNameLabel.text = userInfo.isRealName ? "已实名" : "未实名"
            bindBankLabel.text = userInfo.isBindBank ? "已绑定" : "未绑定"
        }
    }
    var userAccount: UserAccountModel? {
        didSet {
            guard let userAccount = userAccount else {
                return
            }
            totalMoneyLabel.text = "\((userAccount.balance + userAccount.reward).decimal(2))"
            balanceLabel.text = "余额：\(userAccount.balance.decimal(2))"
            rewardLabel.text = "彩金：\(userAccount.reward.decimal(2))"
            UserToken.shared.update(userAccount: userAccount)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        TSToast.showLoading(view: view)

        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case R.segue.userCenterViewController.userPutForwardSegue.identifier:
            if userInfo!.isBindBank {
                return true
            } else {
                let alert = UIAlertController(title: "需要绑定银行卡", message: "", preferredStyle: .alert)
                let ok = UIAlertAction(title: "去绑定", style: .destructive) {
                    action in
                    let ctrl = R.storyboard.userInfo.userBindingBankController()!
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }
                let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alert.addAction(ok)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)

                return false
            }
        case R.segue.userCenterViewController.userBindBankSegue.identifier:
//             R.segue.userCenterViewController.userRechargeSegue.identifier:
            if userInfo!.isRealName {
                return true
            } else {

                let alert = UIAlertController(title: "需要实名认证", message: "", preferredStyle: .alert)
                let ok = UIAlertAction(title: "去认证", style: .destructive) {
                    action in
                    let ctrl = R.storyboard.userInfo.userRealNameAuthenticationController()!
                    self.navigationController?.pushViewController(ctrl, animated: true)
                }
                let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alert.addAction(ok)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
                return false
            }
        default: return true
        }


    }

    override func viewWillAppear(_ animated: Bool) {
        let navbarImageV = self.findHairlineImageViewUnder(view: (navigationController?.navigationBar)!)
        navbarImageV?.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
        refreshData()
    }
    
    @objc private func refreshData() {
        ///实时更新 用户数据
        userInfoHandle.detail(
            success: {
                [weak self] (info) in
                self?.userInfo = info
            },
            failed: { error in
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        })
        
        //更新账户数据
        userInfoHandle.accountDetail(
            success: {
                account in
                self.userAccount = account
                TSToast.hideHud(for: self.view)
        },
            failed: {
                error in
                TSToast.hideHud(for: self.view)
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        })
    }

    func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.classForCoder()) && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        } else {
            for view in view.subviews {
                let imageV = self.findHairlineImageViewUnder(view: view)
                if imageV != nil {
                    return imageV
                }
            }
            return nil
        }
    }

    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if tableView.responds(to: #selector(setter:UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }

    @IBAction func UserRecommendAction(_ sender: UIButton) {

    }

}


// MARK:- method
extension UserCenterViewController {

    private func initView() {
        tableView.tableFooterView = UIView()

        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = true
        }
//        if TSScreen.currentHeight == TSScreen.iPhoneXHeight {
//            titleMenuLabelLayoutConstraint.constant = 54
//        }else {
//            titleMenuLabelLayoutConstraint.constant = 32
//        }
//        let offset: CGFloat = 6
//        fixedButtons.forEach {
//            btn in
//            let imageSize = btn.imageView!.frame.size
//            let titleSize = btn.titleLabel!.intrinsicContentSize
//            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -imageSize.height - offset, right: 0)
//            btn.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - offset, left: 0, bottom: 0, right: -titleSize.width)
//        }
    }
}

// MARK:- UITableViewDataSource
extension UserCenterViewController {

    // 去除tableview 分割线不紧挨着左边
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter:UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter:UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 1):
            let vc = R.storyboard.userPlanOrderList.userPlanOrderMainController()!
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
