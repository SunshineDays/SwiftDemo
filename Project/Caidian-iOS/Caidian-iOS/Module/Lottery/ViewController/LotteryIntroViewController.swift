//
// Created by tianshui on 2018/5/10.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation
import WebKit
import SnapKit

/// 彩种玩法介绍
class LotteryIntroViewController: BaseViewController {

    private let webView = WKWebView()
    var lottery: LotteryType!

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        getData()
    }


    private func initView() {
        title = "玩法介绍"
        automaticallyAdjustsScrollViewInsets = false

        view.backgroundColor = UIColor.white
        view.addSubview(webView)

        webView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }

    private func getData() {
        TSToast.showLoading(view: view)
        LotteryIntroHandler().intro(
                lottery: lottery,
                success: {
                    intro in
                    TSToast.hideHud(for: self.view)
                    self.loadWebView(intro: intro)
                },
                failed: {
                    error in
                    TSToast.hideHud(for: self.view)
                    TSToast.showText(view: self.view, text: error.localizedDescription)
                })
    }

    private func loadWebView(intro: String) {
        let html = """
            <!doctype html>
            <html>
            <head>
                <meta charset="utf-8">
                <title>玩法介绍</title>
                <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=1" name="viewport">
            </head>
            <body>
            \(intro)
            </body>
            </html>
            """
        webView.loadHTMLString(html, baseURL: nil)
    }
}
