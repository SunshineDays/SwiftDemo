//
//  Created by tianshui on 16/8/15.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON

/// 足球 波胆(比分)
struct FBOddsScoreModel: BaseModelProtocol {

    var json: JSON

    var score10: Double
    var score20: Double
    var score21: Double
    var score30: Double
    var score31: Double
    var score32: Double
    var score40: Double
    var score41: Double
    var score42: Double
    var score43: Double

    var score01: Double
    var score02: Double
    var score12: Double
    var score03: Double
    var score13: Double
    var score23: Double
    var score04: Double
    var score14: Double
    var score24: Double
    var score34: Double
    
    var score00: Double
    var score11: Double
    var score22: Double
    var score33: Double
    var score44: Double
    
    init(json: JSON) {
        self.json = json
        
        score10 = json["score_10"].doubleValue
        score20 = json["score_20"].doubleValue
        score21 = json["score_21"].doubleValue
        score30 = json["score_30"].doubleValue
        score31 = json["score_31"].doubleValue
        score32 = json["score_32"].doubleValue
        score40 = json["score_40"].doubleValue
        score41 = json["score_41"].doubleValue
        score42 = json["score_42"].doubleValue
        score43 = json["score_43"].doubleValue
        
        score01 = json["score_01"].doubleValue
        score02 = json["score_02"].doubleValue
        score12 = json["score_12"].doubleValue
        score03 = json["score_03"].doubleValue
        score13 = json["score_13"].doubleValue
        score23 = json["score_23"].doubleValue
        score04 = json["score_04"].doubleValue
        score14 = json["score_14"].doubleValue
        score24 = json["score_24"].doubleValue
        score34 = json["score_34"].doubleValue
        
        score00 = json["score_00"].doubleValue
        score11 = json["score_11"].doubleValue
        score22 = json["score_22"].doubleValue
        score33 = json["score_33"].doubleValue
        score44 = json["score_44"].doubleValue
    }
}

/// 足球 波胆(比分) 赔率组合 初赔和末赔
struct FBOddsScoreSetModel {
    
    /// 公司
    var company: CompanyModel
    
    /// 初赔
    var initOdds: FBOddsScoreModel
    
    /// 末赔
    var lastOdds: FBOddsScoreModel
    
}
