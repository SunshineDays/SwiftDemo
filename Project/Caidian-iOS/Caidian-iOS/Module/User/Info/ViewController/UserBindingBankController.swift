//
//  UserBindingBankController.swift
//  Caidian-iOS
//  用户中心 ->  绑定银行卡
//  Created by mac on 2018/4/26.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import ActionSheetPicker_3_0

class UserBindingBankController: BaseViewController {

    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var bankBranchTextField: UITextField!
    
    @IBOutlet weak var bankCradTextField: UITextField!
    @IBOutlet weak var bankCradRepeatTextField: UITextField!
    
    @IBOutlet weak var bankButton: UIButton!
    @IBOutlet weak var provinceButton: UIButton!
    
    @IBOutlet weak var bindView: UIView!
    
    @IBOutlet weak var noBindBankView: UIView!
    @IBOutlet weak var bankBankNameLebal: UILabel!
    @IBOutlet weak var bindBankCardCodeLebal: UILabel!
    @IBOutlet weak var commitButton: UIButton!
    /// 市Id
    private var selectBankCityId: Int? = nil
    /// 选择器中的银行省id变量
    private var actionSelectBankProvinceId: Int? = nil
    ///选 择器中的 市Id变量
    private var actionSelectBankCityId: Int? = nil
    /// 选择器中的银行id变量
    private var actionSelectBankId: Int? = nil
    // 当前是选择器是否是银行选择器
    var isBankPickerBool = false
    

    
    let userHandler = UserLoginHandler()
    let cityHelp = TSCityHelper()
    var bankList = [BankModel]()


    /// 银行省id
    private var selectBankProvinceId: Int? = nil {
        didSet {

            if selectBankProvinceId == nil || selectBankCityId == nil {
                provinceButton.setTitle("请选择省份", for: UIControlState.normal)
                provinceButton.setTitleColor(UIColor.cellSeparatorBackground, for: UIControlState.normal)
                return
            }
            let provinceAndCity = cityHelp.getProvinceNameFromId(provinceId: selectBankProvinceId!) + cityHelp.getCityNameFromId(cityId: selectBankCityId!)
            provinceButton.setTitle(provinceAndCity, for: .normal)
            provinceButton.setTitleColor(UIColor.grayGamut.gamut333333, for: UIControlState.normal)
        }
    }


    /// 银行id
    private var selectBankId: Int? = nil{
        didSet{
            if selectBankId == nil {
                bankButton.setTitle("请选择银行", for: .normal)
                bankButton.setTitleColor(UIColor.cellSeparatorBackground, for: UIControlState.normal)
                return
            }

            bankButton.setTitle(bankList.filter { $0.id == selectBankId }.first?.name ?? "" ,for :.normal)
            bankButton.setTitleColor(UIColor.grayGamut.gamut333333, for: UIControlState.normal)
        }
    }



    override func viewDidLoad() {
    
        
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = []

        TSToast.showLoading(view: self.view)
        cityHelp.initCityHelp()
        requestBankList()

    
      

    }

    ///省份选择器
    @IBAction func provinceButtonClick(_ sender: UIButton) {
        isBankPickerBool = false
        showActionSheetPicker(title:  "选择省份")
    }

    ///银行选择器
    @IBAction func bankButtonClick(_ sender: UIButton) {
        isBankPickerBool = true
        showActionSheetPicker(title:  "选择银行")
    }


    ///初始化选择器
    func showActionSheetPicker(title:String) {
        view.endEditing(true)
        let actionSheetPicker = ActionSheetCustomPicker(
            title:title,
            delegate: self,
            showCancelButton: true,
            origin: view
        )
        actionSheetPicker?.toolbarButtonsColor = UIColor.logo
        actionSheetPicker?.setDoneButton(UIBarButtonItem(title: "确定", style: .done, target: self, action: nil))
        actionSheetPicker?.setCancelButton(UIBarButtonItem(title: "取消", style: .plain, target: self, action: nil))
        actionSheetPicker?.show()
    }
    

    ///绑定银行卡
    @IBAction func bindBankCommitButton(_ sender: UIButton) {


        let check = UserRegisterHandler.check(
                realName: userNameTextFiled.text,
                bankId: selectBankId,
                bankProvinceId: selectBankProvinceId,
                bankCityId: selectBankCityId,
                bankBranch: bankBranchTextField.text,
                bankCard: bankCradTextField.text,
                bankRepeatCard: bankCradRepeatTextField.text
        )

        if !check.isValid {
            TSToast.showText(view: view, text: check.msg)
            return
        }
        
   
        userHandler.requestBindingBank(
                bankBranch: bankBranchTextField.text!,
                bankCityId: selectBankCityId!,
                backCode: bankCradTextField.text!,
                bankId: selectBankId!,
                bankProvinceId: selectBankProvinceId!,
                success: {
                    (userRealAuthBeanModel) in
                    TSToast.showText(view: self.view, text: "银行卡已绑定")
                    self.bindBankSuccess()
    
                    self.setBankInfo(bankId : userRealAuthBeanModel.bankId,bankCardCode: userRealAuthBeanModel.bankCode)
                    
                },
                failed: {
                    (it) in
                     TSToast.showText(view: self.view, text: it.localizedDescription, color: .error)
                }
        )
    }


    /**
     * 银行列表网络请求
     **/
    func requestBankList() {
        userHandler.requestBankList(
                success: {
                    (it) in
                    self.bankList = it
                    
                    if UserToken.shared.userInfo?.isBindBank ?? false {
                        self.bindBankSuccess()
                        self.requestRealNameInfo()
                    }else{
                        self.showNoBindBankView()
                    }
                    
                   TSToast.hideHud(for: self.view)

                },
                failed: {
                    (error) in
                    TSToast.hideHud(for: self.view)
                    TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
                })
    }
    
    
    
    /// 实名认证信息
    func requestRealNameInfo() {
    
        UserRealNameHandler().requestRealNameDetail(
            success: {
                (it) in
                self.setBankInfo(bankId : it.bankId,bankCardCode: it.bankCode)
            },
            failed: {
                (error) in
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
        }
        )
        
    }
    
    /// 设置银行卡信息

    func setBankInfo(bankId:Int,bankCardCode :String)  {
        self.bindBankCardCodeLebal.text = "尾号\(bankCardCode[(bankCardCode.count-4)..<(bankCardCode.count)])"
        self.bankBankNameLebal.text = bankList.first{ $0.id == bankId}?.name
    }

    /// 绑定银行卡完成操作
    func bindBankSuccess() {
        noBindBankView.isHidden = true
        commitButton.isHidden = true
        bindView.isHidden = false
    }
    
    //未绑定银行卡
    func showNoBindBankView(){
       noBindBankView.isHidden = false
        commitButton.isHidden = false
        bindView.isHidden = true
    }
}

extension UserBindingBankController: ActionSheetCustomPickerDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if isBankPickerBool {
            return 1
        }
        return 2


    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if isBankPickerBool {
            return bankList.count
        }

        if component == 0 {
            return cityHelp.provinceList.count
        }

        return cityHelp.provinceList.filter({ $0.id == actionSelectBankProvinceId ?? selectBankProvinceId }).first?.children.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isBankPickerBool {
            return bankList[safe: row]?.name
        }
        if component == 0 {
            return cityHelp.provinceList[safe: row]?.name
        }
        return cityHelp.provinceList.filter({ $0.id == actionSelectBankProvinceId ?? selectBankProvinceId }).first?.children[safe: row]?.name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        if isBankPickerBool {

            actionSelectBankId = bankList[row].id
            print("row = \(row)   action = \(bankList[row].id)")
            return
        }
        if component == 0 {
            actionSelectBankProvinceId = cityHelp.provinceList[safe: row]?.id
            actionSelectBankCityId = cityHelp.provinceList[safe: row]?.children.first?.id
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: false)

        } else if component == 1 {
            actionSelectBankCityId = cityHelp.provinceList
                    .filter({ $0.id == actionSelectBankProvinceId ?? selectBankProvinceId })
                    .first?.children[safe: row]?.id

        }
    }

    func actionSheetPickerDidCancel(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {
        if isBankPickerBool {
            actionSelectBankId = nil
            return
        }
        actionSelectBankCityId = nil
        actionSelectBankProvinceId = nil

    }

    func actionSheetPickerDidSucceed(_ actionSheetPicker: AbstractActionSheetPicker!, origin: Any!) {

        if isBankPickerBool {
            selectBankId = actionSelectBankId ?? bankList.first?.id
            actionSelectBankId = nil
            return
        }

        selectBankCityId = actionSelectBankCityId ?? cityHelp.provinceList.first?.children.first?.id
        selectBankProvinceId = actionSelectBankProvinceId ?? cityHelp.provinceList.first?.id

        actionSelectBankProvinceId = nil
        actionSelectBankCityId = nil


    }

    func actionSheetPicker(_ actionSheetPicker: AbstractActionSheetPicker!, configurePickerView pickerView: UIPickerView!) {
        if isBankPickerBool {
            if let row = bankList.index(where: { $0.id == selectBankId }) {
                pickerView.selectRow(row, inComponent: 0, animated: false)
            }
        } else {
            if let row = cityHelp.provinceList.index(where: { $0.id == selectBankProvinceId }) {
                pickerView.selectRow(row, inComponent: 0, animated: false)
            }
            if let list = cityHelp.provinceList.filter({ $0.id == selectBankProvinceId }).first?.children {
                let row = list.index(where: { $0.id == selectBankCityId }) ?? 0
                pickerView.selectRow(row, inComponent: 1, animated: false)
            }
        }

    }


}
