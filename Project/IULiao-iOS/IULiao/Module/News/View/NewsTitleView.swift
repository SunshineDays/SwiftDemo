//
//  NewsTitleView.swift
//  IULiao
//
//  Created by levine on 2017/7/25.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
protocol NewsTitleViewDelegate:class {
    func titleView(_ titleView:NewsTitleView, targetIndex:Int)
}
class NewsTitleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegate:NewsTitleViewDelegate?
    var titles = ["全部","推荐","战报","转会","伤病","花絮","篮球"]
    /// 标题数组
    private lazy var titleLabels = [NewsTitleLabel]()
    
    private lazy var currentIndex : Int = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 滚动视图
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth , height: 40))
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    }()
    /// 底部分割线
    private lazy var bottomLineView: UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(r: 255, g: 255, b: 0)
        bottomLine.height = 2
        bottomLine.y = 37
        return bottomLine
    }()
    private func setupTitleLabels()
    {
        for (index,topTitle) in titles.enumerated() {
            let titleLabel = NewsTitleLabel()
            titleLabel.text = topTitle
            titleLabel.font = UIFont.systemFont(ofSize: 16)
            titleLabel.tag = index
            titleLabel.textAlignment = .center
//            titleLabel.backgroundColor = UIColor(r: 255, g: 255, b: 0)
            titleLabel.textColor = index == 0 ? UIColor(r: 255, g: 0, b: 0) : UIColor(r: 0, g: 0, b: 0)
            titleLabel.currentScale = index == 0 ? 1.1 : 1.0
            addSubview(titleLabel)
            titleLabels.append(titleLabel)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick))
            titleLabel.addGestureRecognizer(tapGesture)
            titleLabel.isUserInteractionEnabled = true
        }
    }
    private func setuptitleFrame()
    {
        for (i,label) in titleLabels.enumerated() {
            let w : CGFloat = TSScreen.currentWidth/CGFloat(titleLabels.count)
            let h : CGFloat = 40
            var x : CGFloat = 0
            let y : CGFloat = 0
            if i == 0
            {
                x = 0;
                bottomLineView.x = 0
                bottomLineView.width = TSScreen.currentWidth/CGFloat(titleLabels.count)
            }else
            {
                let preLabel = titleLabels[i-1]
                x = preLabel.frame.maxX
            }
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
//        scrollView.contentSize = CGSize(width: TSScreen.currentWidth, height: 0)
    }
    private lazy var lable:UILabel = {
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
         label.backgroundColor = UIColor.black
         return label
    }()

}
extension NewsTitleView
{
    func setupUI()
    {
       // addSubview(scrollView)
        //scrollView.addSubview(lable)
        backgroundColor = UIColor(r: 240, g: 240, b: 240)
        setupTitleLabels()
        setuptitleFrame()
        addSubview(bottomLineView)
    }
}
extension NewsTitleView{
    //监听点击标题事件
    @objc private func titleLabelClick(_ tapGes : UITapGestureRecognizer)
    {
        //取出用户点击的view -》label
        let targetLabel = tapGes.view as! NewsTitleLabel
        //
        adjustTitleLabel(targetIndex: targetLabel.tag)
        UIView.animate(withDuration: 0.25) { 
            self.bottomLineView.centerX = targetLabel.centerX
        }
        if (delegate != nil)
        {
            delegate?.titleView(self, targetIndex: currentIndex)
        }
    }
    private func adjustTitleLabel(targetIndex:Int)
    {
        //取出label
        if targetIndex == currentIndex{return}
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[currentIndex]
        //切换文字颜色
        targetLabel.textColor = UIColor(r: 255, g: 0, b: 0)//目标变红色
        sourceLabel.textColor = UIColor(r:0,g:0,b:0)//原来至黑色
        //改变大小
        targetLabel.currentScale = 1.1
        sourceLabel.currentScale = 1.0
        //索引记录
        currentIndex = targetIndex
        
        
    }
}
private class NewsTitleLabel: UILabel {
    /// 用来记录当前 label 的缩放比例
    var currentScale: CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
}
