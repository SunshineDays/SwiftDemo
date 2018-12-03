//
//  SLChooseViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

/// 投注选择页协议
protocol ChooseViewControllerProtocol {
    
    /// 彩种
    var lottery: LotteryType { get set }
    /// 玩法
    var playType: PlayType { get set }
    
    var recommendModels: [RecommendDetailModel]? { get set }
}

/// 竞技彩 对阵基类
class SLChooseViewController: TSEmptyViewController, ChooseViewControllerProtocol {
    
    private var titleBtn: UIButton?
    private var isShowAllPlayType = false
    private var popoverBoxCtrl: WYPopoverController?
    private var popoverContentCtrl: TSPopoverContentViewController?

    var filterMatchBtn = UIButton()
    var moreItemBtn = UIButton()

    var lottery = LotteryType.none
    var playType = PlayType.none {
        didSet {
            playTypeChanged()
        }
    }

    var playTypeList = [PlayType.none] {
        didSet {
            playTypeChanged()
        }
    }
    
    /// 选中的推荐列表
    var recommendModels: [RecommendDetailModel]? = nil {
        didSet {
            playTypeChanged()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        wr_setNavBarBarTintColor(UIColor.navigationBarTintColor)
        initView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if titleBtn != nil {
            titleBtn!.layoutImageViewPosition(.right, withOffset: 5)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension SLChooseViewController {

    private func initView() {
        playTypeChanged()
        
        do {
            view.backgroundColor = UIColor.white
            automaticallyAdjustsScrollViewInsets = false
            edgesForExtendedLayout = []
        }

        do {
            moreItemBtn.setImage(R.image.bet.chooseList()?.image(withColor: UIColor.white), for: .normal)
            moreItemBtn.setImage(R.image.bet.chooseList()?.image(withColor: UIColor.lightGray), for: .highlighted)
            moreItemBtn.addTarget(self, action: #selector(moreItemBtnAction), for: .touchUpInside)
            filterMatchBtn.setImage(R.image.bet.chooseFilter()?.image(withColor: UIColor.white), for: .normal)
            filterMatchBtn.setImage(R.image.bet.chooseFilter()?.image(withColor: UIColor.lightGray), for: .highlighted)
            filterMatchBtn.addTarget(self, action: #selector(filterMatchBtnAction), for: .touchUpInside)

            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 44))
            customView.addSubview(moreItemBtn)
            customView.addSubview(filterMatchBtn)

            if #available(iOS 11.0, *) {
                customView.snp.makeConstraints {
                    make in
                    make.height.equalTo(44)
                    make.width.equalTo(70)
                }
            }
            moreItemBtn.snp.makeConstraints {
                make in
                make.right.equalTo(customView.snp.right)
                make.width.equalTo(32)
                make.height.equalTo(moreItemBtn.snp.width).multipliedBy(1)
                make.centerY.equalToSuperview()

            }
            filterMatchBtn.snp.makeConstraints {
                make in
                make.right.equalTo(moreItemBtn.snp.left).offset(-6)
                make.width.equalTo(moreItemBtn.snp.width).multipliedBy(1)
                make.height.equalTo(moreItemBtn.snp.height).multipliedBy(1)
                make.centerY.equalToSuperview()
            }
            let customItem = UIBarButtonItem(customView: customView)
            navigationItem.rightBarButtonItem = customItem
        }
    }

    private func playTypeChanged() {
        if playTypeList.count <= 1 {
            title = playType.name
            return
        }
        if titleBtn == nil {
            titleBtn = UIButton(type: .custom)
            titleBtn!.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
            titleBtn!.setImage(R.image.bet.chooseArrowDown()?.image(withColor: UIColor.white), for: .normal)
            titleBtn!.addTarget(self, action: #selector(showAllPlayType), for: .touchUpInside)
            navigationItem.titleView = titleBtn
        }
        titleBtn!.setTitle(playType.name, for: .normal)
    }

    @objc func moreItemBtnAction() {

        if popoverContentCtrl == nil {
            popoverContentCtrl = TSPopoverContentViewController()
            popoverContentCtrl?.dataSource = ["投注记录", "玩法介绍"]
            popoverContentCtrl?.popoverItemClickBlock = {
                [weak self] index in
                guard let me = self else {
                    return
                }
                me.popoverBoxCtrl?.dismissPopover(animated: true)
                if index == 0 {
                    let ctrl = TSEntryViewControllerHelper.userOrderBuyListViewController()
                    me.navigationController?.pushViewController(ctrl, animated: true)
                } else if index == 1 {
                    let ctrl = TSEntryViewControllerHelper.lotteryIntroViewController(lottery: me.lottery)
                    me.navigationController?.pushViewController(ctrl, animated: true)
                }
            }
        }
        if popoverBoxCtrl == nil {
            popoverBoxCtrl = WYPopoverController(contentViewController: popoverContentCtrl)
            popoverBoxCtrl?.theme = WYPopoverThemeDark()
        }

        // 计算位置 btn的中线和底线点
        let point = moreItemBtn.convert(CGPoint(x: 16, y: 40), to: nil)
        let rect = CGRect(x: point.x, y: 0, width: 0, height: 0)
        popoverBoxCtrl?.presentPopover(from: rect, in: view, permittedArrowDirections: .up, animated: true)
    }

    @objc func filterMatchBtnAction() {
        print("子类实现点击赛事筛选逻辑,如不实现则可以隐藏此button")
    }

    /// 显示所有玩法
    @objc private func showAllPlayType() {
        if isShowAllPlayType {
            for v in childViewControllers {
                if v is LotteryChooseChangePlayViewController {
                    lotteryChooseChangePlayViewControllerMaskViewDidTap(v as! LotteryChooseChangePlayViewController)
                    break
                }
            }
            return
        }
        isShowAllPlayType = true
        let ctrl = R.storyboard.lotteryChooseChangePlay.lotteryChooseChangePlayViewController()!
        ctrl.playTypeList = playTypeList
        ctrl.selectedPlayType = playType
        ctrl.delegate = self

        addChildViewController(ctrl)
        view.addSubview(ctrl.view)
        ctrl.view.snp.makeConstraints {
            make in
            make.top.equalTo(view.snp.topMargin)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
}

extension SLChooseViewController: LotteryChooseChangePlayViewControllerDelegate {
    func lotteryChooseChangePlayViewController(_ ctrl: LotteryChooseChangePlayViewController, playTypeChanged play: PlayType) {
        playType = play
        lotteryChooseChangePlayViewControllerMaskViewDidTap(ctrl)
    }

    func lotteryChooseChangePlayViewControllerMaskViewDidTap(_ ctrl: LotteryChooseChangePlayViewController) {
        ctrl.view.removeFromSuperview()
        ctrl.removeFromParentViewController()
        isShowAllPlayType = false
    }
}
