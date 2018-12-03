//
//  PiazzaHotMatchType.swift
//  IULiao
//
//  Created by levine on 2017/7/28.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

enum PiazzaHotMarchType:String {
    case noMatch //没有比赛，此时hotMacth 返回空值
    case brief = "brief"//马上开始的比赛(赛前)
    case animation = "animation"//进行中的比赛(上,中,下)
    
    init(rawValue:String) {
        switch rawValue {
        case "brief":
            self = .brief
        case "animation":
            self = .animation
        default:
            self = .noMatch
        }
    }
}
