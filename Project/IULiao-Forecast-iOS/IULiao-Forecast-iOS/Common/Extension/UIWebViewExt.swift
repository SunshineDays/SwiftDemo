//
//  UIWebViewExt.swift
//  XCHelperTool-iOS
//
//  Created by Sunshine Days on 2018/8/21.
//  Copyright © 2018年 Sunshine Days. All rights reserved.
//

import UIKit
import WebKit

extension UIWebView {
    var jsWidth: CGFloat {
        let width: Float = Float(stringByEvaluatingJavaScript(from: "document.getElementById('content').offsetWidth") ?? "0.0") ?? 0.0
        return CGFloat(width)
    }
    
    var jsHeight: CGFloat {
        let height: Float = Float(stringByEvaluatingJavaScript(from: "document.getElementById('content').offsetHeight") ?? "0.0") ?? 0.0
        return CGFloat(height)
    }
}

extension WKWebView {
    var jsWidth: CGFloat {
        var width: CGFloat = 0
        evaluateJavaScript("document.getElementById('content').offsetWidth", completionHandler: { (result, error) in
            width = result as! CGFloat
        })
        return width
    }
    
    var jsHeight: CGFloat {
        var height: CGFloat = 0
        evaluateJavaScript("document.getElementById('content').offsetHeight", completionHandler: { (result, error) in
            height = result as! CGFloat
        })
        return height
    }
}

