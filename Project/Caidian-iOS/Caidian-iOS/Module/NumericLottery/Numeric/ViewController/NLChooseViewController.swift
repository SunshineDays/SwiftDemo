//
//  NLChooseViewController.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

/// 数字彩 对阵基类
class NLChooseViewController: BaseViewController, ChooseViewControllerProtocol {
    var recommendModels: [RecommendDetailModel]?
    
    private var titleBtn: UIButton?
    private var isShowAllPlayType = false
    private var popoverBoxCtrl: WYPopoverController?
    private var popoverContentCtrl: TSPopoverContentViewController?
    private var recentView = UIView()
    var recentResultViewController: NLRecentResultViewController!
    var chooseTipBottomView = NLChooseTipBottomView()

    /// 走势图
    var trendBtn = UIButton()
    var moreItemBtn = UIButton()

    var lottery = LotteryType.none
    var playType = PlayType.none {
        didSet {
            playTypeChanged()
        }
    }

    /// 支持的玩法列表 玩法列表大于1则支持下拉选择
    var playTypeList = [PlayType.none] {
        didSet {
            playTypeChanged()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

// MARK:- method
extension NLChooseViewController {

    private func initView() {
        playTypeChanged()

        do {
            view.addSubview(recentView)
            view.addSubview(chooseTipBottomView)
        }

        do {
            view.backgroundColor = UIColor.white
            automaticallyAdjustsScrollViewInsets = false
            edgesForExtendedLayout = []
        }

        do {
            moreItemBtn.setImage(R.image.bet.chooseList()?.image(withColor: UIColor.white), for: .normal)
            moreItemBtn.setImage(R.image.bet.chooseList()?.image(withColor: UIColor.lightGray), for: .highlighted)
            moreItemBtn.addTarget(self, action: #selector(moreItemBtnAction), for: .touchUpInside)
            trendBtn.setImage(R.image.bet.chooseFilter()?.image(withColor: UIColor.white), for: .normal)
            trendBtn.setImage(R.image.bet.chooseFilter()?.image(withColor: UIColor.lightGray), for: .highlighted)
            trendBtn.addTarget(self, action: #selector(tradeBtnAction), for: .touchUpInside)
            // 走势图为预留 暂时先隐藏
            trendBtn.isHidden = true
            
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 70, height: 44))
            customView.addSubview(moreItemBtn)
            customView.addSubview(trendBtn)

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
            trendBtn.snp.makeConstraints {
                make in
                make.right.equalTo(moreItemBtn.snp.left).offset(-6)
                make.width.equalTo(moreItemBtn.snp.width).multipliedBy(1)
                make.height.equalTo(moreItemBtn.snp.height).multipliedBy(1)
                make.centerY.equalToSuperview()
            }
            let customItem = UIBarButtonItem(customView: customView)
            navigationItem.rightBarButtonItem = customItem
        }

        do {

            addChildViewController(recentResultViewController)
            recentView.addSubview(recentResultViewController.view)
            recentResultViewController.view.snp.makeConstraints {
                make in
                make.edges.equalToSuperview()
            }

            recentView.snp.makeConstraints {
                make in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.height.equalTo(recentResultViewController.tableHeight)
            }
        }
    }

    /// 玩法改变
    private func playTypeChanged() {
        if playTypeList.count <= 1 {
            title = lottery.name
            return
        }
        if titleBtn == nil {
            titleBtn = UIButton(type: .custom)
            titleBtn!.frame = CGRect(x: 0, y: 0, width: 110, height: 40)
            titleBtn!.setImage(R.image.bet.chooseArrowDown()?.image(withColor: UIColor.white), for: .normal)
            titleBtn!.addTarget(self, action: #selector(showAllPlayType), for: .touchUpInside)
            navigationItem.titleView = titleBtn
        }
        if TSScreen.currentWidth > TSScreen.iPhone5Width {
            titleBtn!.setTitle("\(lottery.name)-\(playType.name)", for: .normal)
        } else {
            titleBtn!.setTitle("\(playType.name)", for: .normal)
        }
    }

    @objc func moreItemBtnAction() {

        if popoverContentCtrl == nil {
            popoverContentCtrl = TSPopoverContentViewController()
            popoverContentCtrl?.dataSource = ["投注记录", "玩法介绍", "历史开奖"]
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
                } else if index == 2 {
                    TSToast.showText(view: me.view, text: "历史开奖")
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

    @objc func tradeBtnAction() {
        print("子类实现点击走势图,如不实现则可以隐藏此button")
    }

    /// 显示所有玩法
    @objc private func showAllPlayType() {
        if isShowAllPlayType {
            // 已经显示则再次点击时关闭
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

// MARK:- LotteryChooseChangePlayViewControllerDelegate
extension NLChooseViewController: LotteryChooseChangePlayViewControllerDelegate {
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
