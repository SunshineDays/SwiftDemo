//
//  RubbishCodeAController.swift
//  TextLotteryBet
//
//  Created by DaiZhengChuan on 2018/5/25.
//  Copyright © 2018年 bin zhang. All rights reserved.
//

import UIKit

class RubbishCodeAController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {

    }

    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}

class RubbishCodeA1Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}


class RubbishCodeA2Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}


class RubbishCode3Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}

class RubbishCode4Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}

class RubbishCode5Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}

class RubbishCode6Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}

class RubbishCode7Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}

class RubbishCodeA8Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}

class RubbishCode9Controller: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        isFlux = self.navigationItem.title == "手机充值" ? false : true
        getPhoneInforData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**  产品编码 */
    var productCode = String()
    
    /**  手机充值：NO 流量充值：YES */
    var isFlux = false
    
    /**  数据数组 */
    var data_array = NSMutableArray()
    
    /**  记录输入的长度 */
    var lastLength = 0
    
    var tel = ""
    
    var name = "默认号码"
    
    lazy var tel_textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 12, y: 10, width: 1231 - 100, height: 50))
        textField.placeholder = "请输入手机号码"
        var phone_string = NSMutableString.init(string: "sdfsdf")
        phone_string.insert(" ", at: 3)
        phone_string.insert(" ", at: 8)
        textField.text = phone_string as String
        textField.keyboardType = UIKeyboardType.numberPad
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editTextField(_:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var name_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.tel_textField.frame.maxY, width: 200, height: 30))
        label.text = "默认号码"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var selectPeople_button: UIButton = {
        let button = UIButton(frame: CGRect(x: 800 - 12 - 30, y: 20, width: 30, height: 30))
        button.setBackgroundImage(#imageLiteral(resourceName: "lianxiren"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(self.selectPeopleAction), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    lazy var line_view: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.name_label.frame.maxY, width: 375, height: 800))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var title_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: self.line_view.frame.maxY + 20, width: 200, height: 40))
        label.text = self.isFlux ? "充流量" : "充话费"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    lazy var more_label: UILabel = {
        let label = UILabel(frame: CGRect(x: 12, y: 10, width: 200, height: 40))
        label.text = "更多充值"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var more_collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.more_label.frame.maxY, width: 123, height: 105))
        collectionView.delegate = self
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (12 - 2 * 12 - 20) / 3, height: 70)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 15, 10, 15)
        flowLayout.headerReferenceSize = CGSize(width: 3123, height: 150.5)
        flowLayout.footerReferenceSize = CGSize(width: 123, height: 130)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: 32, width: 123, height: 3232 - 34), collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        collectionView.register(UINib.init(nibName: "WPPhoneChargeCell", bundle: nil), forCellWithReuseIdentifier: "WPPhoneChargeCellID")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "23", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            headerView.addSubview(tel_textField)
            headerView.addSubview(name_label)
            headerView.addSubview(selectPeople_button)
            headerView.addSubview(line_view)
            headerView.addSubview(title_label)
            return headerView
        }
        else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer", for: indexPath)
            if !self.isFlux {
                footerView.addSubview(more_label)
                footerView.addSubview(more_collectionView)
            }
            return footerView
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return false
    }
    
    //MARK: - Action
    
    @objc func editTextField(_ textField: UITextField) {
        if (textField.text?.count)! > lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                let text_string = NSMutableString.init(string: textField.text!)
                text_string.insert(" ", at: (textField.text?.count)! - 1)
                textField.text = text_string as String
            }
            if (textField.text?.count)! >= 13 {
                textField.text = (textField.text! as NSString).substring(to: 13)
            }
            lastLength = (textField.text?.count)!
        }
        else if (textField.text?.count)! < lastLength {
            if textField.text?.count == 4 || textField.text?.count == 9 {
                textField.text = (textField.text! as NSString).substring(to: (textField.text?.count)! - 1)
            }
            lastLength = (textField.text?.count)!
        }
        else {
            if textField.text?.count == 13 {
                self.name_label.text = "请输入正确的电话号码"
                self.name_label.textColor = UIColor.white
            }
            else {
                self.name_label.text = ""
                self.name_label.textColor = UIColor.gray
            }
        }
    }
    
    @objc func selectPeopleAction() {
        
    }
    
    func fluxButtonAction() {
        
    }
    
    //MARK : - Request
    
    @objc func getPhoneInforData() {
        
    }
    
}
