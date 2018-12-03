//
//  LiveWebViewController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class LiveWebViewController: BaseViewController {
    
    public var url = "https://mm.caidian310.com/live/home2"
    
    /// 是否可以返回
    public var canGoBack = false
    
    private lazy var themeView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.statusBarHeight))
        view.backgroundColor = UIColor.navigationBarTintColor
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 15, y: TSScreen.statusBarHeight, width: 50, height: 44))
        button.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        button.setTitle("      ", for: .normal)
        return button
    }()
    
    private lazy var loadButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: webView.width / 2 - 100, y: webView.height / 2 - 100, width: 200, height: 200)
        button.setTitle("加载失败，点击重试", for: .normal)
        button.setTitleColor(UIColor.logo, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        webView.addSubview(button)
        return button
    }()

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        if #available(iOS 10.0, *) {
            webView.frame = view.frame
        } else {
            webView.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.tabBarHeight(ctrl: self) - TSScreen.statusBarHeight)
        }
        webView.scrollView.bounces = false
        webView.backgroundColor = UIColor.white
        webView.isOpaque = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view.addSubview(webView)
        return webView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.frame = CGRect(x: 0, y: TSScreen.statusBarHeight, width: webView.width, height: 2)
        progressView.trackTintColor = UIColor.clear
        progressView.progressTintColor = UIColor.logo
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        url = url.replacingOccurrences(of: "http:", with: "https:")
        initView()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: TSNotification.willEnterForegroundRefreshData.notification, object: nil)
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
}

extension LiveWebViewController {
    private func initView() {
        webView.addSubview(themeView)
        progressView.setProgress(0.1, animated: true)
        if canGoBack {
            webView.addSubview(backButton)
            backButton.setImage(R.image.icon_goback(), for: .normal)
        }
        webView.load(URLRequest(url: URL(string: url)!))
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addSubview(progressView)
    }
}

extension LiveWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadButton.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isHidden = webView.canGoBack
        hud.hide(animated: true)
        backButton.setImage(nil, for: .normal)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadButton.isHidden = false
    }
}

extension LiveWebViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        progressView.setProgress(0.1, animated: true)
        progressView.isHidden = false
        if object is WKWebView && keyPath == "estimatedProgress" {
            if let change = change {
                let newProgress = change[.newKey] as? Float
                
                if newProgress == 1 {
                    if let newProgress = newProgress {
                        progressView.setProgress(newProgress, animated: true)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            self.progressView.isHidden = true
                            self.progressView.setProgress(0, animated: false)
                        }
                    }
                }
            }
        } else if object is WKWebView && keyPath == "title" {
            
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension LiveWebViewController {
    
    @objc private func refreshData() {
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
    @objc private func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
