//
//  TSBaseWebViewController.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/8/17.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class TSBaseWebViewController: UIViewController {
    
    private lazy var loadButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: webView.width / 2 - 100, y: webView.height / 2 - 100, width: 200, height: 200)
        button.setTitle("加载失败，点击重试", for: .normal)
        button.setTitleColor(UIColor.logo, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        button.isHidden = true
        webView.addSubview(button)
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        if #available(iOS 10.0, *) {
            webView.frame = view.frame
        } else {
            webView.frame = CGRect(x: 0, y: TSScreen.navigationBarHeight(ctrl: self), width: TSScreen.currentWidth, height: TSScreen.currentHeight - TSScreen.navigationBarHeight(ctrl: self))
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
        progressView.frame = CGRect(x: 0, y: 0, width: webView.width, height: 2)
        progressView.trackTintColor = UIColor.clear
        progressView.progressTintColor = UIColor.logo
        return progressView
    }()
    
    private var isFirstFailed = true
    
    public var url = "https://mm.caidian310.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initView()
    }
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension TSBaseWebViewController {
    private func initView() {
        navigationItem.leftBarButtonItems = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icon_goback(), style: .plain, target: self, action: #selector(goBackAction))
        progressView.setProgress(0.1, animated: true)
        webView.load(URLRequest(url: URL(string: url)!))
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        webView.addSubview(progressView)
    }
    
    @objc private func refreshData() {
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
    @objc func goBackAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}

extension TSBaseWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        loadButton.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadButton.isHidden = false
    }
}

extension TSBaseWebViewController {
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
