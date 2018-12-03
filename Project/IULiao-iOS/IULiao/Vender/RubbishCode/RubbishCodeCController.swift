//
//  RubbishCodeCController.swift
//  TextLotteryBet
//
//  Created by DaiZhengChuan on 2018/5/25.
//  Copyright © 2018年 bin zhang. All rights reserved.
//

import UIKit

class RubbishCodeCController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUserInforData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    let content_array = NSMutableArray()
    
    let title_array = ["真实姓名", "性别", "地区", "详细地址", "邮箱"]
    
    /**  选择了哪一行 */
    var selectedRow = Int()
    
    /**  选择的地址模型 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            switch indexPath.row {
            case 2:
                sexChange()
            case 3:
                cityChange()
            case 4:
                addressChange()
            case 5:
                emailChange()
            default:
                break
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            weakSelf?.postChangeAvater(image: image)
        }
    }
    
    // MArk: - Action
    
    /**  更换头像 */
    @objc func avaterChange() {
        


    }
    
    @objc func changeNickname() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    /**  更换性别 */
    func sexChange() {
        
    }
    
    //选择地址
    @objc func cityChange() {

    }
    
    @objc func cityName(_ notification: Notification) {
        
    }
    
    
    /**  详细地址 */
    func addressChange() {
        
    }
    
    /**  更换邮箱 */
    func emailChange() {
        
    }
    
    /**  刷新内容 */
    func reloadContent(title: String) {
        content_array.replaceObject(at: selectedRow, with: title)
    }
    
    // MARK: - Request
    
    
    func initContentArray() {
        
        content_array.removeAllObjects()
    }
    
    /**  获取用户信息 */
    func getUserInforData() {
        
        _ = NSDictionary()
        
        let _: String?
        
        let dic = NSDictionary()
        
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改个人头像 */
    func postChangeAvater(image: UIImage) {
        
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改昵称 */
    func postChangeNickname(nickname: String) {
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改性别 */
    func postChangeSex(){

    }
    
    /**  修改地址 */
    func postChangeAddress(){

    }
    
    /**  修改邮箱 */
    func postChangeEmail(){

    }
    
}

class RubbishCodeC1Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUserInforData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    let content_array = NSMutableArray()
    
    let title_array = ["真实姓名", "性别", "地区", "详细地址", "邮箱"]
    
    /**  选择了哪一行 */
    var selectedRow = Int()
    
    /**  选择的地址模型 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            switch indexPath.row {
            case 2:
                sexChange()
            case 3:
                cityChange()
            case 4:
                addressChange()
            case 5:
                emailChange()
            default:
                break
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            weakSelf?.postChangeAvater(image: image)
        }
    }
    
    // MArk: - Action
    
    /**  更换头像 */
    @objc func avaterChange() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    @objc func changeNickname() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    /**  更换性别 */
    func sexChange() {
        
    }
    
    //选择地址
    @objc func cityChange() {
        
    }
    
    @objc func cityName(_ notification: Notification) {
        
    }
    
    
    /**  详细地址 */
    func addressChange() {
        
    }
    
    /**  更换邮箱 */
    func emailChange() {
        
    }
    
    /**  刷新内容 */
    func reloadContent(title: String) {
        content_array.replaceObject(at: selectedRow, with: title)
    }
    
    // MARK: - Request
    
    
    func initContentArray() {
        
        content_array.removeAllObjects()
    }
    
    /**  获取用户信息 */
    func getUserInforData() {
        
        _ = NSDictionary()
        
        let _: String?
        
        let dic = NSDictionary()
        
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改个人头像 */
    func postChangeAvater(image: UIImage) {
        
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改昵称 */
    func postChangeNickname(nickname: String) {
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改性别 */
    func postChangeSex(){
        
    }
    
    /**  修改地址 */
    func postChangeAddress(){
        
    }
    
    /**  修改邮箱 */
    func postChangeEmail(){
        
    }
    
}


class RubbishCodeC2Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUserInforData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    let content_array = NSMutableArray()
    
    let title_array = ["真实姓名", "性别", "地区", "详细地址", "邮箱"]
    
    /**  选择了哪一行 */
    var selectedRow = Int()
    
    /**  选择的地址模型 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            switch indexPath.row {
            case 2:
                sexChange()
            case 3:
                cityChange()
            case 4:
                addressChange()
            case 5:
                emailChange()
            default:
                break
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            weakSelf?.postChangeAvater(image: image)
        }
    }
    
    // MArk: - Action
    
    /**  更换头像 */
    @objc func avaterChange() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    @objc func changeNickname() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    /**  更换性别 */
    func sexChange() {
        
    }
    
    //选择地址
    @objc func cityChange() {
        
    }
    
    @objc func cityName(_ notification: Notification) {
        
    }
    
    
    /**  详细地址 */
    func addressChange() {
        
    }
    
    /**  更换邮箱 */
    func emailChange() {
        
    }
    
    /**  刷新内容 */
    func reloadContent(title: String) {
        content_array.replaceObject(at: selectedRow, with: title)
    }
    
    // MARK: - Request
    
    
    func initContentArray() {
        
        content_array.removeAllObjects()
    }
    
    /**  获取用户信息 */
    func getUserInforData() {
        
        _ = NSDictionary()
        
        let _: String?
        
        let dic = NSDictionary()
        
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改个人头像 */
    func postChangeAvater(image: UIImage) {
        
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改昵称 */
    func postChangeNickname(nickname: String) {
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改性别 */
    func postChangeSex(){
        
    }
    
    /**  修改地址 */
    func postChangeAddress(){
        
    }
    
    /**  修改邮箱 */
    func postChangeEmail(){
        
    }
    
}

class RubbishCodeC3Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUserInforData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    let content_array = NSMutableArray()
    
    let title_array = ["真实姓名", "性别", "地区", "详细地址", "邮箱"]
    
    /**  选择了哪一行 */
    var selectedRow = Int()
    
    /**  选择的地址模型 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            switch indexPath.row {
            case 2:
                sexChange()
            case 3:
                cityChange()
            case 4:
                addressChange()
            case 5:
                emailChange()
            default:
                break
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            weakSelf?.postChangeAvater(image: image)
        }
    }
    
    // MArk: - Action
    
    /**  更换头像 */
    @objc func avaterChange() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    @objc func changeNickname() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    /**  更换性别 */
    func sexChange() {
        
    }
    
    //选择地址
    @objc func cityChange() {
        
    }
    
    @objc func cityName(_ notification: Notification) {
        
    }
    
    
    /**  详细地址 */
    func addressChange() {
        
    }
    
    /**  更换邮箱 */
    func emailChange() {
        
    }
    
    /**  刷新内容 */
    func reloadContent(title: String) {
        content_array.replaceObject(at: selectedRow, with: title)
    }
    
    // MARK: - Request
    
    
    func initContentArray() {
        
        content_array.removeAllObjects()
    }
    
    /**  获取用户信息 */
    func getUserInforData() {
        
        _ = NSDictionary()
        
        let _: String?
        
        let dic = NSDictionary()
        
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改个人头像 */
    func postChangeAvater(image: UIImage) {
        
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改昵称 */
    func postChangeNickname(nickname: String) {
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改性别 */
    func postChangeSex(){
        
    }
    
    /**  修改地址 */
    func postChangeAddress(){
        
    }
    
    /**  修改邮箱 */
    func postChangeEmail(){
        
    }
    
}


class RubbishCodeC4Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUserInforData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    let content_array = NSMutableArray()
    
    let title_array = ["真实姓名", "性别", "地区", "详细地址", "邮箱"]
    
    /**  选择了哪一行 */
    var selectedRow = Int()
    
    /**  选择的地址模型 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            switch indexPath.row {
            case 2:
                sexChange()
            case 3:
                cityChange()
            case 4:
                addressChange()
            case 5:
                emailChange()
            default:
                break
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            weakSelf?.postChangeAvater(image: image)
        }
    }
    
    // MArk: - Action
    
    /**  更换头像 */
    @objc func avaterChange() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    @objc func changeNickname() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    /**  更换性别 */
    func sexChange() {
        
    }
    
    //选择地址
    @objc func cityChange() {
        
    }
    
    @objc func cityName(_ notification: Notification) {
        
    }
    
    
    /**  详细地址 */
    func addressChange() {
        
    }
    
    /**  更换邮箱 */
    func emailChange() {
        
    }
    
    /**  刷新内容 */
    func reloadContent(title: String) {
        content_array.replaceObject(at: selectedRow, with: title)
    }
    
    // MARK: - Request
    
    
    func initContentArray() {
        
        content_array.removeAllObjects()
    }
    
    /**  获取用户信息 */
    func getUserInforData() {
        
        _ = NSDictionary()
        
        let _: String?
        
        let dic = NSDictionary()
        
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改个人头像 */
    func postChangeAvater(image: UIImage) {
        
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改昵称 */
    func postChangeNickname(nickname: String) {
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改性别 */
    func postChangeSex(){
        
    }
    
    /**  修改地址 */
    func postChangeAddress(){
        
    }
    
    /**  修改邮箱 */
    func postChangeEmail(){
        
    }
    
}


class RubbishCodeC5Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUserInforData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    let content_array = NSMutableArray()
    
    let title_array = ["真实姓名", "性别", "地区", "详细地址", "邮箱"]
    
    /**  选择了哪一行 */
    var selectedRow = Int()
    
    /**  选择的地址模型 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            switch indexPath.row {
            case 2:
                sexChange()
            case 3:
                cityChange()
            case 4:
                addressChange()
            case 5:
                emailChange()
            default:
                break
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            weakSelf?.postChangeAvater(image: image)
        }
    }
    
    // MArk: - Action
    
    /**  更换头像 */
    @objc func avaterChange() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    @objc func changeNickname() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    /**  更换性别 */
    func sexChange() {
        
    }
    
    //选择地址
    @objc func cityChange() {
        
    }
    
    @objc func cityName(_ notification: Notification) {
        
    }
    
    
    /**  详细地址 */
    func addressChange() {
        
    }
    
    /**  更换邮箱 */
    func emailChange() {
        
    }
    
    /**  刷新内容 */
    func reloadContent(title: String) {
        content_array.replaceObject(at: selectedRow, with: title)
    }
    
    // MARK: - Request
    
    
    func initContentArray() {
        
        content_array.removeAllObjects()
    }
    
    /**  获取用户信息 */
    func getUserInforData() {
        
        _ = NSDictionary()
        
        let _: String?
        
        let dic = NSDictionary()
        
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改个人头像 */
    func postChangeAvater(image: UIImage) {
        
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改昵称 */
    func postChangeNickname(nickname: String) {
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改性别 */
    func postChangeSex(){
        
    }
    
    /**  修改地址 */
    func postChangeAddress(){
        
    }
    
    /**  修改邮箱 */
    func postChangeEmail(){
        
    }
    
}


class RubbishCodeC6Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUserInforData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    let content_array = NSMutableArray()
    
    let title_array = ["真实姓名", "性别", "地区", "详细地址", "邮箱"]
    
    /**  选择了哪一行 */
    var selectedRow = Int()
    
    /**  选择的地址模型 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            switch indexPath.row {
            case 2:
                sexChange()
            case 3:
                cityChange()
            case 4:
                addressChange()
            case 5:
                emailChange()
            default:
                break
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            weakSelf?.postChangeAvater(image: image)
        }
    }
    
    // MArk: - Action
    
    /**  更换头像 */
    @objc func avaterChange() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    @objc func changeNickname() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    /**  更换性别 */
    func sexChange() {
        
    }
    
    //选择地址
    @objc func cityChange() {
        
    }
    
    @objc func cityName(_ notification: Notification) {
        
    }
    
    
    /**  详细地址 */
    func addressChange() {
        
    }
    
    /**  更换邮箱 */
    func emailChange() {
        
    }
    
    /**  刷新内容 */
    func reloadContent(title: String) {
        content_array.replaceObject(at: selectedRow, with: title)
    }
    
    // MARK: - Request
    
    
    func initContentArray() {
        
        content_array.removeAllObjects()
    }
    
    /**  获取用户信息 */
    func getUserInforData() {
        
        _ = NSDictionary()
        
        let _: String?
        
        let dic = NSDictionary()
        
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改个人头像 */
    func postChangeAvater(image: UIImage) {
        
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改昵称 */
    func postChangeNickname(nickname: String) {
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改性别 */
    func postChangeSex(){
        
    }
    
    /**  修改地址 */
    func postChangeAddress(){
        
    }
    
    /**  修改邮箱 */
    func postChangeEmail(){
        
    }
    
}


class RubbishCodeC7Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        getUserInforData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    let content_array = NSMutableArray()
    
    let title_array = ["真实姓名", "性别", "地区", "详细地址", "邮箱"]
    
    /**  选择了哪一行 */
    var selectedRow = Int()
    
    /**  选择的地址模型 */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.title_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WPUserHomePageTitleCellID", for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            switch indexPath.row {
            case 2:
                sexChange()
            case 3:
                cityChange()
            case 4:
                addressChange()
            case 5:
                emailChange()
            default:
                break
            }
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            let image: UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
            weakSelf?.postChangeAvater(image: image)
        }
    }
    
    // MArk: - Action
    
    /**  更换头像 */
    @objc func avaterChange() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    @objc func changeNickname() {
        let dateString = ""
        let resultString = String()
        
        let _  = NSInteger((dateString as NSString).substring(to: 4))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(5, 2)))!
        
        let _ = NSInteger((dateString as NSString).substring(with: NSMakeRange(8, 2)))!
        let _ = resultString
    }
    
    /**  更换性别 */
    func sexChange() {
        
    }
    
    //选择地址
    @objc func cityChange() {
        
    }
    
    @objc func cityName(_ notification: Notification) {
        
    }
    
    
    /**  详细地址 */
    func addressChange() {
        
    }
    
    /**  更换邮箱 */
    func emailChange() {
        
    }
    
    /**  刷新内容 */
    func reloadContent(title: String) {
        content_array.replaceObject(at: selectedRow, with: title)
    }
    
    // MARK: - Request
    
    
    func initContentArray() {
        
        content_array.removeAllObjects()
    }
    
    /**  获取用户信息 */
    func getUserInforData() {
        
        _ = NSDictionary()
        
        let _: String?
        
        let dic = NSDictionary()
        
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改个人头像 */
    func postChangeAvater(image: UIImage) {
        
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改昵称 */
    func postChangeNickname(nickname: String) {
        let dic = NSDictionary()
        for kv in dic {
            print("\n")
            let value = kv.value as AnyObject
            if value.isKind(of: NSClassFromString("__NSCFString")!) {
                print(String(format: "@objc var %@ = String()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFNumber")!) {
                print(String(format: "@objc var %@ = <#NSInteger/Float#>()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("__NSCFBoolean")!) {
                print(String(format: "@objc var %@ = Bool()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSDictionary")!) {
                print(String(format: "@objc var %@ = NSDictionary()", kv.key as! CVarArg))
            }
            else if value.isKind(of: NSClassFromString("NSArray")!) {
                print(String(format: "@objc var %@ = NSArray()", kv.key as! CVarArg))
            }
            else {
                print(String(format: "@objc var %@ = <#category#>()", kv.key as! CVarArg))
            }
        }
    }
    
    /**  修改性别 */
    func postChangeSex(){
        
    }
    
    /**  修改地址 */
    func postChangeAddress(){
        
    }
    
    /**  修改邮箱 */
    func postChangeEmail(){
        
    }
    
}
