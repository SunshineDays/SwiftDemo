//
//  PiazzaNewsHandle.swift
//  IULiao
//
//  Created by levine on 2017/7/27.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON
protocol PiazzaNewsHandleDelegate:class {
    func newListHandler(_ handler: PiazzaNewsHandle, didFerchedList list: [NewsModel], andPageInfo pageInfo: TSPageInfoModel)
    
    func newListHandler(_ handler: PiazzaNewsHandle, didError error: NSError)
}
class PiazzaNewsHandle: BaseHandler {

    weak var delegate:PiazzaNewsHandleDelegate?
    override init() {
        super.init()
         defaultRequestManager.delegate = self
    }
    //执行网络请求
    func executeFetchNewsList(isrecommend: Bool?, page: Int, pageSize: Int) {
        let router = TSRouter.newsList(taxonomyId: nil, sport: nil, page: page, pageSize: pageSize)
        defaultRequestManager.requestWithRouter(router, expires: 0)
    }
}
extension PiazzaNewsHandle:TSRequestManagerDelegate {
    //成功代理
    func requestManager(_ manager: TSRequestManager, didReceiveData json: JSON) {
        var listModelarr = [NewsModel]()
        for subJosn in json["list"].arrayValue {
          let obj = NewsModel(json: subJosn)
            listModelarr.append(obj)
        }
        let pageInfo = TSPageInfoModel(json: json["pageinfo"])
        if delegate != nil {
            self.delegate?.newListHandler(self, didFerchedList: listModelarr, andPageInfo: pageInfo)
        }
        
    }
    //失败代理
    
    func requestManager(_ manager: TSRequestManager, didFailed error: NSError) -> Bool {
        if delegate != nil {
            self.delegate?.newListHandler(self, didError: error)
        }
        return false
    }
}
