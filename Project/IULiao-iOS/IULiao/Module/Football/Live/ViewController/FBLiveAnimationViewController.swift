//
//  FBLiveAnimationViewController.swift
//  IULiao
//
//  Created by levine on 2017/9/12.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import MBProgressHUD

class FBLiveAnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public var matchId: Int!
    
    private var url: URL! {
        return URL(string: "https://m.\(kBaseDomain)/single/matchlive/\(matchId!)/single2")
    }
    
    /// 网址 必须
    private var hudPro: MBProgressHUD?
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
//        configuration.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: CGRect(x: 0, y: TSScreen.statusBarHeight, width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.statusBarHeight), configuration: configuration)
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.backgroundColor = UIColor(r: 51, g: 51, b: 51)
//        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    lazy var backgView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.statusBarHeight))
        view.backgroundColor = UIColor(r: 51, g: 51, b: 51)
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = R.image.icon.mainBack()
        button.setImage(R.image.icon.mainBack(), for: .normal)
        button.frame = CGRect(x: 5, y: TSScreen.statusBarHeight, width: 40, height: 44)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
}

extension FBLiveAnimationViewController {
    private func initView() {
        view.addSubview(webView)
        view.addSubview(backgView)
        view.addSubview(backButton)
        hudPro = TSToast.hudNormalLoad(view: view, text: "动画直播")
        webView.load(URLRequest(url: url))
    }
    
    @objc private final func backButtonAction() {
        _ = navigationController?.popViewController(animated: true)
    }
}

extension FBLiveAnimationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hudPro?.hide(animated: true)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hudPro?.hide(animated: true)
    }

}
