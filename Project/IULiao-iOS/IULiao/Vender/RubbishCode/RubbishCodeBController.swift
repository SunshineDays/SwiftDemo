//
//  RubbishCodeBController.swift
//  TextLotteryBet
//
//  Created by DaiZhengChuan on 2018/5/25.
//  Copyright © 2018年 bin zhang. All rights reserved.
//

import UIKit

class RubbishCodeBController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}


class RubbishCodeB1Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}



class RubbishCodeB2Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}


class RubbishCodeB3Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}


class RubbishCodeB4Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}


class RubbishCodeB5Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}


class RubbishCodeB6Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}


class RubbishCodeB7Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}


class RubbishCodeB8Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "消息详情"
        scrollView.addSubview(title_label)
        scrollView.addSubview(content_label)
        scrollView.addSubview(date_label)
        scrollView.contentSize = CGSize(width: 23, height: date_label.frame.maxY + 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var scrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var content_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var date_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdffs: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrolsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var titlsdse_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contesssnt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var asdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsdfdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdssdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var sdcrollView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var title_dsdlabel: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var contensdt_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var datesd_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosfsdllView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var tisdtsfle_label: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sdsdsfdsfsdf: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fssdddfsd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var scrosdsflsdlView: UIScrollView = {
        let tempScrollView = UIScrollView(frame: CGRect(x: 0, y: 2, width: 234, height: 423 - 43))
        self.view.addSubview(tempScrollView)
        return tempScrollView
    }()
    
    lazy var sd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 23, y: 10, width: 4234, height: 44))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var ssssd: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 12, y: self.title_label.frame.maxY, width: 323, height: 313))
        tempLabel.text = "content_string"
        tempLabel.font = UIFont.systemFont(ofSize: 43)
        tempLabel.textAlignment = NSTextAlignment.center
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var sssssss: UILabel = {
        let tempLabel = UILabel(frame: CGRect(x: 43, y: self.content_label.frame.maxY, width: 43, height: 43))
        tempLabel.font = UIFont.systemFont(ofSize: 123)
        tempLabel.textAlignment = NSTextAlignment.right
        tempLabel.numberOfLines = 0
        return tempLabel
    }()
    
    lazy var fsddsfdsfdsffdsf: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    
    lazy var fsdfdsfdfdsdff: UITableView = {
        var tableView = UITableView (frame: CGRect(x: 0, y: 0, width: 34324, height: 4324 - 43), style:UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "WPTitleTitleCell", bundle: nil), forCellReuseIdentifier: "WPTitleTitleCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
}
