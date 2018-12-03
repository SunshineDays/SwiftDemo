//
//  HomeTableHeaderView.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/25.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol HomeTableHeaderViewDelegate: class {
    func homeTableHeaderView(_ view: HomeTableHeaderView, footballClickButton sneder: UIButton, index: Int)
    func homeTableHeaderView(_ view: HomeTableHeaderView, basketballClickButton sneder: UIButton, index: Int)
}

class HomeTableHeaderView: UIView {

    @IBOutlet weak var cycleEmptyImageView: UIImageView!
    @IBOutlet weak var cycleScrollView: SDCycleScrollView!
    
    @IBOutlet weak var notificationScrollView: SDCycleScrollView!
    
    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var shopImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBOutlet weak var footballButton: UIButton!
    @IBOutlet weak var basketballButton: UIButton!
    
    @IBOutlet weak var footballTitleLabel: UILabel!
    @IBOutlet weak var footballDescriptionLabel: UILabel!
    
    @IBOutlet weak var basketballTitleLabel: UILabel!
    @IBOutlet weak var basketballDescroptionLabel: UILabel!
    
    @IBOutlet weak var wechatLabel: UILabel!
    @IBOutlet weak var wechatLabelLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabelRightConstraint: NSLayoutConstraint!
    
    static let headerViewHeight = TSScreen.currentWidth * 160 / 375 + 30 + 0.5 + 10 + (TSScreen.currentWidth / 2 - 10) * 2 / 3 + 10 + 0.5 + 30
    
    public weak var delegate: HomeTableHeaderViewDelegate?
    
    @IBAction func footballAction(_ sender: UIButton) {
        if lotteryDataSource.count > 0 {
            delegate?.homeTableHeaderView(self, footballClickButton: sender, index: 0)
        }
    }
    
    @IBAction func basketballAction(_ sender: UIButton) {
        if lotteryDataSource.count > 0 {
            delegate?.homeTableHeaderView(self, basketballClickButton: sender, index: 1)
        }
    }
    
    /// 轮播图个数
//    private let scrollImageMax = 3
    
    /// 轮播图
    private var scrollImages = [String]()
    /// 通知
    private var notifications = [String]()
    
    private var homeMainModel: HomeMainModel!
    
    private var lotteryDataSource = [HomeLotteryModel]()

    public func configView(model: HomeMainModel) {
        cycleEmptyImageView.isHidden = true
        homeMainModel = model
        scrollImages.removeAll()
        notifications.removeAll()
        
        /// 380 160
        for s in homeMainModel.scrollList {
            scrollImages.append(TSImageURLHelper.init(string: s.image, w: Int(cycleScrollView.width * 2), h: Int(cycleScrollView.height * 2)).chop(mode: .alwayCrop).urlString)
        }
        
        cycleScrollView.imageURLStringsGroup = scrollImages
        
        homeMainModel.newsBonusList.forEach { (model) in
            notifications.append("\(model.nickName[0...1])****的\(model.lotteryName)方案中奖 \(model.bonus.moneyText(2)) 元")
        }
        shopImageView.sd_setImage(with: TSImageURLHelper(string: model.shopModel.image, w: 900, h: 600).url,
                                  placeholderImage: R.image.empty.image150x100(), completed: nil)

        let shopImageURL = TSImageURLHelper.init(string:  model.shopModel.image, w: 360, h: 240).chop(mode: .alwayCrop).url
        shopImageView.sd_setImage(with: shopImageURL, placeholderImage: R.image.empty.image150x100(), completed: nil)
        shopNameLabel.text = model.shopModel.name
        
        wechatLabel.text = model.shopModel.wechat
        timeLabel.text = model.shopModel.businessHours
        

        initView()
    }
    
    public func configView(list: [HomeLotteryModel]) {
        cycleEmptyImageView.isHidden = true
        lotteryDataSource = list
        if lotteryDataSource.count >= 2 {
            footballButton.setBackgroundImage(lotteryDataSource[0].isSale ? R.image.home.home_football() : R.image.home.home_football_noSale(), for: .normal)
            basketballButton.setBackgroundImage(lotteryDataSource[1].isSale ? R.image.home.home_basketball() : R.image.home.home_basketball_noSale(), for: .normal)
            
            footballTitleLabel.text = lotteryDataSource[0].lotteryName
            footballDescriptionLabel.text = lotteryDataSource[0].description
            
            basketballTitleLabel.text = lotteryDataSource[1].lotteryName
            basketballDescroptionLabel.text = lotteryDataSource[1].description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shopImageWidthConstraint.constant = TSScreen.currentWidth / 2 - 10
        notificationScrollView.backgroundColor = UIColor.white

        if TSScreen.currentWidth < TSScreen.iPhone6Width {
            wechatLabelLeftConstraint.constant = 10
            timeLabelRightConstraint.constant = 0
        }
    
        cycleScrollView.backgroundColor = UIColor.white
        initView()
  
        
    }
    
    /// 初始化无数据的情况
    public func initData(){
        cycleScrollView.backgroundColor = UIColor.white
        notifications.removeAll()
        notifications.append("")
        scrollImages.removeAll()
        cycleEmptyImageView.isHidden = false
        initView()
    }
    
}

extension HomeTableHeaderView {
    private func initView() {
        initCycleScrollView()
        initNotificationScrollView()
    }
    
    private func initCycleScrollView() {
        cycleScrollView.backgroundColor = UIColor.white
        cycleScrollView.autoScrollTimeInterval = 2.5
        cycleScrollView.autoScroll = true
        cycleScrollView.placeholderImage = R.image.empty.image400x200()
        cycleScrollView.pageDotColor = UIColor.white
        cycleScrollView.currentPageDotColor = UIColor(hex: 0xff4444)
        cycleScrollView.showPageControl = true
        
    }
    
    private func initNotificationScrollView() {
        notificationScrollView.onlyDisplayText = true
        notificationScrollView.showPageControl = false
        notificationScrollView.disableScrollGesture()
        notificationScrollView.titleLabelTextColor = UIColor(hex: 0xff0000)
        notificationScrollView.titleLabelBackgroundColor = UIColor.white
        notificationScrollView.titleLabelTextFont = UIFont.systemFont(ofSize: 12)
        notificationScrollView.scrollDirection = UICollectionViewScrollDirection.vertical
        notificationScrollView.titleLabelHeight = notificationScrollView.height
        notificationScrollView.autoScrollTimeInterval = 2.5
        notificationScrollView.imageURLStringsGroup = notifications
        notificationScrollView.titlesGroup = notifications
    }
    
}



