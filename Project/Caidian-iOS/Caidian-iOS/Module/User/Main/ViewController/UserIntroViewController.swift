//
//  UserIntroViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/6/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 用户中心 未登录
class UserIntroViewController: BaseTableViewController {
    
    @IBOutlet var fixedButtons: [UIButton]!

//    @IBOutlet weak var titleMenuLabel: UILabel!
//
//    @IBOutlet weak var titleMenuLabelLayoutConstraint: NSLayoutConstraint!
    override func viewDidLoad() {

        super.viewDidLoad()
        
        initView()
        
    }

    // 去除tableview 分割线不紧挨着左边
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        let navbarImageV = self.findHairlineImageViewUnder(view: (navigationController?.navigationBar)!)
        navbarImageV?.isHidden = true
        super.viewWillAppear(animated)
    }

}


// MARK:- method
extension UserIntroViewController {
    
    private func initView() {

        if #available(iOS 11.0, *) {
//            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = true
        }
//        if TSScreen.currentHeight == TSScreen.iPhoneXHeight {
//            titleMenuLabelLayoutConstraint.constant = 54
//        }else {
//            titleMenuLabelLayoutConstraint.constant = 32
//        }
        //titleMenuLabel.font = UIFont.boldSystemFont(ofSize: 17)
        tableView.tableFooterView = UIView()
//        let offset: CGFloat = 6
//        fixedButtons.forEach {
//            btn in
//            let imageSize = btn.imageView!.frame.size
//            let titleSize = btn.titleLabel!.intrinsicContentSize
//            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -imageSize.height - offset, right: 0)
//            btn.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - offset, left: 0, bottom: 0, right: -titleSize.width)
//        }
    }
    func findHairlineImageViewUnder(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.classForCoder()) && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }else {
            for view  in view.subviews {
                let imageV = self.findHairlineImageViewUnder(view: view)
                if imageV != nil {
                    return imageV
                }
            }
            return nil
        }
    }
    
}

// MARK:- UITableViewDataSource
extension UserIntroViewController {
    
    // 去除tableview 分割线不紧挨着左边
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
    }
}
