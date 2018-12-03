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
            TSToast.showText(view: view, text: "请先第三方登录", color: .error)
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
            TSToast.showText(view: view, text: check.msg, color: .error)
            nicknameTextField.becomeFirstResponder()
            return
        }
        
        guard let userOpenInfo = UserLoginHandler.userOpenInfo else {
            TSToast.showText(view: view, text: "请先第三方登录", color: .error)
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
                TSToast.showText(view: self.view, text: "注册并绑定成功", color: .success)
                self.hud.hide(animated: true)
                self.dismiss(animated: true, completion: nil)
        },
            failed: {
                error in
                TSToast.showText(view: self.view, text: error.localizedDescription, color: .error)
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
