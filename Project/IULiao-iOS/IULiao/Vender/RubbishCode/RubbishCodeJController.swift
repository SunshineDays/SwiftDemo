//
//  RubbishCodeJController.swift
//  TextLotteryBet
//
//  Created by DaiZhengChuan on 2018/5/25.
//  Copyright © 2018年 bin zhang. All rights reserved.
//

import UIKit

class RubbishCodeJController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }

    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true

        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {

    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {

    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {

    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {

    }
    
    //删除选中的商品
    @objc func deleteAction() {

    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {

        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}

class RubbishCodeJ1Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}


class RubbishCodeJ2Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}


class RubbishCodeJ3Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}


class RubbishCodeJ4Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}


class RubbishCodeJ5Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}


class RubbishCode6JController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}


class RubbishCodeJ7Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}


class RubbishCodeJ8Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}


class RubbishCodeJ9Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "购物车"
        
        if self.navigationItem.leftBarButtonItem == nil {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: nil, style: .plain, target: self, action: #selector(self.goBackAction))
            bottomHeight = 23
        }
        
        self.view.addSubview(cart_view)
        self.view.addSubview(edit_view)
        
        //        getEShopCartListData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushToOrderLisVc() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isRefresh {
            getEShopCartListData()
        }
        else {
            isRefresh = true
        }
    }
    
    /**  是否刷新数据 */
    var isRefresh = true
    
    /**  选择的总价 */
    var totalMoney = Double()
    
    /**  选择的总数 */
    var totalNumber: NSInteger = 0
    
    /**  根据是否显示TabBar调节UI TableView高度 */
    var bottomHeight: CGFloat = 0
    
    /**  是否是编辑状态 */
    var isEdit = false
    
    let cart_array = NSMutableArray()
    
    //去结算
    lazy var cart_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - 32 - 55, width: 123, height: 55))
        view.isHidden = true
        
        return view
    }()
    
    //编辑
    lazy var edit_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 123 - 32 - bottomHeight - 55, width: 32, height: 55))
        view.isHidden = true
        return view
    }()
    
    //购物车为空
    lazy var cartEmpty_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 123, height: self.view.frame.size.height))
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 12, width: 32, height: 3123 - 32 - bottomHeight - 55), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.register(UINib.init(nibName: "WPEShopShoppingCartCell", bundle: nil), forCellReuseIdentifier: "WPEShopShoppingCartCellID")
        self.view.addSubview(tableView)
        return tableView
    }()
    
    // MARK: - UITableViewDataSoure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShoppingCartCellID", for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == nil || textField.text?.count == 0 {
        }
        else {
        }
        totalAction()
    }
    
    // MARK: - Action
    
    //返回易购付
    @objc func goBackAction() {
        let animation = CATransition()
        animation.duration = 0.25
        animation.type = kCATransitionMoveIn
        UIApplication.shared.keyWindow?.layer.add(animation, forKey: "animation")
        UserDefaults.standard.synchronize()
    }
    
    //去到商城首页
    @objc func goToHomePageAction() {
        self.tabBarController?.selectedIndex = 0
    }
    
    //编辑
    @objc func editAction() {
        isEdit = !isEdit
        self.navigationItem.rightBarButtonItem?.title = isEdit ? "完成" : "编辑"
        if isEdit {
        }
        else {
        }
        cart_view.isHidden = isEdit
        edit_view.isHidden = !isEdit
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: false)
    }
    
    //减少数量
    @objc func minusAction(_ button: UIButton) {
        
    }
    
    //增加数量
    @objc func addAction(_ button: UIButton) {
        
    }
    
    //选中单个商品
    @objc func selectedOneAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中全部商品
    @objc func selectedAllAction(_ button: UIButton) {
        totalAction()
    }
    
    //选中商品的总价/数量
    func totalAction() {
        
    }
    
    //去结算选中的商品
    @objc func payAction() {
        if totalNumber == 0 {
        }
        else {
            postToPayData()
        }
    }
    
    //收藏选中的商品
    @objc func loveAction() {
        
    }
    
    //删除选中的商品
    @objc func deleteAction() {
        
    }
    
    //刷新数据改变购物车状态
    func changeViewConfig(array: NSMutableArray) {
        
        isEdit = false
    }
    
    //判断购物车是否为空
    func showCartEmptyView(array: NSMutableArray) {
        if array.count > 0 {
            cartEmpty_view.isHidden = true
        }
        else {
            cartEmpty_view.isHidden = false
        }
    }
    
    
    //MARK: - Request
    
    //获取购物车列表
    @objc func getEShopCartListData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    //去结算
    func postToPayData() {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
    
    //修改商品数量
    func postChangeCartShopNumberData(cartID: NSInteger, productID: NSInteger, number: NSInteger) {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 231, height: 123)
        scrollView.backgroundColor = UIColor.white
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213, width: 123, height: 34))
        view.backgroundColor = UIColor.white
    }
    
    //删除选中的商品
    func postDeleteShopData(array: NSMutableArray, indexPathArray: NSMutableArray) {
        let button = UIButton()
        button.frame = CGRect(x: 15, y: 35, width: 132 - 30, height: 45)
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 12
    }
    
}




