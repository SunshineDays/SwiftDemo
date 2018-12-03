//
//  NewsTopicCtrl.swift
//  IULiao
//
//  Created by levine on 2017/7/25.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
private let kTopScrollViewHeight :CGFloat = 40.0
//private var kNavbarHeight :CGFloat = 64.0
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (Int, Int, Int) = (85, 85, 85)
private let kSelectColor : (Int, Int, Int) = (255, 128, 0)
class NewsTopicViewController: BaseViewController {

    
    
    //MARK: 标题数组
    
    private lazy var titleLabels : [TopLabel] = [TopLabel]()
    private var titles = ["全部","推荐","战报","转会","伤病","花絮","篮球"]
    private var currentIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        // Do any additional setup after loading the view.
    }

    //MARK:懒加载
    
    private lazy var topScrollView:UIScrollView = {
//        if TSScreen.iPhoneXHeight == TSScreen.currentHeight {
//            kNavbarHeight = 88
//        }else {
//            kNavbarHeight = 64
//        }
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: TSScreen.navigationHeight, width: TSScreen.currentWidth, height: kTopScrollViewHeight));
        scrollView.scrollsToTop = false
        scrollView.backgroundColor = UIColor(r:240,g:240,b:240)
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var contentScrollView:PiazzaScrollView = {
//        if TSScreen.iPhoneXHeight == TSScreen.currentHeight {
//            kNavbarHeight = 88
//        }else {
//            kNavbarHeight = 64
//        }
        let scrollView = PiazzaScrollView(frame: CGRect(x: 0, y: TSScreen.navigationHeight + kTopScrollViewHeight, width: TSScreen.currentWidth, height:TSScreen.currentHeight - TSScreen.navigationHeight - kTopScrollViewHeight));
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    private lazy var scrollLine : UIView = {
        let lineH : CGFloat = 0.5
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    // MARK: - 各种自定义方法
    /**
     准备视图
     */
    private func initView() {
        self.title = "新闻资讯"
        view.addSubview(topScrollView)
        view.addSubview(contentScrollView)
        setuptitleAndContent()
        topScrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: 0, y: topScrollView.frame.height - kScrollLineH, width: CGFloat(view.frame.width / CGFloat(titles.count)), height: kScrollLineH)
    }
    
    private func setuptitleAndContent() {
        // 0.确定label的一些frame的值
        let labelW : CGFloat = view.frame.width / CGFloat(titles.count)
        let labelH : CGFloat = kTopScrollViewHeight - kScrollLineH
        let labelY : CGFloat = 0
        for (index,title) in titles.enumerated() {
            let label = TopLabel()
            label.text = title;
            label.tag = index
            label.scale = index == 0 ? 1.1 : 0.0
            label.textColor = index == 0 ? UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2) : UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.isUserInteractionEnabled = true
            //
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            //
            topScrollView.addSubview(label)
            titleLabels.append(label)
            label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedTopLabel)))
            
            let newVc = NewsListViewController()
            addChildViewController(newVc)
            //预先加载前两页 ，增加用户体验
            if index <= 1 {
                addContentViewController(index)
            }
        }
        contentScrollView.contentSize = CGSize(width: CGFloat(childViewControllers.count) * TSScreen.currentWidth, height: 0)
        
        contentScrollView.isPagingEnabled = true
        contentScrollView.setContentOffset(CGPoint(x: 0, y: contentScrollView.contentOffset.y), animated: true)
    }
    /**
     添加内容控制器
     
     - parameter index: 控制器角标
     */
    private func addContentViewController(_ index:Int) {
        
        //获取需要展示的控制器
        let newsVc = childViewControllers[index] as! NewsListViewController
        
        if newsVc.view.superview != nil {
//            topScrollView.isUserInteractionEnabled = true
            return
        }
        newsVc.view.frame = CGRect(x: CGFloat(index) * TSScreen.currentWidth, y: 0, width: contentScrollView.bounds.width, height: contentScrollView.bounds.height)
        contentScrollView.addSubview(newsVc.view)
        // MAKR: -----传值操作
        switch index {
        case 0:
            newsVc.newsParagram = (nil,nil)//全部
        case 1:
            newsVc.newsParagram = (nil,1)//推荐
        case 2:
            newsVc.newsParagram = (nil,3)//战报
        case 3:
            newsVc.newsParagram = (nil,5165)//转会
        case 4:
            newsVc.newsParagram = (nil,5164)//伤病
        case 5:
            newsVc.newsParagram = (nil,2)//花絮
        case 6:
            newsVc.newsParagram = (2,nil)//篮球
        default:
            break
        }
//        topScrollView.isUserInteractionEnabled = true
        
    }
    /**
     顶部标签的点击事件
     */
    @objc private func didTappedTopLabel(_ gesture: UITapGestureRecognizer) {
//        topScrollView.isUserInteractionEnabled = false
        guard let currentLabel = gesture.view as? TopLabel else {return}
        if currentLabel.tag == currentIndex {return}
        for (_,oldLabel) in titleLabels.enumerated() {
            oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            oldLabel.scale = 0.0
        }
        //let oldLabel = titleLabels[currentIndex];
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        currentLabel.scale = 1.1
       
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
        contentScrollView.setContentOffset(CGPoint(x: CGFloat(currentLabel.tag) * contentScrollView.frame.size.width, y: contentScrollView.contentOffset.y), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
extension NewsTopicViewController:UIScrollViewDelegate {
    //正在滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > CGFloat(titleLabels.count) * scrollView.frame.width || scrollView.contentOffset.x < 0{return}
        // 1.取出sourceLabel/targetLabel.x
        let value = (scrollView.contentOffset.x/scrollView.frame.width)
        
        let scrollLineX = CGFloat(value) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15, animations: {
            self.scrollLine.frame.origin.x = scrollLineX
        })
    }
    // 滚动结束后触发 代码导致
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if currentIndex == Int(index){return}
        let currentLabel = titleLabels[Int(index)]
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        currentLabel.scale = 1.1
        
        let oldLabel = titleLabels[currentIndex];
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        oldLabel.scale = 0.0
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
//        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        
        currentIndex = Int(index)
        addContentViewController(currentIndex)
        
        
    }
    // 滚动结束 手势导致
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
    }
    

}
class TopLabel:UILabel {
    var scale:CGFloat? {
        didSet {
            // 通过scale的改变来改变各种参数
            let minScale : CGFloat = 0.9
            let trueScale = minScale + (1 - minScale) * scale!
            transform = CGAffineTransform(scaleX: trueScale, y: trueScale)

        }
    }
    // MARK: - 构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textAlignment = NSTextAlignment.center
        font = UIFont.systemFont(ofSize: 16.0)
    }
}
class PiazzaScrollView: UIScrollView ,UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (otherGestureRecognizer.view?.isKind(of: NSClassFromString("UILayoutContainerView")!))! {
            if otherGestureRecognizer.state == UIGestureRecognizerState.began && self.contentOffset.x == 0 {
                return true
            }
        }
        return false
        
    }
}
