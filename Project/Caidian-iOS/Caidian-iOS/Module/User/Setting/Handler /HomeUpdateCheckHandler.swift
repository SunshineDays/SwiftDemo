//
//  UpdateCheckHandler.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/19.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 检查自动更新
class UpdateCheckHandler: BaseHandler {

    func updateCheck(success: @escaping (_ model: UpdateCheckModel, _ appBuild: Int) -> Void, failer: @escaping FailedBlock) {
        let router  = TSRouter.commonUpdateCheck
        defaultRequestManager.request(router: router, expires: 0, success: { (json) in
            
            DispatchQueue.global().async {
                /// 当前app的build
                let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
                let build = Int(appBuild) ?? 1000
                
                let model = UpdateCheckModel(json: json)
                DispatchQueue.main.async {
                    success(model, build)
                }
            }
        }) { (error) -> Bool in
            return false
        }
    }
    
}



