//
//  ForecastDetailController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/14.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 预测详情
class ForecastDetailController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewBottonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseTimeLabel: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var keepWinButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    
    @IBOutlet weak var matchView: UIView!
    @IBOutlet weak var matchViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var reasonBackgroundView: UIView!

    @IBOutlet weak var reasonAMatchInfoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var reasonASerialLabel: UILabel!
    @IBOutlet weak var reasonALeagueLabel: UILabel!
    @IBOutlet weak var reasonAHomeLabel: UILabel!
    @IBOutlet weak var reasonAAwayLabel: UILabel!
    @IBOutlet weak var reaonATextLabel: UILabel!
    
    @IBOutlet weak var reasonBMatchInfoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var reasonBTextLabelBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var reasonBBackgroundView: UIView!
    @IBOutlet weak var reasonBSerialLabel: UILabel!
    @IBOutlet weak var reasonBLeagueLabel: UILabel!
    @IBOutlet weak var reasonBHomeLabel: UILabel!
    @IBOutlet weak var reasonBAwayLabel: UILabel!
    @IBOutlet weak var reasonBTextLabel: UILabel!
    
    @IBOutlet weak var reasonBuryView: UIView!
    @IBOutlet weak var reasonBuryViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var orderBackgroundViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderBackgroundView: UIView!
    @IBOutlet weak var orderBackgroundViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var payTimeLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var originalPriceLineView: UIView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var orderNumberLabel: UILabel!
    
    @IBOutlet weak var freeOrderView: UIView!
    
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var payOriginalPriceLabel: UILabel!
    @IBOutlet weak var payOriginalPriceLineView: UIView!
    @IBOutlet weak var payCurrentPriceLabel: UILabel!
    @IBOutlet weak var payCurrentPriceLabelLeadingConstraint: NSLayoutConstraint!

    private var model: ForecastDetailModel! {
        didSet {
            configForecastTitleView()
            configUserInfoView()
            configMatchView()
            configReasonView()
            configOrderView()
            configPayView()
        }
    }
        
    /// 预测帖子的id
    public var forecastId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        initFollowButton()
        MBProgressHUD.showProgress(toView: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getForecastDetailData()
    }
    
    override func getData() {
        MBProgressHUD.showProgress(toView: self.view)
        getForecastDetailData()
    }
    
    override func refreshData() {
        getForecastDetailData()
    }
}

extension ForecastDetailController {
    private func getForecastDetailData() {
        ForecastHandler().getForecastDetail(forecastId: forecastId, success: { [weak self] (detailModel) in
            MBProgressHUD.hide(from: self?.view)
            self?.model = detailModel
            self?.showErrorView(false)
        }) { (error) in
            MBProgressHUD.hide(from: self.view)
            self.showErrorView(true)
        }
    }
    
    private func postFollowData() {
        ForecastHandler().postCommentAttentionFollow(userId: model.user.id, success: { [weak self] (json) in
            self?.followButton.isUserInteractionEnabled = true
            self?.followButton.isSelected = true
        }) { [weak self] (error) in
            self?.followButton.isUserInteractionEnabled = true
        }
    }
    
    private func postUnFollowData() {
        ForecastHandler().postCommentAttentionUnFollow(userId: model.user.id, success: { [weak self] (json) in
            self?.followButton.isUserInteractionEnabled = true
            self?.followButton.isSelected = false
        }) { [weak self] (error) in
            self?.followButton.isUserInteractionEnabled = true
        }
    }
    
    private func postPayData() {
        MBProgressHUD.showProgress(toView: view)
        ForecastHandler().postBuyData(forecastId: model.forecast.id, success: { [weak self] (json) in
            MBProgressHUD.hide(from: self?.view)
            self?.getForecastDetailData()
        }) { [weak self] (error) in
            MBProgressHUD.hide(from: self?.view)
            if error.code == 3004 {
                self?.insufficientBalance()
            } else {
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
            }
        }
    }
}

extension ForecastDetailController {
    @IBAction func userInfoButtonClick(_ sender: UIButton) {
        let vc = R.storyboard.forecast.forecastExpertController()!
        vc.userId = model.user.id
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func followButtonClick(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.isSelected ? postUnFollowData() : postFollowData()
    }
    
    @IBAction func payButtonClick(_ sender: UIButton) {
        if UserToken.shared.isLogin {
            let alertController = UIAlertController(title: "是否支付\(model.forecast.discount.decimal(0))料豆查看预测？", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
                self.postPayData()
            }))
            alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                
            }))
            present(alertController, animated: true, completion: nil)
        } else {
            NotificationCenter.default.post(name: UserNotification.userShouldLogin.notification, object: self)
        }
    }
    
    /// 余额不足
    private func insufficientBalance() {
        let alertController = UIAlertController(title: "账户余额不足", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "去充值", style: .default, handler: { (action) in
            let vc = R.storyboard.userLiao.userLiaoController()!
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ForecastDetailController {
    /// 是否付费了
    private func isPayed() -> Bool {
        /// 自己可以看
        if model.user.id == UserToken.shared.userInfo?.id {
            return true
        }
        // 免费
        if model.forecast.chargeType == .free {
            return true
        }
        // 支付过了
        if !(model.order?.orderNum ?? "").isEmpty {
            return true
        }
        return false
    }
    
    /// 是否开赛
    private func isOpenMatch() -> Bool {
        var isOpen = false
        for detail in model.detailList {
            if detail.matchTime <= Foundation.Date().timeIntervalSince1970 {
                isOpen = true
                break
            }
        }
        return isOpen
    }
}

extension ForecastDetailController {
    private func initFollowButton() {
        followButton.setTitle("+关注", for: .normal)
        followButton.setTitle("已关注", for: .selected)
        followButton.setTitleColor(UIColor.white, for: .normal)
        followButton.setTitleColor(UIColor.colour.gamutB3B3B3, for: .selected)
        followButton.setBackgroundColor(UIColor.logo, forState: .normal)
        followButton.setBackgroundColor(UIColor.clear, forState: .selected)
    }
    
    private func configForecastTitleView() {
        titleLabel.text = model.forecast.title
        titleLabel.lineSpacing(12)
        releaseTimeLabel.text = model.forecast.createTime.timeString(isIntelligent: true) + "发布"
    }
    
    private func configUserInfoView() {
        avatarImageView.sd_setImage(
            with: URL(string: ImageURLHelper(string: model.user.avatar, w: 80, h: 80).chop().urlString),
            placeholderImage: R.image.empty.avatar_80x80(), completed: nil)
        
        nicknameLabel.text = model.user.nickname
        keepWinButton.setTitle(model.user.keepWin.string + "连红", for: .normal)
        keepWinButton.isHidden = model.user.keepWin == 0
        followButton.isSelected = model.user.isAttention
        followButton.isHidden = model.user.id == UserToken.shared.userInfo?.id
    }
    
    private func configMatchView() {
        for view in matchView.subviews {
            view.removeFromSuperview()
        }
        matchViewHeightConstraint.constant = CGFloat(model.detailList.count * 195 + 10)
        for (index, detail) in model.detailList.enumerated() {
            let singleView = R.nib.forecastDetailMatchView.firstView(owner: nil)!
            singleView.showIndex = index
            singleView.isPayed = isPayed()
            singleView.model = detail
            matchView.addSubview(singleView)
        }
    }
    
    private func configReasonView() {
        func configReasonAView(model: ForecastMatchModel) {
            reasonASerialLabel.text = model.serial
            reasonALeagueLabel.text = model.leagueName
            reasonAHomeLabel.text = model.home
            reasonAAwayLabel.text = model.away
            reaonATextLabel.text = model.reason.isEmpty ? "暂无预测理由" : model.reason
            reaonATextLabel.lineSpacing(12)
        }
        
        func configReasonBView(model: ForecastMatchModel) {
            reasonBSerialLabel.text = model.serial
            reasonBLeagueLabel.text = model.leagueName
            reasonBHomeLabel.text = model.home
            reasonBAwayLabel.text = model.away
            reasonBTextLabel.text = model.reason.isEmpty ? "暂无预测理由" : model.reason
            reasonBTextLabel.lineSpacing(12)
        }
        
        /// 把reasonBBackgroundView 隐藏，并且高度设置为0
        func hiddenReasonBBackgroundView() {
            reasonBBackgroundView.isHidden = true
            reasonBMatchInfoHeightConstraint.constant = 0
            reasonBTextLabelBottomConstraint.constant = 0
            reasonBTextLabel.text = nil
        }
        
        func showReasonBBackgroundView() {
            reasonBBackgroundView.isHidden = false
            reasonBMatchInfoHeightConstraint.constant = 30
            reasonBTextLabelBottomConstraint.constant = 15
        }

        switch model.detailList.count {
        case 1:
            configReasonAView(model: model.detailList[0])
            hiddenReasonBBackgroundView()
        case 2:
            configReasonAView(model: model.detailList[0])
            configReasonBView(model: model.detailList[1])
            showReasonBBackgroundView()
        default:
            break
        }
        
        if isPayed() {
            reasonBuryView.isHidden = true
            reasonAMatchInfoHeightConstraint.constant = 30
        } else {
            hiddenReasonBBackgroundView()
            reasonBuryView.isHidden = false
            reasonAMatchInfoHeightConstraint.constant = 180
            reaonATextLabel.text = nil
            reasonBuryViewHeightConstraint.constant = 180 + 15
        }
    }
    
    private func configOrderView() {
        // 没有订单
        if (model.order?.orderNum ?? "").isEmpty {
            orderBackgroundView.isHidden = true
            orderBackgroundViewTopConstraint.constant = 0
            orderBackgroundViewHeightConstraint.constant = 0
            if model.forecast.chargeType == .free {
                orderBackgroundViewHeightConstraint.constant = 55 + 10
            }
            freeOrderView.isHidden = model.forecast.chargeType != .free
        } else {
            orderBackgroundView.isHidden = false
            orderBackgroundViewTopConstraint.constant = 10
            orderBackgroundViewHeightConstraint.constant = 129
            if let order = model.order {
                payTimeLabel.text = order.createTime.timeString(with: "yyyy-MM-dd HH:mm")
                if model.order?.pay == order.price {
                    originalPriceLabel.isHidden = true
                    originalPriceLineView.isHidden = true
                } else {
                    originalPriceLabel.isHidden = false
                    originalPriceLineView.isHidden = false
                    originalPriceLabel.text = order.price.decimal(0) + "料豆"
                    currentPriceLabel.text = order.pay.decimal(0) + "料豆"
                    orderNumberLabel.text = order.orderNum
                }
            }
        }
    }
    
    private func configPayView() {
        if isPayed() {
            scrollViewBottonConstraint.constant = 0
            payView.isHidden = true
        } else {
            scrollViewBottonConstraint.constant = Screen.tabBarBottomMargin + 55
            payView.isHidden = false
            ///没有折扣
            if model.forecast.price == model.forecast.discount {
                payOriginalPriceLabel.text = ""
                payCurrentPriceLabelLeadingConstraint.constant = 0
                payCurrentPriceLabel.text = model.forecast.discount.decimal(0) + "料豆"
            } else {
                payOriginalPriceLabel.text = model.forecast.price.decimal(0) + "料豆"
                payCurrentPriceLabel.text = model.forecast.discount.decimal(0) + "料豆"
            }
        }
    }
}
