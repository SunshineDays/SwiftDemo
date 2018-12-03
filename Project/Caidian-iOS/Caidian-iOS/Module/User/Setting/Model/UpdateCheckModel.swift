//
//  UpdateCheckModel.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/6/27.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

/// 版本更新
class UpdateCheckModel: BaseModelProtocol {
    var json: JSON
    
    var id: Int
    
    var version: Double
    
    var build: Int
    
    var platform: String
    
    var message: String
    
    var releaseDay: String
    
    var downloadURL: String
    
    required init(json: JSON) {
        self.json = json
        id = json["id"].intValue
        version = json["version"].doubleValue
        build = json["build"].intValue
        platform = json["platform"].stringValue
        message = json["message"].stringValue
        releaseDay = json["release_day"].stringValue
        downloadURL = json["download_url"].stringValue
    }
    
    
}
