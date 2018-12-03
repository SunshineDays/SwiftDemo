//
//  ForecastModel.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 预测首页
class ForecastModel: BaseModelProtocol {
    var json: JSON
    
    var list = [ForecastExpertHistoryListModel]()
    
    var pageInfo: PageInfoModel!
    
    required init(json: JSON) {
        self.json = json
        list = json["list"].arrayValue.map({ return ForecastExpertHistoryListModel(json: $0) })
        pageInfo = PageInfoModel(json: json["pageinfo"])
    }
    
    
}
