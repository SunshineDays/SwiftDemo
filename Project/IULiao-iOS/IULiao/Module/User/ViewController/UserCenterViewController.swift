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
    private var userInfoHandle =  UserInfoHandler()
    @IBOutlet var fixedButtons: [UIButton]!
    
    var userInfo: UserInfoModel? {
       // return UserToken.shared.userInfo
        didSet {
            guard let userInfo = userInfo else {
                return
            }
            
            nicknameLabel.text = userInfo.nickname
            
            genderImageView.isHidden = userInfo.gender == .none
            genderImageView.image = userInfo.gender == .female ? R.image.user.infoGenderFemale() : R.image.user.infoGenderMale()
            
            if let url = userInfo.avatar {
                avatarImageView.sd_setImage(with: URL(string:TSImageURLHelper(string: url, size: CGSize(width: 160, height: 160)).chop().urlString), placeholderImage: R.image.fbRecommend.placeholdAvatar60x60())
            }
            
            phoneLabel.text = userInfo.secretPhone

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let navbarImageV = self.findHairlineImageViewUnder(view: (navigationController?.navigationBar)!)
        navbarImageV?.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
        //实时更新 用户数据
        
       userInfoHandle.detail(success: {
        [weak self ] (info) in
          self?.userInfo = info
       }) { (error) in
         TSToast.showNotificationWithTitle(error.localizedDescription)
        }
        
      
    }
    func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.classForCoder()) && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }else {
            for view  in view.subviews {
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
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    @IBAction func UserRecommendAction(_ sender: UIButton) {
        if UserToken.shared.isText {
            FBProgressHUD.showInfor(text: "暂无推荐信息")
        } else {
            let vc = FBRecommendExpertController()
            vc.initWith(userId: userInfo?.userID ?? 0, oddsType: .football)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
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
        let offset: CGFloat = 6
        fixedButtons.forEach {
            btn in
            let imageSize = btn.imageView!.frame.size
            let titleSize = btn.titleLabel!.intrinsicContentSize
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -imageSize.height - offset, right: 0)
            btn.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - offset, left: 0, bottom: 0, right: -titleSize.width)
        }
    }
}

// MARK:- UITableViewDataSource
extension UserCenterViewController {
    
    // 去除tableview 分割线不紧挨着左边
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0  {
            switch indexPath.row {
            // 评分
            case 1:
                break
            // 分享
            case 2:
                UIApplication.shared.openURL(URL(string: kConstantsAppItunesURLString)!)
            case 3:
                UMSocialSwiftInterface.showShareMenuWindow {
                    type in
                    
                    UMSocialSwiftInterface.shareWebpage(
                        platformType: type,
                        viewController: self,
                        title: "有料体育App",
                        webpageUrl: kConstantsAppItunesURLString,
                        description: "赛前信息及时掌握，独家信息大爆料，最全面的的赛事分析祝你赢球不断！",
                        thumbImageUrl: nil,
                        completion: {
                            (response, error) in
                            
                    })
                }
                
            default:
                break
            }
            
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
