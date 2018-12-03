//
//  NewsPageView.swift
//  IULiao
//
//  Created by levine on 2017/7/25.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

class NewsPageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var oldIndex:Int = 0
    private var currentIndex:Int = 0
    private var startOffsetX:CGFloat = 0
    private var isForbidScroll: Bool = false
    var titles = ["全部","推荐","战报","转会","伤病","花絮","篮球"]
    var childVcs : [NewsTopicViewController]?
    {
        didSet{
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        ui搭建
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //frame搭建
        setupFranme()
    }
    private lazy var scrollView:UIScrollView = {
    
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var titleView:NewsTitleView = {
    
        let titleView = NewsTitleView()
        titleView.delegate = self
        return titleView
    }()

    
}
extension NewsPageView{
    private func setupUI()
    {
        backgroundColor = UIColor.white
        addSubview(titleView)
        addSubview(scrollView)
    }
    private func setupFranme()
    {
        titleView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(40)
        }
        scrollView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(titleView.snp.bottom)
        }
    }
}
extension NewsPageView:UIScrollViewDelegate
{
    //开始滑动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //获取当前索引
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        //取出自控制器
        let childeVc = childVcs?[index]
        childeVc?.view.frame = CGRect(x: scrollView.contentOffset.x, y: 0, width: scrollView.width, height: scrollView.height)
        scrollView.addSubview((childeVc?.view)!)
    }
    //开始拖动
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    //结束滑动
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
}
extension NewsPageView:NewsTitleViewDelegate
{
    func titleView(_ titleView: NewsTitleView, targetIndex: Int) {
        currentIndex = targetIndex
        let offSet = CGPoint(x: TSScreen.currentWidth, y: 0)
        scrollView.setContentOffset(offSet, animated: true)
    }
}
