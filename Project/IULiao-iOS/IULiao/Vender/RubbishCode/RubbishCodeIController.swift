//
//  RubbishCodeIController.swift
//  TextLotteryBet
//
//  Created by DaiZhengChuan on 2018/5/25.
//  Copyright © 2018年 bin zhang. All rights reserved.
//

import UIKit

class RubbishCodeIController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {

        }
        else {

        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}


class RubbishCodeI1Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI2Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI3Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI4Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI5Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI6Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI7Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI8Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI9Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}



class RubbishCodeI10Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "选择地区"
        
        switch selectedType_int {
        case 1:
            key_string = "provinceName"
            array_string = "citylist"
            getCityData()
        case 2:
            key_string = "cityName"
            array_string = "arealist"
        case 3:
            key_string = "areaName"
        default:
            break
        }
        
        self.header_View.addSubview(title_label)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var data_array = NSArray()
    
    /**  当前界面展示数据类型 */
    var selectedType_int = Int()
    /**  字典的key值 */
    var key_string = String()
    /**  value对应的数组 */
    var array_string = String()
    
    var province_string = String()
    var city_string = String()
    
    lazy var title_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var header_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var titwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tableView: UITableView = {
        var tempTableView = UITableView(frame: CGRect(x: 0, y: 0, width: 123, height: 32 - 312), style:UITableViewStyle.plain)
        tempTableView.backgroundColor = UIColor.clear
        tempTableView.tableHeaderView = self.header_View
        tempTableView.tableFooterView = UIView()
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.register(UINib.init(nibName: "WPUserInforsCell", bundle: nil), forCellReuseIdentifier: "WPUserInforsCellID")
        self.view.addSubview(tempTableView)
        return tempTableView
    }()
    
    
    lazy var cancel_button: UIButton = {
        let tempButton = UIButton()
        tempButton.frame = CGRect(x: 0, y: self.view.frame.height - 12 + 1, width: self.view.frame.width, height: 123 - 1)
        tempButton.backgroundColor = UIColor.white
        tempButton.setTitle("取消", for: UIControlState.normal)
        tempButton.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        tempButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        tempButton.addTarget(self, action: #selector(self.dismissShareView), for: UIControlEvents.touchUpInside)
        return tempButton
    }()
    
    @objc func dismissShareView() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3, animations: {
            weakSelf?.view.alpha = 0
        }) { (finished) in
        }
    }
    
    lazy var white_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: self.cancel_button.frame.maxY, width: 123, height: 34))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var tit21le: String! = nil {
        didSet {
            next_button.setTitle(title, for: UIControlState.normal)
        }
    }
    
    lazy var next_button: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
        return button
    }()
    
    /**  轮播图高度 */
    let scrollerView_hieght: CGFloat = 123213 * 584 / 1080
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: self.scrollerView_hieght)
        scrollView.backgroundColor = UIColor.white
        scrollView.delegate = self
        return scrollView
    }()
    
    
    
    lazy var tiwtwle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var heeeader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    lazy var tirqtle_label: UILabel = {
        let tempLabel = UILabel()
        tempLabel.frame = CGRect(x: 12, y: 10, width: 32, height: 30)
        tempLabel.text = self.province_string + "  " + self.city_string
        tempLabel.textColor = UIColor.darkGray
        tempLabel.font = UIFont.systemFont(ofSize: 13)
        return tempLabel
    }()
    
    lazy var herrader_View: UIView = {
        let tempView = UIView()
        tempView.frame = CGRect(x: 0, y: 0, width: 123, height: 40)
        tempView.frame.size.height = self.province_string == "" ? 10 : 40
        return tempView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserInforsCellID", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedType_int != 3 {
            
        }
        else {
            
        }
        
    }
    
    // MARK: - Data
    func getCityData() {
        let plist_string: String = Bundle.main.path(forResource: "areaArray", ofType: "plist")!
        let plist_array = NSArray.init(contentsOfFile: plist_string)
        self.data_array = plist_array!
    }
    
}






