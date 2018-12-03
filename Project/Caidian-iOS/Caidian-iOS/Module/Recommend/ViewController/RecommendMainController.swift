//
//  RecommendMainController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 推荐
class RecommendMainController: BaseViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var rightCartItem = R.nib.recommendCartItemView.firstView(owner: nil)!
    
    private let recommendCtrl = RecommendOrderController()

    private let copyOrderCtrl = CopyOrderViewController()

    private var cartNumber = 0 {
        didSet {
            rightCartItem.numberLabel.text = cartNumber.string()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        
        if #available(iOS 11.0, *) {
            
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        initCartItem()
        initScrollView()
        initCtrls()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshCartNumber), name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartNumber = UserToken.shared.userCartInfo?.count ?? 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension RecommendMainController {
    private func initCartItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightCartItem)
        rightCartItem.cartItemTouchBlock = {
            let vc = R.storyboard.recommend.recommendCartController()!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func initScrollView() {
        scrollView.contentSize = CGSize(width: TSScreen.currentWidth * 2, height: scrollView.height)
        scrollView.isUserInteractionEnabled = true
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        if #available(iOS 11.0, *) {
            scrollView.isScrollEnabled = true
        } else {
            scrollView.isScrollEnabled = false
        }
    }
    
    private func initCtrls() {
        // 专家推荐
        self.addChildViewController(recommendCtrl)
        scrollView.addSubview(recommendCtrl.view)
        
        // 复制跟单
        self.addChildViewController(copyOrderCtrl)
        copyOrderCtrl.view.x = TSScreen.currentWidth
        scrollView.addSubview(copyOrderCtrl.view)
    }
}


// MARK: - UIScrollViewDelegate
extension RecommendMainController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView.contentOffset.x {
        case 0:
            segmentedControl.selectedSegmentIndex = 0
            recommendCtrl.getData()
        case TSScreen.currentWidth:
            segmentedControl.selectedSegmentIndex = 1
            copyOrderCtrl.getData()
        default:
            break
        }
    }
}

// MARK: - Action
extension RecommendMainController {
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: TSScreen.currentWidth * CGFloat(sender.selectedSegmentIndex), y: 0), animated: true)
        switch sender.selectedSegmentIndex {
        case 0:
            recommendCtrl.getData()
        default:
            copyOrderCtrl.getData()
        }
    }
    
    @objc private func refreshCartNumber() {
        cartNumber = UserToken.shared.userCartInfo?.count ?? 0
    }
}
