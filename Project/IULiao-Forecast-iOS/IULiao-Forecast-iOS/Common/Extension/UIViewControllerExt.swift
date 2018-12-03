//
//  UIViewControllerExt.swift
//  HuaXia
//
//  Created by tianshui on 15/10/29.
// 
//

import Foundation
import UIKit

extension UIViewController {
    
    /// 快捷弹出只有确定按钮的UIAlertController
    func presentAlertViewController(title: String?, message: String?, confirmHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "确定", style: .default, handler: confirmHandler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}
