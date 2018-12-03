//
// Created by tianshui on 2018/5/16.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

//private var KVOContentSizeContext = "KVOContentSizeContext"

/// 排列三 3d
class Pl3MainViewController: NLChooseViewController {

    private var issueHandler = LotteryIssueHandler()
    private var buyModel: NLBuyModel!
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var headerView = UIView()
    private var footerView = UIView()
    private var isLayout = false
    var headerViewHeight: CGFloat = 30

    private var oldOffsetY: CGFloat = 0
    private var isScrollDecelerate = false

    override func viewDidLoad() {
        initParams()
        super.viewDidLoad()

        initView()
        getData()

    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if !isLayout {
            headerView.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: headerViewHeight)
            scrollView.frame = CGRect(x: 0, y: headerViewHeight, width: TSScreen.currentWidth, height: view.height - headerViewHeight)
            isLayout = true
        }
    }
}

extension Pl3MainViewController {

    private func initParams() {
        lottery = .pl3
        if playType == .none {
            playType = .d3_zx
        }
        title = "\(lottery.name)-\(playType.name)"
        var buy = NLBuyModel()
        buy.lottery = lottery
        buy.play = playType
        playTypeList = [.d3_zx, .d3_zu3, .d3_zu6]

        buyModel = buy

        recentResultViewController = Pl3RecentResultViewController()
        recentResultViewController.lottery = lottery

    }

    private func initView() {
        view.addSubview(scrollView)
        view.addSubview(headerView)

        headerView.backgroundColor = UIColor(hex: 0xffff00, alpha: 0.5)

        scrollView.addSubview(contentView)
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true

        view.backgroundColor = UIColor(hex: 0xff0000, alpha: 0.1)
        scrollView.backgroundColor = UIColor(hex: 0x0000ff, alpha: 0.1)

        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        let label = UILabel()
        label.text = "test"
        label.backgroundColor = UIColor(hex: 0x00ff00, alpha: 0.1)
        contentView.addSubview(label)
        label.snp.makeConstraints {
            make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-800)
        }

        let label2 = UILabel()
        label2.text = "label2"
        contentView.addSubview(label2)
        label2.snp.makeConstraints {
            make in
            make.left.equalTo(20)
            make.bottom.equalTo(-30)
        }
    }

    func getData() {
        issueHandler.getSaleIssueList(
                lottery: lottery,
                success: {
                    issueList, serverTime in

                },
                failed: {
                    error in
                    TSToast.showText(view: self.view, text: error.localizedDescription)
                })
    }
}

extension Pl3MainViewController: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        oldOffsetY = scrollView.y
        isScrollDecelerate = false
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if !isScrollDecelerate && offsetY < 0 {
            headerView.y -= offsetY
            scrollView.y -= offsetY
        } else if offsetY > 0 && headerView.y > 0 {
            headerView.y -= offsetY
            scrollView.y -= offsetY
            scrollView.contentOffset = CGPoint.zero
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isScrollDecelerate = decelerate
        if oldOffsetY > scrollView.y {
            // 上滚 收起还原
            setScrollView(originY: 0)
        } else if oldOffsetY < scrollView.y {
            // 下滚
            setScrollView(originY: recentResultViewController.tableHeight)
        }
    }

    /// 设置scrollView的位置
    func setScrollView(originY y: CGFloat) {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2)
        headerView.y = y
        scrollView.y = y + headerViewHeight
        UIView.commitAnimations()
    }

}

