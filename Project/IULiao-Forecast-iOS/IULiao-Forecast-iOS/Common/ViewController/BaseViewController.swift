//
//  BaseViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/5.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// UIViewController基类
class BaseViewController: UIViewController {
    
    /// 加载失败提示view
    private lazy var loadFailedView: LoadFailedView = {
        let loadFailedView = LoadFailedView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        loadFailedView.getDataAgainBlock = {
            self.getData()
        }
        view.addSubview(loadFailedView)
        return loadFailedView
    }()
    
    /// 请求是否成功
    private var isRequestSuccess = true
    
    /// 子类调用(请求成功和失败都需要调用)
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - isRequestSuccess: 请求成功与否
    public func tableView(forEmptyDataSet tableView: UITableView?, isRequestSuccess: Bool) {
        self.isRequestSuccess = isRequestSuccess
        tableView?.emptyDataSetDelegate = self
        tableView?.emptyDataSetSource = self
        tableView?.reloadData()
    }
    
    /// 网络错误(没有使用tabelView时调用)
    ///
    /// - Parameter isShow: 是否显示网络错误view
    public func showErrorView(_ isShow: Bool) {
        loadFailedView.isHidden = !isShow
    }
    
    func getData() {
        fatalError("子类必须实现此方法")
    }
    
    @objc func refreshData() {
        fatalError("子类实现此方法，一定是需要后台返回来刷新当前界面")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: UserNotification.refreshCurrentCtrl.notification, object: nil)
    }
    
    deinit {
        log.info("deinit ---------- " + description)
        NotificationCenter.default.removeObserver(self)
        MBProgressHUD.hide(from: view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func getDataAgain(_ sender: UIButton) {
        getData()
    }
}

extension BaseViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return isRequestSuccess ? EmptyRequestType.noData.image : EmptyRequestType.error.image
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return isRequestSuccess ? EmptyRequestType.noData.title : EmptyRequestType.error.title
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true // 是否可以滚动
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        if !isRequestSuccess { getData() }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if !isRequestSuccess { getData() }
    }
}

/// 加载失败提示view
class LoadFailedView: UIView {
    typealias GetDataAgainBlock = () -> Void
    public var getDataAgainBlock: GetDataAgainBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        titleLabel.attributedText = EmptyRequestType.error.title
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(getDataAgain(_:)), for: .touchUpInside)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func getDataAgain(_ sender: UIButton) {
        if let block = getDataAgainBlock {
            block()
        }
    }
}

/// 空数据类型
enum EmptyRequestType {
    /// 网络错误
    case error
    /// 没有数据
    case noData
    
    var image: UIImage {
        switch self {
        case .error: return UIColor.clear.convertToImage()
        case .noData: return UIColor.clear.convertToImage()
        }
    }
    
    var title: NSAttributedString {
        switch self {
        case .error:
            return PublicHelper.attributedString(texts: ["加载失败\n\n", "点击重试"],
                                               fonts: [UIFont.systemFont(ofSize: 21), UIFont.systemFont(ofSize: 15)],
                                               colors: [UIColor.lightGray, UIColor(hex: 0x3B83F7)])
        case .noData:
            return PublicHelper.attributedString(texts: ["暂无数据"],
                                               fonts: [UIFont.systemFont(ofSize: 18)],
                                               colors: [UIColor.lightGray])
        }
    }
}
