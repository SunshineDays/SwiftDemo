//
//  FBRecommend2HomePageController.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/24.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 推荐 父控制器
class FBRecommend2HomePageController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0xe6e6e6)
        navigationItem.titleView = segmentedControl
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["单场推荐", "竞彩2串1"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    /// 发起推荐
    private lazy var postRecommendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.setBackgroundImage(R.image.fbRecommend.postEditernormal(), for: .normal)
        button.setBackgroundImage(R.image.fbRecommend.postEditerhigh(), for: .highlighted)
        button.addTarget(self, action: #selector(postRecommendButtonAction), for: .touchUpInside)
        return button
    }()

    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight))
        scrollView.isUserInteractionEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize.init(width: TSScreen.currentWidth * 2, height: TSScreen.currentHeight - TSScreen.tabBarHeight(self) - TSScreen.navigationBarHeight(self) - TSScreen.statusBarHeight)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
}

// MARK: - Init
extension FBRecommend2HomePageController {
    private func initView() {
        // 单场推荐
        let newsVC = FBRecommendFootballSingleController()
        self.addChildViewController(newsVC)
        scrollView.addSubview(newsVC.view)
        
        // 竞彩2串1
        let bunchVC = FBRecommendJingcaiBunchController()
        self.addChildViewController(bunchVC)
        bunchVC.view.frame = CGRect(x: TSScreen.currentWidth, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.navigationBarHeight(self) - TSScreen.statusBarHeight)
        scrollView.addSubview(bunchVC.view)
        
        view.addSubview(postRecommendButton)
        postRecommendButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(55)
            make.trailing.equalTo(self.view).offset(-20)
            make.bottom.equalTo(self.view).offset(-(40 + TSScreen.tabBarHeight(self)))
        }
    }
}

// MARK: - UIScrollViewDelegate
extension FBRecommend2HomePageController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case 0:
            segmentedControl.selectedSegmentIndex = 0
        case TSScreen.currentWidth:
            segmentedControl.selectedSegmentIndex = 1
        default:
            break
        }
    }
}

// MARK: - Action
extension FBRecommend2HomePageController {
    @objc private func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: TSScreen.currentWidth * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    @objc private func postRecommendButtonAction() {
        if  UserToken.shared.isLogin {
            // 发起推荐
            let vc = FBRecommendSponsorController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let ctrl = UIStoryboard(name: "UserLogin", bundle: nil).instantiateInitialViewController()
            present(ctrl!, animated: true, completion: nil)
        }
    }
}



