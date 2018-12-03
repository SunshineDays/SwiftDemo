//
//  RubbishCodeHController.swift
//  TextLotteryBet
//
//  Created by DaiZhengChuan on 2018/5/25.
//  Copyright © 2018年 bin zhang. All rights reserved.
//

import UIKit

class RubbishCodeHController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {

    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {

    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {

        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()

        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
                         "quantity" : quantity,
                         "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {

    }
 
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}


class RubbishCodeH1Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}



class RubbishCodeH2Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}



class RubbishCodeH3Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}



class RubbishCodeH4Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}



class RubbishCodeH5Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}



class RubbishCodeH6Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}



class RubbishCodeH7Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}



class RubbishCodeH8Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}



class RubbishCodeH9Controller: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentedControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  选择数量 */
    var selectNumber = "1"
    
    var isRefreshImage = false
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl.init(items: ["商品详情", "评价"])
        segmentedControl.tintColor = UIColor.white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(self.segmentedAction(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var footer_view: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 213 - 123 - 50, width: 123, height: 50))
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 12, width: 3123, height: 313 - 323 - 50))
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
        scrollView.contentSize = CGSize.init(width: 13 * 2, height: 32 - 32 - 50)
        self.view.addSubview(scrollView)
        return scrollView
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentedControl.selectedSegmentIndex = scrollView.contentOffset.x >= 1312 ? 1 : 0
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 323, height: 33 - 33 - 50), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "WPEShopShopDetailHeaderCell", bundle: nil), forCellReuseIdentifier: "WPEShopShopDetailHeaderCellID")
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    //评价
    lazy var evalutate_tableView: UIView = {
        let tableView = UIView.init(frame: CGRect.init(x: 123, y: 0, width: 132, height: 123 - 32 - 50))
        self.scrollView.addSubview(tableView)
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isRefreshImage ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            let image = image_array[indexPath.row] as? UIImage
            return 13 * ((image?.size.height)! - 0.5) / (image?.size.width)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailHeaderCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPEShopShopDetailImageCellID", for: indexPath)
            return cell
        }
    }
    
    
    // MRRK: - Action
    
    @objc func segmentedAction(_ segment: UISegmentedControl) {
        scrollView.setContentOffset(CGPoint.init(x: 21321 * CGFloat(segment.selectedSegmentIndex), y: 0), animated: true)
    }
    
    //选择商品属性
    @objc func selectAction() {
        let view = UIView()
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    let select_dic = NSMutableDictionary()
    
    @objc func loveAction(_ button: UIButton) {
        if button.imageView?.image == nil {
        }
        else {
        }
    }
    
    @objc func cartAction(_ button: UIButton) {
        
    }
    
    //添加到购物车
    @objc func addToCartAction(_ button: UIButton) {
        if select_dic.count == 0 {
            selectAction()
        }
        else {
            postAddToCartData(product_id: 213, quantity: selectNumber)
        }
    }
    
    func reloadImage(images: NSArray) {
        for _ in 0 ..< images.count {
            image_array.add(UIImage.init(named: "13")!)
        }
        
    }
    
    let image_array = NSMutableArray()
    
    // MARK: - Request
    
    /**  获取评价列表 */
    func getEvalutateListData(id: NSInteger) {
        
    }
    
    /**  获取商品详情 */
    func getShopDetailData(id: NSInteger) {
        
        getShopDetailSpecificationData(id: id)
        getEvalutateListData(id: id)
        getLoveState(id: id)
    }
    
    /**  获取的属性信息数据 */
    let category_array = NSMutableArray()
    
    func getShopDetailSpecificationData(id: NSInteger) {
    }
    
    //添加到购物车
    func postAddToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLoveState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLoveShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    //取消收藏
    func postDeleteLoveData(array: NSMutableArray) {
        
    }
    
    
    //添加到购物车
    func postAddsToCartData(product_id: NSInteger, quantity: String) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : product_id,
             "quantity" : quantity,
             "options" : json ?? ""] as [String : Any]
    }
    
    //获取该商品的收藏状态
    func getLovseState(id: NSInteger) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
    /**  移入收藏 */
    func postLovseShopData(array: NSMutableArray) {
        
        let ids_dic = NSMutableDictionary()
        
        let data = try?JSONSerialization.data(withJSONObject: ids_dic, options: .prettyPrinted)
        let json = String.init(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        _ = ["product_id" : "product_id",
             "quantity" : "quantity",
             "options" : json ?? ""] as [String : Any]
    }
    
}






