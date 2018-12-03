//
//  UserVisitHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/7/5.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON


/// 足迹类型
enum UserVisitType: String {
    
    /// 新闻
    case news = "news"
    
    /// 未知
    case unknow = "unknow"
}

protocol UserVisitHandlerDelegate: class {
    func userVisitHandler(_ handler: UserVisitHandler, module: UserVisitType, didFetchedList list: [BaseModelProtocol], pageInfo: TSPageInfoModel)
    
    func userVisitHandler(_ handler: UserVisitHandler, didError error: NSError)
}

/// 用户 足迹
class UserVisitHandler: BaseHandler {
    
    weak var delegate: UserVisitHandlerDelegate?
    
    override init() {
        super.init()
        defaultRequestManager.delegate = self
    }
    
    /// 足迹
    func visit(module: UserVisitType, page: Int = 1, pageSize: Int = 20) {
        
        let router = TSRouter.userVisitList(module: module, page: page, pageSize: pageSize)
        defaultRequestManager.requestWithRouter(router)

    }
    
}

extension UserVisitHandler: TSRequestManagerDelegate {
    
    func requestManager(_ manager: TSRequestManager, didReceiveData json: SwiftyJSON.JSON) {
        let module = UserVisitType(rawValue: json["module"].stringValue) ?? .unknow
        let pageInfo = TSPageInfoModel(json: json["pageinfo"])
        
        var list = [BaseModelProtocol]()
        switch module {
        case .news:
            for subJson in json["list"].arrayValue {
                let obj = NewsModel(json: subJson)
                list.append(obj)
            }
        default:
            break
        }

        delegate?.userVisitHandler(self, module: module, didFetchedList: list, pageInfo: pageInfo)
    }
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        delegate?.userVisitHandler(self, didError: error)
        return true
    }
}

