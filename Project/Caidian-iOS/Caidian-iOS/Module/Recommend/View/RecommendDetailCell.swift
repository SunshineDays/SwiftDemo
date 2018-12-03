//
//  RecommendDetailCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/7/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

protocol RecommendDetailCellDelegate: class {
    func recommendDetailCell(_ cell: RecommendDetailCell, didClickAvatarButton sender: UIButton)
    func recommendDetailCell(_ cell: RecommendDetailCell, webViewDidFinishLoad webView: WKWebView, rowHeight: CGFloat)
    func recommendDetailCell(_ cell: RecommendDetailCell, isGray: Bool)
}

class RecommendDetailCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var updateTimeLabel: UILabel!
    @IBOutlet weak var lookNumberLabel: UILabel!
    @IBOutlet weak var giveupImageView: UIImageView!
    
    @IBOutlet weak var avatarButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var order5WinButton: UIButton!

    @IBOutlet weak var orderKeepWinButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var betContentLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var changeTimeLabel: UILabel!
    
    @IBOutlet weak var reasonView: UIView!
    //    @IBOutlet weak var reasonWebView: UIWebView!
    
    private let reasonWebView = WKWebView()
    
    /// 推荐理由距离上面的高度
    @IBOutlet weak var contentLabelTopConstraint: NSLayoutConstraint!
    
    /// 投注表格高度
    @IBOutlet weak var betContentViewHeightConstraint: NSLayoutConstraint!
    
    /// webView的高度
    @IBOutlet weak var reasonViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var title1View: UIView!
    @IBOutlet weak var title2View: UIView!
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var titleALabel: UILabel!
    @IBOutlet weak var titleBLabel: UILabel!
    @IBOutlet weak var titleCLabel: UILabel!
    @IBOutlet weak var titleDLabel: UILabel!
    
    /// 默认选择
    private var selectedIndex = 0
    
    /// 是否已经加载完成webView
    private var isFinishedLoad = false
    
    /// webView 的实际最小高度
    private var minReasonHeight :CGFloat = 0

    /// 是否跳转到新的界面
    private var isShowPushCtrl = false

    private var model: RecommendDetailModel!
    
    weak public var delegate: RecommendDetailCellDelegate?
    
    public func configCell(model: RecommendDetailModel) {
        self.model = model
        if !isFinishedLoad {
            titleLabel.text = "【" + model.recommend.serial + "】" + model.recommend.title
            lookNumberLabel.text = model.recommend.hits.string()
            
            updateTimeLabel.text = TSUtils.timestampToString(model.recommend.updateTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
            
            if let url = TSImageURLHelper(string: model.statistic.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
                avatarButton.sd_setImage(with: url, for: .normal, placeholderImage: R.image.empty.image100x100(), completed: nil)
            } else {
                avatarButton.setImage(R.image.empty.image100x100(), for: .normal)
            }
            nicknameLabel.text = model.statistic.name
            order5WinButton.setTitle(model.order.orderCount.string() + "中" + model.order.win.string(), for: .normal)
            orderKeepWinButton.setTitle(model.statistic.keepWin.string() + "连红", for: .normal)
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
            
            awayTeamLabel.text = model.matchInfo.away
            initTeamInfoViewColor()
            
            if model.historyList.count <= 1 {
                contentLabelTopConstraint.constant = 15
                collectionView.isHidden = true
            }
            resultImageView.image = model.recommend.winStatus.recommendImage

            if let history = model.historyList.first {
                configBetContentView(history: history, isFirstRow: true)
            }
            
            reasonWebView.navigationDelegate = self
            reasonWebView.scrollView.bounces = false
            reasonWebView.scrollView.showsVerticalScrollIndicator = false
            reasonWebView.scrollView.showsHorizontalScrollIndicator = false
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.lineSpacing(9)
        reasonView.addSubview(reasonWebView)
        reasonWebView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
//            make.right.equalToSuperview()
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
        }
        initCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func avatarAction(_ sender: UIButton) {
        delegate?.recommendDetailCell(self, didClickAvatarButton: sender)
    }
}
// MARK: - sdfsdf
extension RecommendDetailCell {

    /// 设置富文本的显示规则
    func setWebviewHtmlString(contentString: String)-> String {
        return """
        <!doctype html>
        <html>
        <head>
           <meta charset='utf-8'/>
           <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=no'/>
           <meta name='format-detection' content='telephone=no' />
           <link href='web/label/labelContent.css' rel='stylesheet'/>
        </head>
        <body>
        <article id='content'>
        \(contentString)
        </article>
        </body>
        </html>
        """
    }

    private func initCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 70, height: 40)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(R.nib.recommendDetailChangeTitleCell)
        collectionView.showsHorizontalScrollIndicator = false
    }

    private func configBetContentView(history: RecommendDetailhistoryListtModel, isFirstRow: Bool) {
        betContentViewHeightConstraint.constant = CGFloat(85 + (history.code.count > 2 ? (history.code.count - 2) * 16 : 0))
        betContentLabel.attributedText = TSFootballBetHelper.betAttributedString(match: model.matchInfo,
                                                                            betKeyList: history.code,
                                                                               letBall: Int(model.recommend.odds.letBall))
        if model.recommend.isShow {
            if isFirstRow {
                initNormalViewColor(history: history)
                delegate?.recommendDetailCell(self, isGray: false)
            } else {
                initGrayViewColor(history: history)
                delegate?.recommendDetailCell(self, isGray: true)
            }
        } else { /// 放弃了
            titleLabel.textColor = UIColor(hex: 0xB3B3B3)
            giveupImageView.isHidden = false
            initGrayViewColor(history: history)
            delegate?.recommendDetailCell(self, isGray: true)
            changeTimeLabel.isHidden = isFirstRow
        }
    }
    
    /// 正常颜色
    private func initNormalViewColor(history: RecommendDetailhistoryListtModel) {
        changeTimeLabel.isHidden = true
        resultImageView.image = model.recommend.winStatus.recommendImage
        let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath + "/Resource.bundle", isDirectory: true)
        reasonWebView.loadHTMLString(setWebviewHtmlString(contentString: history.reason), baseURL: baseURL)

        initTeamInfoViewColor()
        awayTeamLabel.textColor = UIColor(hex: 0x4D4D4D)
        betContentLabel.attributedText = TSFootballBetHelper.betAttributedString(match: model.matchInfo,
                                                                            betKeyList: history.code,
                                                                               letBall: Int(model.recommend.odds.letBall))
        title1View.backgroundColor = UIColor(hex: 0xFF4422)
        title2View.backgroundColor = UIColor(hex: 0xFF4422)
        title1Label.textColor = UIColor(hex: 0xFF4422)
        title2Label.textColor = UIColor(hex: 0xFF4422)
        titleALabel.textColor = UIColor(hex: 0x4D4D4D)
        titleBLabel.textColor = UIColor(hex: 0x4D4D4D)
        titleCLabel.textColor = UIColor(hex: 0x4D4D4D)
        titleDLabel.textColor = UIColor(hex: 0x4D4D4D)
    }
    
    /// 变灰了
    private func initGrayViewColor(history: RecommendDetailhistoryListtModel) {
        changeTimeLabel.isHidden = false
        changeTimeLabel.text = "修改时间：" + history.updateTime.timestampToString(withFormat: "MM-dd HH:mm", isIntelligent: false)
        resultImageView.image = nil

        let htmlString = "<style>.gray-color * {color:#b3b3b3 !important}</style><div class='gray-color'>\(history.reason)</div>"
    
        let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath + "/Resource.bundle", isDirectory: true)
        reasonWebView.loadHTMLString(setWebviewHtmlString(contentString: htmlString), baseURL: baseURL)

        homeTeamLabel.textColor = UIColor(hex: 0xB3B3B3)
        awayTeamLabel.textColor = UIColor(hex: 0xB3B3B3)
        vsLabel.textColor = UIColor(hex: 0xB3B3B3)
        betContentLabel.textColor = UIColor(hex: 0xB3B3B3)
        title1View.backgroundColor = UIColor(hex: 0xB3B3B3)
        title2View.backgroundColor = UIColor(hex: 0xB3B3B3)
        title1Label.textColor = UIColor(hex: 0xB3B3B3)
        title2Label.textColor = UIColor(hex: 0xB3B3B3)
        titleALabel.textColor = UIColor(hex: 0xB3B3B3)
        titleBLabel.textColor = UIColor(hex: 0xB3B3B3)
        titleCLabel.textColor = UIColor(hex: 0xB3B3B3)
        titleDLabel.textColor = UIColor(hex: 0xB3B3B3)
    }
    
    private func initTeamInfoViewColor() {
        var letBall = model.recommend.odds.letBall > 0 ? "+" + model.recommend.odds.letBall.decimal(0) : model.recommend.odds.letBall.decimal(0)
        letBall = "(\(letBall))"
        letBall = model.recommend.odds.letBall != 0 ? letBall : ""
        let letBallColor =  model.recommend.odds.letBall > 0 ? UIColor(hex: 0xFF3333) : UIColor(hex: 0x00AAFF)
        homeTeamLabel.attributedText = TSPublicTool.attributedString(texts: [letBall, model.matchInfo.home], colors: [letBallColor, UIColor(hex: 0x4D4D4D)])
        if model.recommend.winStatus == .notOpen {
            vsLabel.text = TSUtils.timestampToString(model.matchInfo.matchTime, withFormat: "MM-dd HH:mm", isIntelligent: false)
            vsLabel.textColor = UIColor(hex: 0xB3B3B3)
            titleBLabel.text = "开赛时间"
        } else {
            vsLabel.attributedText = TSPublicTool.attributedString(texts: ["半 " + (model.matchInfo.halfScore ?? "0:0"), "\n全 " + (model.matchInfo.score ?? "0:0")], colors: [UIColor(hex: 0xFF4422), UIColor(hex: 0x00AAFF)])
            titleBLabel.text = "比分"
        }
    }
}

extension RecommendDetailCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.historyList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.recommendDetailChangeTitleCell, for: indexPath)!
        cell.configCell(model: model.historyList[indexPath.row], isShow: selectedIndex == indexPath.row, isFirstRow: indexPath.row == 0)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isShowPushCtrl = false
        selectedIndex = indexPath.row
        collectionView.reloadData()
        configBetContentView(history: model.historyList[indexPath.row], isFirstRow: indexPath.row == 0)
        isFinishedLoad = false
    }
}

extension RecommendDetailCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        let vc = TSBaseWebViewController()
        vc.url = navigationResponse.response.url?.absoluteString ?? ""
        
        TSPublicTool.rootViewController().pushViewController(vc, animated: true)
        decisionHandler(WKNavigationResponsePolicy.cancel)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isShowPushCtrl = true
        if !isFinishedLoad { // 避免循环调用刷新
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
                if let s = self {
                    s.isFinishedLoad = true
                    webView.evaluateJavaScript("document.getElementById('content').offsetHeight", completionHandler: { (result, error) in
                        let height = result as! CGFloat
                        s.reasonViewHeightConstraint.constant = height
                        let rowHeight = s.reasonView.frame.origin.y + height
                        s.delegate?.recommendDetailCell(s, webViewDidFinishLoad: webView, rowHeight: rowHeight)
                    })
                }
            }
        }
    }
}

//extension RecommendDetailCell: UIWebViewDelegate {
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        if isShowPushCtrl {
//            webView.stopLoading()
//            let vc = TSBaseWebViewController()
//            vc.url = (request.url?.absoluteString)!
//            TSPublicTool.rootViewController().pushViewController(vc, animated: true)
//        }
//        return true
//    }
//
//
//
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        isShowPushCtrl = true
//        if !isFinishedLoad { // 避免循环调用刷新
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
//                if let s = self {
//                    s.isFinishedLoad = true
//                    let height: Float = Float(webView.stringByEvaluatingJavaScript(from: "document.getElementById('content').offsetHeight") ?? "300.0") ?? 300
//                    s.reasonWebViewHeightConstraint.constant = CGFloat(height)
//                    let rowHeight = s.reasonWebView.frame.origin.y + CGFloat(height)
//                    s.delegate?.recommendDetailCell(s, webViewDidFinishLoad: webView, rowHeight: rowHeight)
//                }
//            }
//        }
//    }
//
////    func webViewDidStartLoad(_ webView: UIWebView) {
////
////        ///  解决webView内容填充高度问题  用最小的webView高度重新约束下 加载结束之后 重新赋值高度
////        if self.reasonWebViewHeightConstraint.constant < minReasonHeight {
////            minReasonHeight = self.reasonWebViewHeightConstraint.constant
////        }
////        self.reasonWebView.scrollView.contentSize.height = minReasonHeight
////    }
//}

