//
//  PageInfoModel.swift
//  HuaXia
//
//  Created by tianshui on 15/10/9.
// 
//


/// 每页默认个数
let kPageInfoModelDefaultPageSize = 20

/// 分页信息
struct PageInfoModel: BaseModelProtocol {
    
    var json: JSON
    
    /// 当前页
    var page: Int = 1 
    
    /// 每页个数
    var pageSize: Int = kPageInfoModelDefaultPageSize

    /// 总页数
    var pageCount: Int = 0
    
    /// 数据总数
    var dataCount: Int = 0
    
    
    init(page: Int, pageSize:Int = kPageInfoModelDefaultPageSize) {
        self.page = page
        self.pageSize = pageSize
        self.json = JSON(NSNull())
    }
    
    init(json: JSON) {
        self.json      = json
        self.page      = json["page"].intValue
        self.pageSize  = json["pagesize"].intValue
        self.pageCount = json["pagecount"].intValue
        self.dataCount = json["datacount"].intValue
    }
    
    /// 下一页
    mutating func nextPage() -> Int {
        page += 1
        return page
    }

    /// 是否有更多页
    func hasMorePage() -> Bool {
        return page < pageCount
    }
    
    /// 重置页数
    mutating func resetPage()->Int {
        page = 1
        return page
    }
    
    /// 是否是第一页
    func isFirstPage() -> Bool {
        return page == 1
    }
}
