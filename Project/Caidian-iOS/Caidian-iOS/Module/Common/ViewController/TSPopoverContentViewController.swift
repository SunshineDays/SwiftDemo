//
//  TSPopoverViewController.swift
//  IULiao
//
//  Created by tianshui on 16/8/17.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 弹窗
class TSPopoverContentViewController: BaseTableViewController {

    var dataSource = [String]() {
        didSet {
            refreshContentSize()
            tableView.reloadData()
        }
    }
    var popoverItemClickBlock: ((_ index: Int) -> Void)?
    
    var cellHeight: CGFloat = 40 {
        didSet{
            refreshContentSize()
        }
    }
    var contentWidth: CGFloat = 100 {
        didSet{
            refreshContentSize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshContentSize()
        tableView.isScrollEnabled = false
        tableView.separatorColor = UIColor(white: 1, alpha: 0.3)
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

}

extension TSPopoverContentViewController {
    // 内容大小
    private func refreshContentSize(){
        // -2是为了盖住最下面的那根分割线
        let height = CGFloat(dataSource.count) * cellHeight - 2
        preferredContentSize = CGSize(width: contentWidth, height: height)
    }
}

extension TSPopoverContentViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: cellHeight))
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.text = dataSource[indexPath.row]
        cell.addSubview(label)
        cell.backgroundColor = UIColor(hex: 0x333333)
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor(hex: 0x444444)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        popoverItemClickBlock?(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // 去除tableview 分割线不紧挨着左边
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
}
