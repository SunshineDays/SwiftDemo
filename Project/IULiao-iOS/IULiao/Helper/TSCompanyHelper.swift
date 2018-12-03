//
//  TSCompanyHelper.swift
//  IULiao
//
//  Created by tianshui on 16/8/17.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation


class TSCompanyHelper {
    
    static let europeComapnys = [
        CompanyModel(cid: 30, name: "bet 365"),
        CompanyModel(cid: 116, name: "bwin"),
        CompanyModel(cid: 442, name: "澳门"),
        CompanyModel(cid: 449, name: "立博"),
        CompanyModel(cid: 451, name: "威廉"),
        CompanyModel(cid: 454, name: "易胜博"),
        CompanyModel(cid: 893, name: "韦德")
    ]
    
    static let asiaComapnys = [
        CompanyModel(cid: 30, name: "bet 365"),
        CompanyModel(cid: 442, name: "澳门"),
        CompanyModel(cid: 449, name: "立博"),
        CompanyModel(cid: 454, name: "易胜博"),
        CompanyModel(cid: 893, name: "韦德")
    ]
    
    /// 获取最后使用的赔率类型
    static func lastOddsType(_ defaults: OddsType = .europe) -> OddsType {
        guard let str = UserDefaults.standard.value(forKey: TSSettingKey.oddsType) as? String else {
            return defaults
        }
        
        guard let type = OddsType(rawValue: str) else {
            return defaults
        }
        
        return type
    }
    
    /// 设置最后使用的赔率类型
    static func setLastOddsType(_ type: OddsType) {
        UserDefaults.standard.set(type.rawValue, forKey: TSSettingKey.oddsType)
        UserDefaults.standard.synchronize()
    }
    
    /// 最后选中公司
    static func lastCompanys(_ defaults: [CompanyModel] = [CompanyModel(cid: 449, name: "立博", isSelected: true), CompanyModel(cid: 451, name: "威廉", isSelected: true)]) -> [CompanyModel]{
        guard let arr = UserDefaults.standard.object(forKey: TSSettingKey.oddsCompanys) as? [[String: AnyObject]] else {
            return defaults
        }
        
        let companys = arr.compactMap { (dict) -> CompanyModel? in
            guard let name = dict["name"] as? String else {
                return nil
            }
            guard let cid = dict["cid"] as? Int else {
                return nil
            }
            return CompanyModel(cid: cid, name: name, isSelected: true)
        }
        return companys.count > 0 ? companys : defaults
    }
    
    /// 设置最后选中公司
    static func setLastCompanys(_ companys: [CompanyModel]) {
        let arr = companys.map { (company) -> [String: AnyObject] in
            return ["name": company.name as AnyObject, "cid": company.cid as AnyObject]
        }
        UserDefaults.standard.set(arr, forKey: TSSettingKey.oddsCompanys)
    }
    
}
