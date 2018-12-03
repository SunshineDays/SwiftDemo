//
//  HomeNewsDetailViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/10/14.
//  Copyright © 2015年 fenlan. All rights reserved.
//

import UIKit
import SnapKit
import WebKit

/// 资讯详情页
class HomeNewsDetailViewController: BaseViewController {

    var newsId: Int!
    private var newsDetailHandler = HomeHandler()
    private var webView = WKWebView()
    
    private lazy var loadButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: TSScreen.currentWidth / 2 - 100, y: TSScreen.currentHeight / 2 - 100, width: 200, height: 200)
        button.setTitle("加载失败，点击重试", for: .normal)
        button.setTitleColor(UIColor.logo, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItems = nil
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.icon_goback(), style: .plain, target: self, action: #selector(goBackAction))
        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
        edgesForExtendedLayout = UIRectEdge.bottom
        
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.snp.makeConstraints {
            make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()

        }
        webView.addSubview(loadButton)
        webViewRequestData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func refreshData() {
        webViewRequestData()
    }
    
    @objc func goBackAction() {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func webViewRequestData() {
        TSToast.showLoading(view: view)

        newsDetailHandler.detail(
                newsId: newsId,
                success: {
                    news in
                    let url: String = self.newsUrl(news: news)
                    self.title = news.title
                    self.webView.loadHTMLString(url, baseURL: nil)
                    TSToast.hideHud(for: self.view)

                },
                failed: {
                    error in
                    self.loadButton.isHidden = false
                    TSToast.hideHud(for: self.view)
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                })
    }
}

extension HomeNewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        MBProgressHUD.showProgress(toView: view)
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        MBProgressHUD.hide(for: view)
        let vc = TSBaseWebViewController()
        vc.url = navigationResponse.response.url?.absoluteString ?? ""

        navigationController?.pushViewController(vc, animated: true)
        decisionHandler(WKNavigationResponsePolicy.cancel)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        MBProgressHUD.hide(for: view)
        loadButton.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        MBProgressHUD.hide(for: view)
        loadButton.isHidden = false
    }
    
}

extension HomeNewsDetailViewController {
    private func newsUrl(news: HomeNewsDetailModel) -> String {
        let date = Date(timeIntervalSince1970: news.createdTime).string(format: "MM-dd HH:mm:ss")
        let body = """
        <!doctype html>
        <html>
        <head>
            <meta charset='utf-8'/>
            <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=no'/>
            <meta name='format-detection' content='telephone=no' />
            <style type="text/css">
            html{font-family:sans-serif;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}
            body{margin:0}
            article,aside,details,figcaption,figure,footer,header,hgroup,main,menu,nav,section,summary{display:block}
            audio,canvas,progress,video{display:inline-block;vertical-align:baseline}
            audio:not([controls]){display:none;height:0}
            [hidden],template{display:none}
            a{background-color:transparent}
            a:active,a:hover{outline:0}
            abbr[title]{border-bottom:1px dotted}
            b,strong{font-weight:700}
            dfn{font-style:italic}
            h1{font-size:2em;margin:.67em 0}
            mark{background:#ff0;color:#000}
            small{font-size:80%}
            sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}
            sup{top:-.5em}
            sub{bottom:-.25em}
            img{border:0}
            svg:not(:root){overflow:hidden}
            figure{margin:1em 40px}
            hr{box-sizing:content-box;height:0}
            pre{overflow:auto}
            code,kbd,pre,samp{font-family:monospace,monospace;font-size:1em}
            button,input,optgroup,select,textarea{color:inherit;font:inherit;margin:0}
            button{overflow:visible}
            button,select{text-transform:none}
            button,html input[type=button],input[type=reset],input[type=submit]{-webkit-appearance:button;cursor:pointer}
            button[disabled],html input[disabled]{cursor:default}
            button::-moz-focus-inner,input::-moz-focus-inner{border:0;padding:0}
            input{line-height:normal}
            input[type=checkbox],input[type=radio]{box-sizing:border-box;padding:0}
            input[type=number]::-webkit-inner-spin-button,input[type=number]::-webkit-outer-spin-button{height:auto}
            input[type=search]{-webkit-appearance:textfield;box-sizing:content-box}
            input[type=search]::-webkit-search-cancel-button,input[type=search]::-webkit-search-decoration{-webkit-appearance:none}
            fieldset{border:1px solid silver;margin:0 2px;padding:.35em .625em .75em}
            legend{border:0;padding:0}
            textarea{overflow:auto}
            optgroup{font-weight:700}
            table{border-collapse:collapse;border-spacing:0}
            td,th{padding:0}

            body {
                font-family:helvetica;
                padding-top:20px;
                background: #ffffff;
                overflow-x: hidden;
            }
            iframe {
                width: 100%;
                height: auto;
                overflow-x: scroll;
            }

            .clearfix:after,
            .clear:after{
                content: "";
                display: block;
                height: 0;
                clear: both;
                visibility: hidden;
            }

            /* 头部 */
            #header {
                margin: 0 15px;
            }
            #header .title {
                font-size: 21px;
                font-weight: bolder;
                color: #000;
                margin: 0 0 5px
            }
            #header .subtitle {
                position: relative;
                font-size: 11px;
                color: #747474;
            }
            #header .subtitle span.author {
                margin-right: 10px;
            }
            #header .subtitle a.author {
                text-decoration: none;
                color: #0091FF;
            }
            #header .subtitle .right {
                float: right;
            }
            #header .subtitle .comment-hits {
                margin-right: 5px;
            }
            #header .subtitle i {
                display: inline-block;
                margin-right: 3px;
                vertical-align: -2px;
                width: 12px;
                height: 12px;
            }
            #header .subtitle .comment-hits-icon {
                background: url('../img/icon-hit.png') no-repeat;
                background-size: 12px;
            }
            #header .subtitle .comment-count-icon {
                vertical-align: -3px;
                background: url('../img/icon-comment.png') no-repeat;
                background-size: 10px;
            }

            /* content */
            #content {
                position: relative;
                overflow: hidden;
                font-size: 16px;
                word-wrap: break-word;
                text-align: justify;
                margin: 15px;
                color: #505050;
                line-height: 1.647;
                -webkit-box-pack: justify;
                -webkit-justify-content: space-between;
                justify-content: space-between;
            }
            #content video {
                width: 100%;
            }
            #content .table-wrap {
                width: 100%;
                overflow-x: scroll;
            }
            #content table {
                margin: 0 auto;
                max-width: 300%;
                font-size: 14px;
                border-spacing: 0;
                border-collapse: collapse;
            }
            #content table td {
                border: 1px solid #dadada;
                padding: 2px;
                width: 1px; /* 自动宽度 */
                white-space: nowrap;
                vertical-align: middle;
            }
            #content img {
                display: block;
                margin: 0 auto;
                max-width: 100%;
                background: #efefef;
                transition: max-width 0.3s ease-in 0s;
            }
            #content img.placeholder{
                max-width: 100px;
            }
            #content .img-wrap ~ br {
                display: none;
            }
            #content span[href] {
                color: #555;
            }
            #content p {
                word-wrap: break-word;
                text-align: justify;
                margin: 1em 0;
                color: #505050;
                line-height: 1.647 !important;
                background-color: initial !important;
            }
            </style>
        </head>
        <body>
        <header id='header'>
            <h1 class='title'>\(news.title)</h1>
            <div class='subtitle'>
               <time>\(date)</time>
            </div>
        </header>
        <article id='content'>
            \(news.content)
        </article>
        </body>
        </html>
        """

        return body
    }
}
