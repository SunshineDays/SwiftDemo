//
//  UserAttentionListViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import SwiftyJSON
import CRToast


/// 关注
class UserAttentionListViewController: BaseViewController {


    let moduleAttentionTypes = [ModuleAttentionType.recommend_statistic, ModuleAttentionType.recommend, ModuleAttentionType.news]

    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var scrollView: PiazzaScrollView!

    private var currentIndex: Int = 0
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {

        //if currentIndex == sender.selectedSegmentIndex {return}
        //currentIndex = sender.selectedSegmentIndex
        scrollView.setContentOffset(CGPoint(x: scrollView.width * CGFloat(sender.selectedSegmentIndex), y: scrollView.contentOffset.y), animated: true)
    }
    var commendAttentionHandler = CommonAttentionHandler()
     override func viewDidLoad() {
        super.viewDidLoad()
        initView()
//        commendAttentionHandler.executeAttentionList(module: ModuleAttentionType.recommend_statistic, page: <#Int#>, pageSize: <#Int#>)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
}
extension UserAttentionListViewController {
    private final func initView() {
        for index in 0..<moduleAttentionTypes.count {
            let attentionChildVc = UserAttentionChilderViewController()
            addChildViewController(attentionChildVc)
            if index < 1 {
                addChildView(index: index)
            }
        }
        scrollView.contentSize = CGSize(width: TSScreen.currentWidth * CGFloat(moduleAttentionTypes.count), height: 0)

    }
    private final func addChildView(index: Int) {
        let childVc = childViewControllers[index] as! UserAttentionChilderViewController
        if childVc.view.superview != nil {return}
        childVc.commendAttentionType = moduleAttentionTypes[index]
        childVc.view.frame = CGRect(x: scrollView.width * CGFloat(index), y: 0, width: scrollView.width, height: scrollView.height)
        scrollView.addSubview(childVc.view)
    }
}
extension UserAttentionListViewController: UIScrollViewDelegate {


    // 滚动结束后触发 代码导致
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        let index = Int(scrollView.contentOffset.x / scrollView.width)

        segmentControl.selectedSegmentIndex = index
        if currentIndex == index {return}

        currentIndex = index

        addChildView(index: currentIndex)

    }
    // 滚动结束 手势导致
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        scrollViewDidEndScrollingAnimation(scrollView)
    }
}
