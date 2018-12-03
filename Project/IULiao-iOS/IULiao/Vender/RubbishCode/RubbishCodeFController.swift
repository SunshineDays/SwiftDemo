//
//  RubbishCodeFController.swift
//  TextLotteryBet
//
//  Created by DaiZhengChuan on 2018/5/25.
//  Copyright © 2018年 bin zhang. All rights reserved.
//

import UIKit
//import ContactsUI

class RubbishCodeFController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)

        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
    
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {

        
    }
    
    
    @objc func confirmAction() {

    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {

    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {

    }
    
    
    
}



class RubbishCodeF1Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
//
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
    
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    
    
}


class RubbishCodeF2Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
    
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    
    
}


class RubbishCodeF3Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
    
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    
    
}


class RubbishCodeF4Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
//
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    
    
}


class RubbishCodeF5Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
    
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    
    
}


class RubbishCodeF6Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
    
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    
    
}


class RubbishCodeF7Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
//
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    
    
}


class RubbishCodeF8Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
    
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    
    
}


class RubbishCodeF9Controller: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = isAddAddress ? "地址" : "地址"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /** 是否是添加收货地址
     *  true:是添加收货地址  false:是编辑收货地址
     */
    var isAddAddress = true
    /**  是否设置为默认收货地址 */
    var isDefault = false
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 5345 / 13, height: 90)
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(self.view.frame.size.height - 105, 0, 15, 0)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        return flowLayout
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 123, height: self.view.frame.size.height), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib.init(nibName: "WPHomeClassCell", bundle: nil), forCellWithReuseIdentifier: "WPHomeClassCellID")
        return collectionView
    }()
    
    
    lazy var city_button: UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 54, y: 5, width: 60, height: 40))
        button.setTitle("城市", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar.init(frame: CGRect.init(x: self.city_button.frame.maxX, y: 10, width: 123 - 60 - 123 * 2, height: 30))
        searchBar.placeholder = "搜家"
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.layer.borderWidth = 24
        searchBar.backgroundColor = UIColor.clear
        searchBar.subviews[0].subviews[0].removeFromSuperview()
        return searchBar
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: self.searchBar.frame.maxY + 10, width: self.view.frame.size.width, height: self.view.frame.size.width * 318 / 966)
        return scrollView
    }()
    
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 32 / 2 - 80, y: 20, width: 160, height: 43.5))
        label.text = "选择时间"
        label.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 2))
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var left_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 20, width: 70, height: 43.5))
        button.setTitle("取消", for: UIControlState.normal)
        button.setTitleColor(UIColor.clear, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.leftButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var right_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 123123 - 70, y: 20, width: 70, height: 43.5))
        button.setTitle("完成", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(self.rightButtonAction(_:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.left_button.frame.maxY, width: 123, height: 0.5))
        view.backgroundColor = UIColor.yellow
        return view
    }()
    
    @objc func leftButtonAction(_ button: UIButton) {
    }
    
    @objc func rightButtonAction(_ button: UIButton) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopMyAddressEditCellID", for: indexPath)
        
        return cell
    }
    
    
    // MARK: - CNContactPickerDelegate
    
//    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
//        let phoneNumber: CNPhoneNumber = contactProperty.value as! CNPhoneNumber
//
//        let label = UILabel()
//        label.text = phoneNumber.stringValue
//
//    }
    
    // MARK: - Action
    
    @objc func selectPeopleAction() {
//        let store = CNContactStore()
//        weak var weakSelf = self
//        store.requestAccess(for: CNEntityType.contacts) { (granted, error) in
//            if granted {
//                let pickerView = CNContactPickerViewController()
//                pickerView.delegate = self
//                weakSelf?.present(pickerView, animated: true, completion: nil)
//            }
//            else {
//            }
//        }
    }
    
    @objc func cityAction() {
    }
    
    @objc func cityName(_ notification: Notification) {
        
        
    }
    
    
    @objc func confirmAction() {
        
    }
    
    // MARK: - Request
    
    //添加收货地址
    func postAddAddressData(name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
    //修改收货地址
    func postEditAddressData(addressID : NSInteger, name: String, code: String, tel: String, address: String, company: String, isDefault: String) {
        
    }
    
}





