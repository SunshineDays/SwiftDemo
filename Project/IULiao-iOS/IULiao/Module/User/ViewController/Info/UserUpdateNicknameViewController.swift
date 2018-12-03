//
//  UserUpdateNicknameViewController.swift
//  IULiao
//
//  Created by tianshui on 2017/7/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 修改昵称
class UserUpdateNicknameViewController: BaseTableViewController {

    @IBOutlet weak var nicknameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.text = UserToken.shared.userInfo?.nickname
        nicknameTextField.textColor = UIColor(r: 153, g: 153, b: 153)
        nicknameTextField.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }

    @IBAction func viewTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func updateClick(_ sender: UIButton) {
        update()
    }
    
    func update() {
        view.endEditing(true)
        
        let check = UserRegisterHandler.check(nickname: nicknameTextField.text)
        if !check.isValid {
            TSToast.showNotificationWithMessage(check.msg, colorStyle: .error)
            nicknameTextField.becomeFirstResponder()
            return
        }
        
        hud.show(animated: true)
        UserInfoHandler().update(
            nickname: nicknameTextField.text ?? "",
            success: {
                info in
                TSToast.showNotificationWithMessage("昵称修改成功", colorStyle: .success)
                self.hud.hide(animated: true)
                self.navigationController?.popViewController(animated: true)
        },
            failed: {
                error in
                TSToast.showNotificationWithMessage(error.localizedDescription, colorStyle: .error)
                self.hud.hide(animated: true)
        })
    }
    
}

extension UserUpdateNicknameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        if textField == nicknameTextField {
            update()
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
         textField.textColor = UIColor.black
    }
}
