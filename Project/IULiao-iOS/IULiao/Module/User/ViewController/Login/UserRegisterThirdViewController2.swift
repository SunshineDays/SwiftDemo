//
//  UserRegisterThirdViewController2.swift
//  IULiao
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
            TSToast.showNotificationWithMessage("请先第三方登录", colorStyle: .error)
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
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            nicknameTextField.becomeFirstResponder()
            return
        }
        
        guard let userOpenInfo = UserLoginHandler.userOpenInfo else {
            TSToast.showNotificationWithMessage("请先第三方登录", colorStyle: .error)
            return
        }
        
        hud.show(animated: true)
        
        registerHandler.registerThird(
            phone: phone,
            authCode: authCode,
            nickname: nicknameTextField.text ?? "",
            openInfo: userOpenInfo,
            success: {
                user in
                TSToast.showNotificationWithMessage("注册并绑定成功", colorStyle: .success)
                self.hud.hide(animated: true)
                self.dismiss(animated: true, completion: nil)
        },
            failed: {
                error in
                TSToast.showNotificationWithMessage(error.localizedDescription, colorStyle: .error)
                self.hud.hide(animated: true)
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
