//
//  BaseWebViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/10/14.
// 
//

import UIKit
import WebKit
import SnapKit
import MJRefresh
import MBProgressHUD
import MWPhotoBrowser
import CRToast

/// webview 需自己实现加载内容
class BaseWebViewController: BaseViewController {

    var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        let bounds = UIScreen.main.bounds
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height ), configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    var bridge: WKWebViewJavascriptBridge = WKWebViewJavascriptBridge()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.backgroundColor = UIColor.white
     
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        
        self.bridge = WKWebViewJavascriptBridge(for: self.webView)
        self.bridge.setWebViewDelegate(self)
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.webView)
        self.initViewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.initViewConstraints()
    }

    private func initViewConstraints() {
        webView.snp.updateConstraints {
            make in
            make.top.equalTo(view).offset(topLayoutGuide.length)
            make.bottom.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
    
    deinit {
        log.info("webview deinit")
    }
}

/// WKUIDelegate
extension BaseWebViewController: WKUIDelegate {
   
    // MARK: - 重写alert confirm prompt
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: webView.title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default) {
            (action) -> Void in
            completionHandler()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: webView.title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "取消", style: .default) {
            (aciton) -> Void in
            completionHandler(false)
        }
        let action2 = UIAlertAction(title: "确定", style: .default) {
            (action) -> Void in
            completionHandler(true)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: webView.title, message: prompt, preferredStyle: .alert)
        alert.addTextField {
            (textField) -> Void in
            textField.text = defaultText
        }
        let action1 = UIAlertAction(title: "取消", style: .default) {
            (aciton) -> Void in
            completionHandler(nil)
        }
        let action2 = UIAlertAction(title: "确定", style: .default) {
            (action) -> Void in
            completionHandler(alert.textFields?.first?.text)
        }
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
}

/// WKNavigationDelegate
extension BaseWebViewController: WKNavigationDelegate {
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (@escaping (WKNavigationActionPolicy) -> Void)) {
        
        if navigationAction.navigationType == .linkActivated {
            let urlString = navigationAction.request.url?.absoluteString
            if let urlString = urlString, let ctrl = TSURLHelper.urlToViewController(urlString) {
                navigationController?.pushViewController(ctrl, animated: true)
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        log.error(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        log.error(error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // nothing
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // nothing
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // nothing
    }
}
