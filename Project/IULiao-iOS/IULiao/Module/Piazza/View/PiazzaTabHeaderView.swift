//
//  PiazzaTabHeaderView.swift
//  IULiao
//
//  Created by levine on 2017/7/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SnapKit

class PiazzaTabHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var piazzaParagram: (type: PiazzaHotMarchType?, mactchModel: FBLiveMatchModel?, birefModel: PiazzaBirefModel?, url: String?) {
        didSet {
            // 赛前数据
            if piazzaParagram.0 == PiazzaHotMarchType.brief {
                
                
                addSubview(birfContentView)
                birfContentView.configContent(birefModel: piazzaParagram.2!, matchModel: piazzaParagram.1!)
                birfContentView.snp.makeConstraints({ (make) in
                    make.left.equalTo(self)
                    make.right.equalTo(self)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                })
                webView.snp.removeConstraints()
                webView.removeFromSuperview()
            // 比赛中数据
            } else if piazzaParagram.0 == PiazzaHotMarchType.animation {
                webView.load(URLRequest(url: URL(string:(piazzaParagram.url)!)!))
                addSubview(webView)
                webView.snp.makeConstraints({ (make) in
                    make.left.equalTo(self)
                    make.right.equalTo(self)
                    make.top.equalTo(self)
                    make.bottom.equalTo(self)
                })
                addSubview(actiView)
                actiView.snp.makeConstraints({ (make) in
                    make.center.equalTo(self)
                    make.width.height.equalTo(30)
                })
                actiView.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5, execute: {
                    [weak self] in
                    self?.actiView.stopAnimating()
                })
                birfContentView.snp.removeConstraints()
                birfContentView.removeFromSuperview()
            //无数据
            } else {
                webView.snp.removeConstraints()
                birfContentView.snp.removeConstraints()
                webView.removeFromSuperview()
                birfContentView.removeFromSuperview()
//                webView.isHidden = true
//                birfContentView.isHidden = true
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 3,正在直播展示 的界面
    private lazy var webView:WKWebView = {
        [weak self] in
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    private lazy var actiView : UIActivityIndicatorView = {
        [weak self] in
        let actiView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        //actiView.backgroundColor = UIColor.magenta
        actiView.hidesWhenStopped = true
        actiView.color = UIColor.black
        return actiView
    }()
    //赛前展示
    private lazy var birfContentView:PiazzaHeaderContentView = {
        [weak self] in
        let birfContentView = Bundle.main.loadNibNamed("PiazzaHeaderContentView", owner: nil, options: nil)?.last as! PiazzaHeaderContentView
        birfContentView.delegate = self
        //birfContentView.frame = (self?.bounds)!
        return birfContentView
    }()

}
extension PiazzaTabHeaderView {
}
extension PiazzaTabHeaderView:WKNavigationDelegate,PiazzaHeaderContentViewDelegate {
    
    func clickAction(_ piazzaHeaderContentView: PiazzaHeaderContentView, clickAction button: UIButton) {

        //比赛结束，选择资讯页面，比赛进行中选择详情页
        let tab = self.piazzaParagram.1!.stateType == .over ? FBMatchMainViewController.MatchType.analyze(.event) : .news
        let ctrl = TSEntryViewControllerHelper.fbMatchMainViewController(matchId: self.piazzaParagram.1!.id, lottery: .jingcai, selectedTab: tab)
        ctrl.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        actiView.stopAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    
    }
    
}
