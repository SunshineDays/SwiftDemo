//
//  UserRealNameAuthenticationController.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/5.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 实名认证
class UserRealNameAuthenticationController: BaseViewController {
    
    @IBOutlet weak var realNameButton: UIButton!
    
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var realNameTextField: UITextField!
    @IBOutlet weak var repeatCardTexField: UITextField!
    
    
    @IBOutlet weak var realNameView: UIView!
    @IBOutlet weak var realCardCodeLebal: UILabel!
    @IBOutlet weak var realNameLebal: UILabel!
    @IBOutlet weak var noRealNameView: UIView!
    
    var realNameHandler :UserRealNameHandler = UserRealNameHandler()
    
    
    override func viewDidLoad() {
        
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = []

        if UserToken.shared.userInfo?.isRealName ?? false {
            realNameSuccess()
            requestRealNameInfo()
        }else{
            noRealName()
        }
    
    }
    

    @IBAction func realNameCommmitButton(_ sender: UIButton) {
        requestRealName()
    }
    
    
    /// 实名认证信息
    func requestRealNameInfo() {
      
         realNameHandler.requestRealNameDetail(
            success: {
                (it) in
                self.realNameLebal.text = it.secretRealName
                self.realCardCodeLebal.text = it.secretCardCode

             },
           failed: {
              (error) in
            TSToast.showText(view: self.view, text: error.localizedDescription)
           }
        )
    
    }
    


    /// 实名认证网络请求
    
    func requestRealName() {
        
        if repeatCardTexField.text == nil || cardTextField.text == nil {
            TSToast.showText(view: view, text: "身份证号码不能为空")
            return
        }
        
        if  repeatCardTexField.text != cardTextField.text {
            TSToast.showText(view: view, text: "身份证号码不一致")
            return
        }
        if realNameTextField.text == nil {
            TSToast.showText(view: view, text: "真实姓名不能为空")
            return
        }
       
    
        realNameHandler.requestRealName(
            realName: realNameTextField.text!,
            cardCode: cardTextField.text!,
            success: {
                (it) in
                TSToast.showText(view: self.view, text: "实名认证成功")
                self.realNameSuccess()
              
            },
            failed: {
                (error) in
                TSToast.showText(view: self.view, text: error.localizedDescription)
                
            }
        )
    }
    
    ///已实名认证
    func realNameSuccess() {
        noRealNameView.isHidden = true
        realNameButton.isHidden = true
        realNameView.isHidden = false
    }
    
    //未实名认证
    
    func noRealName(){
       noRealNameView.isHidden = false
       realNameButton.isHidden = false
       realNameView.isHidden = true
    }
    
    
    
    
}
