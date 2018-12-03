//
// Created by tianshui on 2018/5/15.
// Copyright (c) 2018 com.caidian310. All rights reserved.
//

import Foundation

/// 数字彩 球
enum NLBallKey: String, Comparable {

    case none = ""

    // --------------------------------------------------
    // 大小单双
    // --------------------------------------------------

    case big = "大"
    case small = "小"
    case odd = "单"
    case even = "双"

    // --------------------------------------------------
    // 0 ~ 9
    // --------------------------------------------------

    case u0 = "0"
    case u1 = "1"
    case u2 = "2"
    case u3 = "3"
    case u4 = "4"
    case u5 = "5"
    case u6 = "6"
    case u7 = "7"
    case u8 = "8"
    case u9 = "9"

    // --------------------------------------------------
    // 01 ~ 35
    // --------------------------------------------------

    case n01 = "01"
    case n02 = "02"
    case n03 = "03"
    case n04 = "04"
    case n05 = "05"
    case n06 = "06"
    case n07 = "07"
    case n08 = "08"
    case n09 = "09"
    case n10 = "10"
    case n11 = "11"
    case n12 = "12"
    case n13 = "13"
    case n14 = "14"
    case n15 = "15"
    case n16 = "16"
    case n17 = "17"
    case n18 = "18"
    case n19 = "19"
    case n20 = "20"
    case n21 = "21"
    case n22 = "22"
    case n23 = "23"
    case n24 = "24"
    case n25 = "25"
    case n26 = "26"
    case n27 = "27"
    case n28 = "28"
    case n29 = "29"
    case n30 = "30"
    case n31 = "31"
    case n32 = "32"
    case n33 = "33"
    case n34 = "34"
    case n35 = "35"

    var name: String {
        return rawValue
    }

    static func <(lhs: NLBallKey, rhs: NLBallKey) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }

}
