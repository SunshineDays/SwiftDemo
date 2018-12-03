//
//  DateExt.swift
//  IULiao
//
//

import Foundation

extension Date {



    /// 格式化输出时间
    ///
    /// - Parameter format: 同DateFormatter.dateFormat
    /// - Returns: 格式化后的时间
    func string(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    /// 获取 星期
    ///
    /// - Returns: 星期
    func getWeekday() -> Weekday {
        let week = Calendar(identifier: .chinese).component(.weekday, from: self)
        return Weekday(rawValue: week)!
    }

    /// 星期
    enum Weekday : Int {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

        /// 英文全称
        var en: String {
            var week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            return week[rawValue - 1]
        }

        /// 中文表达
        var cn: String {
            var week = ["日", "一", "二", "三", "四", "五", "六"]
            return week[rawValue - 1]
        }
    }
}
