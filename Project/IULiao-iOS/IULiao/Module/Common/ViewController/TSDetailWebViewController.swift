//
//  TSDetailWebViewController.swift
//  HuaXia
//
//  Created by tianshui on 15/10/21.
// 
//

import UIKit
import GRMustache
import SDWebImage
import MWPhotoBrowser
import SwiftyJSON
import FCFileManager

private var KVOContentSizeContext = "KVOContentSizeContext"
private let KVOContentSize = "contentSize"

/// 适用于详情页
class TSDetailWebViewController: BaseWebViewController {
    
    /// 图片尺寸大小
    var detailWebViewImageSize = CGSize(width: 800, height: 800)
    /// 详情数据
    var detailData = TSHTMLTemplateModel(json: JSON(NSNull()))
    
    var photos: [MWPhoto]? {
        guard let images = self.detailData.images else {
            return nil
        }
        return images.map {
            (ele) -> MWPhoto in
            let url = TSImageURLHelper(string: ele.urlString, size: detailWebViewImageSize).url ?? NSURL(string: "http://placehold.it/200")! as URL
            return MWPhoto(url: url)
        }
    }
    
    /// 重试按钮
    var retryBtn: UIButton = {
        let btn = UIButton(type: UIButtonType.system)
        btn.setTitle("加载失败,请重试", for: UIControlState())
        btn.isHidden = true
        return btn
    }()
    
    /// webview body的高度不是常量会根据自动改变大小
    private var lastWebViewBodyHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.retryBtn)
        
        self.retryBtn.addTarget(self, action: #selector(TSDetailWebViewController.webViewRequestData), for: .touchUpInside)
        self.javascirptBridgeRegisterHander()
        
        self.webView.scrollView.delegate = self
        self.webView.scrollView.addObserver(self, forKeyPath: KVOContentSize, options: .new, context: &KVOContentSizeContext)
        
        self.retryBtn.snp.updateConstraints {
            [weak self](make) -> Void in
            guard let me = self else {
                return
            }
            make.centerX.equalTo(me.view.snp.centerX)
            make.centerY.equalTo(me.view.snp.centerY)
            make.width.equalTo(me.view.snp.width)
            make.height.equalTo(44)
        }
        
        self.view.bringSubview(toFront: self.hud)
    }
    
    deinit {
        self.webView.scrollView.delegate = nil
        if self.webView.scrollView.observationInfo != nil {
            self.webView.scrollView.removeObserver(self, forKeyPath: KVOContentSize, context: &KVOContentSizeContext)
        }
    }
  
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            if let object = object as? UIScrollView {
                if object == webView.scrollView && keyPath == KVOContentSize && context == &KVOContentSizeContext {
                    /// webview内高度变化
                    webView.evaluateJavaScript("document.body.offsetHeight", completionHandler: {
                        (height, error) -> Void in
                        guard let height = height as? CGFloat , self.lastWebViewBodyHeight != height else {
                            return
                        }
                        self.lastWebViewBodyHeight = height
                        self.refreshScrollViewEnabledStatus(self.webView.scrollView)
                    })
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension TSDetailWebViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshScrollViewEnabledStatus(scrollView)
    }

}

// MARK:- method
extension TSDetailWebViewController {
    
    /// 刷新scrollview enable的状态
    func refreshScrollViewEnabledStatus(_ scrollView: UIScrollView) {
        
    }
    
    // MARK:- js注册事件
    func javascirptBridgeRegisterHander() {
        self.bridge.registerHandler("showPhotoBrowser") {
            [weak self] (data, responseCallback) -> Void in
            if let data = data as? Dictionary<String, AnyObject> {
                let index = (data["index"] as? Int) ?? 0
                self?.showPhotoBrowserAtIndex(index)
            }
        }
        
    }

    // MARK:- webview加载数据
    @objc func webViewRequestData() {
        self.hud.show(animated: true)
        self.retryBtn.isHidden = true
    }
    
    /// 处理详情数据 子类可重写
    func dealwithDetailData() {
        var content = self.detailData.content
        content = filterHtmlContentAnchorTag(content)
        if let images = detailData.images {
            content = imagesReplaceHtmlContent(images, html: content)
        }
        self.detailData.content = content
    }
    
    /**
    webView加载数据 子类可重写此方法 f  泛型
    - parameter data:     必须是
    */
    func webViewLoadData<T: TSHTMLTemplateModel>(_ data: T) {
        detailData = data
        dealwithDetailData()
        
        do {
            let contentFile = Bundle.main.path(forResource: "content", ofType: ".html", inDirectory: "Resource.bundle/web/")!
            let template = try GRMustacheTemplate(fromContentsOfFile: contentFile)
            let html = try template.renderObject(detailData)
            let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath + "/Resource.bundle", isDirectory: true)
            webView.loadHTMLString(html, baseURL: baseURL)
        } catch {
            log.error("加载html 失败")
        }
        hud.hide(animated: true)
    }
    
    /**
    过滤富文本html中的a链接(标签)
    - parameter html: 富文本
    - returns: 过滤后的富文本
    */
    func filterHtmlContentAnchorTag(_ html: String) -> String {
        var content = html
        do {
            // 替换news等链接 <a href="http://www.iuliao.com/article/4641.html"></a>
            // 结果href内变为 news://1070 其余不变
            let pattern = "(<a[^>]*href\\s*=\\s*[\"|'])https?://(www|m).iuliao\\.\\w+/news/(\\d+)[^>'\"]*([\"|'][^>]*>)"
            let regexp = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSMakeRange(0, content.count)
            content = regexp.stringByReplacingMatches(in: content, options: .reportProgress, range: range, withTemplate: "$1news://$3$4")
        } catch let e {
            print(e)
        }
        return content
    }
    
    /**
    image替换回富文本中的内容
    - parameter images:   图片数据
    - parameter html:     被替换的富文本
    - parameter cssClass: 图片外div样式 img-photo的图片允许点击 其他的不允许
    - returns: 替换后的富文本
    */
    func imagesReplaceHtmlContent(_ images: [TSHTMLImageModel], html: String, cssClass: String = "img-photo") -> String {
        var content = html
        // 替换img标签
        for (index, img) in images.enumerated() {
            let id = "img" + img.reference.md5
            let str = "<span class='img-wrap'>"
                    +     "<img id='\(id)' data-index='\(index)' src='web/img/no-image-200.jpg' class='placeholder \(cssClass)'/>"
                    + "</span>"
            content = content.replacingOccurrences(of: img.reference, with: str)
        }
        return content
    }
    
    /**
     下载图片并且调用设置图片js
     - parameter imageUrl: 图片url
     - parameter id:       图片在html中的id
     */
    func downloadImageAndCallHandlerByImageUrl(_ imageUrl: URL, withImageID id: String) {

        SDWebImageManager.shared().loadImage(with: imageUrl, options: [.retryFailed, .allowInvalidSSLCertificates], progress: nil) {
            [weak self] (image, data, error, type, finished, url) -> Void in
            
            DispatchQueue.global().async {
                
                let imagePath = SDImageCache.shared().defaultCachePath(forKey: imageUrl.absoluteString)
                let tempPath = FCFileManager.pathForTemporaryDirectory(withPath: "image/\(imageUrl.absoluteString.md5)")!
                
                // 原文件是异步下载的可能不存在 重试10次
                for _ in 0...10 {
                    FCFileManager.copyItem(atPath: imagePath, toPath: tempPath)
                    if FileManager.default.fileExists(atPath: tempPath) {
                        break
                    }
                    usleep(1000)
                }

                DispatchQueue.main.async {
                    guard let me = self else {
                        return
                    }
                    objc_sync_enter(me.bridge)
                    me.bridge.callHandler("setImage", data: ["id": "\(id)", "src": tempPath])
                    objc_sync_exit(me.bridge)
                }
                
            }
        }
    }
    
    /**
    加载图片并写入缓存回调js的设置图片
    - parameter images: 图片s
    */
    func loadImages(_ images: [TSHTMLImageModel]) {
        // 处理图片
        for img in images {
            guard let imageUrl = URL(string: img.urlString) else {
                continue
            }
            downloadImageAndCallHandlerByImageUrl(imageUrl, withImageID: "img" + img.reference.md5)
        }
    }
    
    /**
    加载相关阅读
    - parameter relatives: 相关阅读s
    */
    func loadRelatives(_ relatives: [TSHTMLRelativeModel]) {
        var data = [[String: AnyObject]]()
        for relative in relatives {
            data.append([
                "id"       : relative.id as AnyObject,
                "title"    : relative.title as AnyObject,
                "appurl"   : relative.appURLString as AnyObject,
            ])
        }
        self.bridge.callHandler("setRelatives", data: data)
    }
    
}

// MARK:- 网页加载状态
extension TSDetailWebViewController {
    
    override func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // 载入图片
        if let images = self.detailData.images {
            loadImages(images)
        }
        
        // 载入相关链接
        if let relatives = self.detailData.relatives {
            loadRelatives(relatives)
        }
        
        
        self.hud.hide(animated: true)
    }
    
    override func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hud.hide(animated: true)
        self.retryBtn.isHidden = false
        TSToast.showNotificationWithMessage(error.localizedDescription)
    }
    
    override func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (@escaping (WKNavigationActionPolicy) -> Void)) {

        var policy = WKNavigationActionPolicy.cancel
        
        let urlString = navigationAction.request.url?.absoluteString ?? ""
        
        switch urlString {
        // 新闻资讯
        case let str where str.hasPrefix("news://"):
            let regexp = try? NSRegularExpression(pattern: "\\d+", options: .caseInsensitive)
            if let result = regexp?.firstMatch(in: str, options: .reportProgress, range: NSMakeRange(0, str.count)) {
                let idString = str[result.range.location..<(result.range.location + result.range.length)]
                let id = Int(idString) ?? 0
                let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: id)
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        // 标签搜索
        case let str where str.hasPrefix("newstag://"):
            let keyword = str.replacingOccurrences(of: "newstag://", with: "")
            let ctrl = NewsSearchViewController()
            ctrl.keyword = keyword.removingPercentEncoding
            ctrl.newsSearchType = NewsSearchType.tag
            ctrl.hidesBottomBarWhenPushed = true
            ctrl.navigationItem.hidesBackButton = true
            let nav = UINavigationController(rootViewController: ctrl)
            self.present(nav, animated: true, completion: nil)
        default:
            policy = .allow
        }
        
        // taget="_blank" 的直接新页打开
        if navigationAction.targetFrame == nil {
            if let url = navigationAction.request.url {
                let ctrl = BaseWebBrowserController()
                ctrl.url = url
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        }
        
        decisionHandler(policy)
        
    }
}

// MARK:- MWPhotoBrowserDelegate 图片浏览相关
extension TSDetailWebViewController: MWPhotoBrowserDelegate {
    
    /// 显示图片浏览
    func showPhotoBrowserAtIndex(_ index: Int) {
        let browser = MWPhotoBrowser(delegate: self)
        browser?.setCurrentPhotoIndex(UInt(index))
        self.navigationController?.pushViewController(browser!, animated: true)
    }

    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        guard let count = self.photos?.count else {
            return 0
        }
        return UInt(count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        guard let photos = self.photos else {
            return nil
        }
        let i = Int(index)
        if i < photos.count {
            return photos[i]
        }
        return nil
    }
    
}


