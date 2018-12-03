//
//  FBPlayerModel.swift
//  IULiao
//
//  Created by tianshui on 2017/11/8.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 球员
struct FBPlayerModel: BaseModelProtocol {

    var json: JSON
    
    var id: Int {
        get { return pid }
        set { pid = newValue }
    }
    
    var pid: Int
    
    /// 球球员
    var name: String
    
    /// 球员logo
    var logo: String
    
    /// 号码
    var number: Int?
    
    /// 国籍
    var nationality: String
    
    /// 年龄
    var age: Int?
    
    /// 位置
    var point: Int
    
    /// 位置名字
    var pointName: String
    
    /// 身高
    var height: Int?
    
    /// 体重
    var weight: Int?
    
    /// 惯用脚
    var preferredFoot: String?
    
    init(json: JSON) {
        self.json = json
        pid  = json["pid"].intValue
        name = json["name"].stringValue
        logo = json["logo"].stringValue
        nationality = json["nationality"].stringValue
        point = json["point"].intValue
        pointName = json["pointname"].stringValue
        
        let number = json["number"].intValue
        self.number = number > 0 ? number : nil
        
        let age = json["age"].intValue
        self.age = age > 0 ? age : nil
        
        let height = json["height"].intValue
        self.height = height > 0 ? height : nil
        
        let weight = json["weight"].intValue
        self.weight = weight > 0 ? weight : nil
        
        let preferredFoot = json["preferredfoot"].stringValue
        self.preferredFoot = preferredFoot.count > 0 ? preferredFoot : nil
        
    }
}
