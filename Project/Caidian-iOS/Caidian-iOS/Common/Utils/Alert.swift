//
//  Alert.swift
//  Caidian-iOS
//
//  Created by mac on 2018/6/4.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation


class Alert {

    /// 弹框
    func alertView(
            controller: UIViewController,
            title: String? = nil,
            message: String,
            okActionString: String = "确认",
            cancelActionString: String = "取消",
            cancelAction: @escaping (() -> Void),
            okAction: @escaping (() -> Void),
            titleColor: UIColor = UIColor.black,
            messageColor: UIColor = UIColor.black

    ) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if title != nil  {
            let alertControllerStr = NSMutableAttributedString(string: message, attributes: [NSAttributedStringKey.foregroundColor: titleColor])
            alertController.setValue(alertControllerStr, forKey: "attributedTitle")
        }
        if !message.isEmpty  {
            let alertControllerStr = NSMutableAttributedString(string: message, attributes: [NSAttributedStringKey.foregroundColor: messageColor])
            alertController.setValue(alertControllerStr, forKey: "attributedMessage")
        }
        let cancelAction = UIAlertAction(title: cancelActionString, style: .cancel,
                handler: {
                    action in
                    cancelAction()

                })
        let okAction = UIAlertAction(title: okActionString, style: .default,
                handler: {
                    action in
                    okAction()
                })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)

    }
}
