//
//  UserRegisterThirdViewController2.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/6/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit


/// 用户注册 第三方 第二步 修改昵称
class UserRegisterThirdViewController2: BaseTableViewController {
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    let registerHandler = UserRegisterHandler()
    var phone: String!
    var authCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let userOpenInfo = UserLoginHandler.userOpenInfo else {
            MBProgressHUD.show(info: "请先第三方登录")
            return
        }
        nicknameTextField.text = userOpenInfo.nickname
    }
    
    
    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func registerClick(_ sender: UIButton) {
        registerThird()
    }
    
    // 注册并绑定
    func registerThird() {
        view.endEditing(true)
        
        let check = UserRegisterHandler.check(nickname: nicknameTextField.text)
        if !check.isValid {
            MBProgressHUD.show(info: check.msg)
            nicknameTextField.becomeFirstResponder()
            return
        }
        
        guard let userOpenInfo = UserLoginHandler.userOpenInfo else {
            MBProgressHUD.show(info: "请先第三方登录")
            return
        }
        
        MBProgressHUD.showProgress(toView: view)
        
        registerHandler.registerThird(
            phone: phone,
            authCode: authCode,
            nickname: nicknameTextField.text ?? "",
            openInfo: userOpenInfo,
            success: {
                user in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: "注册并绑定成功", colorStyle: .success)
                self.dismiss(animated: true, completion: nil)
        },
            failed: {
                error in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        })
    }
}

extension UserRegisterThirdViewController2: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nicknameTextField {
            registerThird()
        }
        return true
    }
}
