//
//  TSGuideViewController.swift
//  HuaXia
//
//  Created by tianshui on 16/3/2.
// 
//

import UIKit

/// 引导页
class TSGuideViewController: BaseViewController {

    var enterBlock: (() -> Void)?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        self.enterButton.setBackgroundColor(UIColor.clear, forState: UIControlState())
        self.enterButton.setBackgroundColor(UIColor(hex: 0xffffff, alpha: 0.5), forState: .highlighted)
    }
    
    @IBAction func enter(_ sender: UIButton) {
        UIView.animate(
            withDuration: 0.25,
            animations: {
                () -> Void in
                self.view.alpha = 0
            },
            completion: {
                (b) -> Void in
                self.enterBlock?()
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        )
    }

}

extension TSGuideViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / TSScreen.currentWidth)
        pageControl.currentPage = index
    }
}
