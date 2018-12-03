//
//  BaseModel.swift
//  HuaXia
//
//  Created by tianshui on 15/10/9.
// 
//

import UIKit
import SwiftyJSON

protocol BaseModelProtocol: CustomStringConvertible {
    
    var json: JSON {get set}
    
    init(json: JSON)
    
}

extension BaseModelProtocol {
    
    var description: String {
        return json.description
    }
    
}
