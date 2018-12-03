//
//  TSPageInfoModel.swift
//  HuaXia
//
//  Created by tianshui on 15/10/9.
// 
//

import SwiftyJSON

/// 分页信息
struct TSPageInfoModel: BaseModelProtocol {
    
    var json: JSON
    
    /// 当前页
    var page: Int = 1 
    
    /// 每页个数
    var pageSize: Int = 20

    /// 总页数
    var pageCount: Int = 0
    
    /// 数据总数
    var dataCount: Int = 0

    init(page: Int, pageSize:Int = 20) {
        self.page = page
        self.pageSize = pageSize
        self.json = JSON(NSNull())
    }
    
    init(json: JSON) {
        self.json      = json
        self.page      = json["page"].intValue
        self.pageSize  = json["page_size"].intValue
        self.pageCount = json["page_count"].intValue
        self.dataCount = json["data_count"].intValue
    }
    
    /// 下一页
    @discardableResult
    mutating func nextPage() -> Int {
        page += 1
        return page
    }

    /// 是否有更多页
    func hasMorePage() -> Bool {
        return page < pageCount
    }
    
    /// 重置页数
    @discardableResult
    mutating func resetPage()->Int {
        page = 1
        return page
    }
    
    /// 是否是第一页
    @discardableResult
    func isFirstPage() -> Bool {
        return page == 1
    }
}
