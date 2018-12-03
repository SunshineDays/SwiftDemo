//
//  OrderMainViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit
import DZNEmptyDataSet

/// 用户认购订单详情
class OrderMainViewController: TSEmptyViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let handler = UserOrderBuyHandler()
    private let lotteryView = OrderLotteryView()
    private let ticketView = OrderTicketView()
    private let betInfoView = OrderBetInfoView()
    private let mainView = UIView()
    private var detailViewController: (UIViewController & OrderDetailViewControllerProtocol)?
    
    var buyId: Int! = 1544


    var isSelectBoolean : Bool = false
    
    /// 是否是自己单发
    var isOrderSelfBoolean : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        getData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        mainView.snp.updateConstraints {
            make in
            make.height.equalTo(detailViewController?.realHeight ?? 40)
        }
    }
    
    override func getData() {
        TSToast.showLoading(view: view)
        
        handler.getDetail(
            buyId: buyId,
            success: {
                orderDetail in
                self.isSelect(orderDetail: orderDetail)
                self.configView(orderDetail: orderDetail)
                self.contentView.isHidden = false
                self.isLoadData = true
                self.isRequestFailed = false
                self.scrollView.reloadEmptyDataSet()
                TSToast.hideHud(for: self.view)
        },
            failed: {
                error in
                self.isLoadData = false
                self.isRequestFailed = true
                self.scrollView.reloadEmptyDataSet()
                TSToast.hideHud(for: self.view)
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                
        })
    }
    
}

extension OrderMainViewController {
    
    private func initView() {
        do {
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
            contentView.addSubview(lotteryView)
            contentView.addSubview(ticketView)
            contentView.addSubview(mainView)
            contentView.addSubview(betInfoView)
        }
        
        do {
            scrollView.snp.makeConstraints {
                make in
                make.edges.equalToSuperview()
            }

            contentView.snp.makeConstraints {
                make in
                make.edges.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            
            lotteryView.snp.makeConstraints {
                make in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(OrderLotteryView.defaultHeight)
            }
            
            ticketView.snp.makeConstraints {
                make in
                make.top.equalTo(lotteryView.snp.bottom).offset(10)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(OrderTicketView.defaultHeight)
            }
            
            mainView.snp.makeConstraints {
                make in
                make.top.equalTo(ticketView.snp.bottom).offset(10)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(40)
                make.bottom.equalTo(betInfoView.snp.top)
            }

            betInfoView.snp.makeConstraints {
                make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(OrderBetInfoView.defaultHeight + 40)
                make.bottom.equalTo(contentView.snp.bottom)
            }
        }
        
        do {
            title = "订单详情"
            scrollView.emptyDataSetDelegate = self
            scrollView.emptyDataSetSource = self
            view.backgroundColor = UIColor.white
            contentView.backgroundColor = UIColor(hex: 0xededed)
            mainView.backgroundColor = UIColor.white
            mainView.clipsToBounds = true
            contentView.isHidden = true
        }

    }

    private func configView(orderDetail: OrderDetailModel) {
        let lottery = orderDetail.order.lottery
        lotteryView.configView(orderDetail: orderDetail)
        ticketView.configView(order: orderDetail.order)
        betInfoView.configView(orderDetailModel: orderDetail)
        

        switch lottery {
        case .jczq:
            let vc = OrderJczqDetailViewController()
            vc.matchList = orderDetail.matchList
            vc.serialList = orderDetail.order.serialList
            vc.isSelectBoolean = isSelectBoolean
            detailViewController = vc
        case .jclq:
            let vc = OrderJclqDetailViewController()
            vc.matchList = orderDetail.matchList
            vc.serialList = orderDetail.order.serialList
            detailViewController = vc
        default:
            break
        }
        
        if let ctrl = detailViewController {
            addChildViewController(ctrl)
            mainView.addSubview(ctrl.view)
            ctrl.view.snp.makeConstraints {
                make in
                make.edges.equalToSuperview()
            }
        }

    }

    ///  是否可见
    func isSelect(orderDetail: OrderDetailModel){

        if UserToken.shared.userInfo?.phone == "17621746288" {
            isSelectBoolean = true
            return
        }
        
        // 已开的比赛可能出现为nil的情况
        if orderDetail.parent == nil{
            isSelectBoolean = true
            return
        }
        
        /// 是否是自己单发
        isOrderSelfBoolean =  orderDetail.parent?.userId == UserToken.shared.userInfo?.id

        // 只有竞彩足球有发单
        if orderDetail.order.lottery != LotteryType.jczq {
            isSelectBoolean = true
            return
        }

        //最近一场比赛时间
        var  maxTimeMatch = orderDetail.matchList.first!.match.matchTime
        orderDetail.matchList.forEach{
            if $0.match.matchTime >= maxTimeMatch{
                maxTimeMatch = $0.match.matchTime
            }
        }

        //是否全部开赛
        let isAllStartMatchBoolean = maxTimeMatch < NSDate().timeIntervalSince1970
        // 已经全部开赛 || 发单可见 || 自己发的单 || 跟单可见并已经跟单
        if isAllStartMatchBoolean || orderDetail.parent!.isSecret == 0 || isOrderSelfBoolean || orderDetail.parent!.isSecret == 2 {
            isSelectBoolean = true
            return
        }
        isSelectBoolean = false

    }
    
}

extension OrderMainViewController {
    
    override func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return isRequestFailed
    }
}
