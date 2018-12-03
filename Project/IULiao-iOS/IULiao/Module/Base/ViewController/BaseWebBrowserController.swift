//
//  BaseWebBrowserController.swift
//  HuaXia
//
//  Created by tianshui on 15/10/15.
// 
//

import UIKit
import WebKit
import SnapKit
import MJRefresh
import MBProgressHUD

/// web浏览器 适用于直接浏览网页
class BaseWebBrowserController: BaseViewController {
    
    var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let bounds = UIScreen.main.bounds
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height ), configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    /// 网址 必须
    var url: URL!
    
    /// 下拉刷新更新key nil则不显示最后更新时间
    var lastUpdatedTimeKey: String?
    
    /// 自动设置网页title为controller title
    var isAutoSetTitle = true
    
    private var isLoaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
         initView()
    }

    private func initView() {
        view.backgroundColor = UIColor.white
        webView.navigationDelegate = self
        //        webView.uiDelegate = self
        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(self.webView)
        let header = MJRefreshNormalHeader {
            [weak self] () -> Void in
            let _ = self?.webView.reload()
        }
        
        if let key = lastUpdatedTimeKey {
            header?.lastUpdatedTimeKey = key
        } else {
            header?.lastUpdatedTimeLabel.isHidden = true
        }
        
        webView.scrollView.mj_header = header
    }
    deinit {
        log.info("deinit")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isLoaded {
            let request = URLRequest(url: url)
            webView.load(request)
            isLoaded = true
            view.bringSubview(toFront: hud)
            hud.show(animated: true)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        webView.snp.updateConstraints {
            make in
            make.top.equalTo(view).offset(topLayoutGuide.length)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        let y = -(UIScreen.main.bounds.height - view.frame.height) / 2
        hud.offset.y = y
    }
    
     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if isAutoSetTitle {
            title = webView.title
        }
        webView.scrollView.mj_header?.endRefreshing()
        hud.hide(animated: true)
    }
    
     func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hud.hide(animated: true)
        webView.scrollView.mj_header?.endRefreshing()
        TSToast.showNotificationWithMessage(error.localizedDescription)
    }
    
}
extension BaseWebBrowserController: WKNavigationDelegate {
    // 发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (@escaping (WKNavigationActionPolicy) -> Void)) {

        if navigationAction.navigationType == .linkActivated {
            let urlString = navigationAction.request.url?.absoluteString
            if let urlString = urlString, let ctrl = TSURLHelper.urlToViewController(urlString) {
                navigationController?.pushViewController(ctrl, animated: true)
                decisionHandler(.cancel)
                return
            }
        }else {
            if let urlString = navigationAction.request.url?.absoluteString {
                if urlString.contains("/single/football2/oddshistory1/") {
                    let ctrl =  TSURLHelper.urlToViewController(urlString)
                    if let ctrl = ctrl {
                        navigationController?.pushViewController(ctrl, animated: true)
                        decisionHandler(.cancel)
                        return
                    }
                    decisionHandler(.allow)
                    return
                }
            }
        }

        // 允许
        decisionHandler(.allow)
    }
    
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        log.error(error.localizedDescription)
    }
    

    

}
