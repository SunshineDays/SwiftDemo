//
//  TSProvinceModel.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/3.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation
import SwiftyJSON


/**
 * 省份
 **/
struct TSProvinceModel{
    var json: JSON
    
    ///  城市id
    var id :Int
    /// 城市名
    var name:String
    
    /// 子城市
    var children = [TSCityModel]()
    
    init(json:JSON) {
        self.json = json
        self.id   = json["id"].intValue
        self.name = json["name"].stringValue
        self.children = json["children"].arrayValue.map{ return TSCityModel(json : $0)}
    }

}

/**
 * 城市
 **/
struct TSCityModel {
    
    var json:JSON
    ///  城市id
    var id :Int
    /// 城市名
    var name:String
    
    
    init(json:JSON) {
        self.json = json
        self.id   = json["id"].intValue
        self.name = json["name"].stringValue
        
    }
    

}


