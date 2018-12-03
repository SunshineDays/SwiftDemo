//
//  NewsDetailViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/10/14.
//  Copyright © 2015年 fenlan. All rights reserved.
//

import UIKit
import MBProgressHUD

/// 资讯详情页
class NewsDetailViewController: TSDetailWebViewController {
    
    var newsId: Int!
    
    var newsDetailHandler = NewsDetailHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webViewRequestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func webViewRequestData() {
        super.webViewRequestData()
        
        newsDetailHandler.executeFetchNewsDetail(
            newsId,
            success: {
                [weak self] (news) -> Void in
                self?.title = news.title
                self?.webViewLoadData(news)
                
            },
            failed: {
                [weak self] (error) -> Void in
                guard let me = self else {
                    return
                }
                MBProgressHUD.hide(for: me.view, animated: true)
                me.retryBtn.isHidden = false
                TSToast.showNotificationWithMessage(error.localizedDescription)
        })
    }
    
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        super.webView(webView, didFinish: navigation)
        let news = self.detailData as! NewsModel
        var data = [[String: Any]]()
        for t in news.tags {
            data.append([
                "title"    : t,
                "appurl"   : "newstag://\(t)"
            ])
        }
        self.bridge.callHandler("setTags", data: data)
    }
}
