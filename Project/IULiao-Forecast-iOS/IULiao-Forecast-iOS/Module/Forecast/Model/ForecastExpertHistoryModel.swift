//
//  ForecastExpertHistoryModel.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/15.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 专家预测历史(总)
class ForecastExpertHistoryModel: BaseModelProtocol {
    var json: JSON
    
    var notOpenList = [ForecastExpertHistoryListModel]()
    
    var list = [ForecastExpertHistoryListModel]()
    
    var pageInfo: PageInfoModel
    
    required init(json: JSON) {
        self.json = json
        notOpenList = json["not_open_list"].arrayValue.map({ return ForecastExpertHistoryListModel(json: $0) })
        list = json["list"].arrayValue.map({ return ForecastExpertHistoryListModel(json: $0) })
        pageInfo = PageInfoModel(json: json["pageinfo"])
    }
}

/// 专家预测历史列表
class ForecastExpertHistoryListModel: BaseModelProtocol {
    var json: JSON
    
    var forecast: ForecastDetailForecastModel
    
    var detailList = [ForecastMatchModel]()
    
    var user: ForecastExpertUserModel?
    
    required init(json: JSON) {
        self.json = json
        forecast = ForecastDetailForecastModel(json: json["forecast"])
        detailList = json["detail_list"].arrayValue.map({ return ForecastMatchModel(json: $0) })
        user = ForecastExpertUserModel(json: json["user"])
    }
}


