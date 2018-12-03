//
//  CompanyModel.swift
//  IULiao
//
//  Created by tianshui on 16/8/15.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation

/// 公司
struct CompanyModel {
    
    var id: Int {
        return cid
    }
    
    /// 公司id
    var cid: Int
    
    /// 公司名称
    var name: String
    
    /// 公司类型
    var companyType: CompanyType
    
    var isSelected = false
    
    init(cid: Int, name: String, companyType: CompanyType = .none, isSelected: Bool = false) {
        self.cid = cid
        self.name = name
        self.isSelected = isSelected
        self.companyType = companyType
    }
    
    enum CompanyType: Int, CustomStringConvertible {
        /// 主流
        case major = 2
        
        /// 交易所
        case bourse = 1
        
        case none = 0
        
        var description: String {
            switch self {
            case .major:
                return "主"
            case .bourse:
                return "所"
            default:
                return ""
            }
        }
        
        var color: UIColor? {
            switch self {
            case .major:
                return UIColor(hex: 0xC20000)
            case .bourse:
                return UIColor(hex: 0xFF7133)
            default:
                return nil
            }
        }
    }
}

func ==(lhs: CompanyModel, rhs: CompanyModel) -> Bool {
    return lhs.id == rhs.id
}
