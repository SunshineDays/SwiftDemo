//
//  Date.swift
//
//
//  值类型的 Date 使用方便 而且避免使用 @NSCopying 的麻烦
//  基本遵循了官方所有关于值类型的实用协议 放心使用
//

import Foundation

// MARK: - 星期
enum Weekday : Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    /// 英文全称
    var en: String {
        var week = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
        return week[self.rawValue - 1]
    }
    
    /// 英文简称
    var enShort: String {
        let range = en.startIndex..<en.index(en.startIndex, offsetBy: min(en.count, 3))
        return String(en[range])
    }
    
    /// 中文表达
    var cn: String {
        var week = ["日", "一", "二", "三", "四", "五", "六"]
        return week[self.rawValue - 1]
    }
}


func ==(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeInterval == rhs.timeInterval
}
func <=(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeInterval <= rhs.timeInterval
}
func >=(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeInterval >= rhs.timeInterval
}
func >(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeInterval > rhs.timeInterval
}
func <(lhs: Date, rhs: Date) -> Bool {
    return lhs.timeInterval < rhs.timeInterval
}
func +(lhs: Date, rhs: TimeInterval) -> Date {
    return Date(rhs, sinceDate:lhs)
}
func -(lhs: Date, rhs: TimeInterval) -> Date {
    return Date(-rhs, sinceDate:lhs)
}
func +(lhs: TimeInterval, rhs: Date) -> Date {
    return Date(lhs, sinceDate:rhs)
}
func -(lhs: TimeInterval, rhs: Date) -> Date {
    return Date(-lhs, sinceDate:rhs)
}

func +=(lhs: inout Date, rhs: TimeInterval) {
    return lhs = Date(rhs, sinceDate:lhs)
}
func -=(lhs: inout Date, rhs: TimeInterval) {
    return lhs = Date(-rhs, sinceDate:lhs)
}


struct Date {
    
    /// 时间戳
    var timeInterval:TimeInterval = 0
    
    init() {
        self.timeInterval = Foundation.Date().timeIntervalSince1970
    }
}

// MARK: - 输出
extension Date {
    
    /**
    格式化输出 yyyy-MM-dd HH:mm:ss
    
    - parameter format: 格式
    - returns: String
    */
    func stringWithFormat(_ format:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Foundation.Date(timeIntervalSince1970: timeInterval))
    }
}

// MARK: - 计算
extension Date {
    
    mutating func addDay(_ day:Int) {
        timeInterval += Double(day) * 24 * 3600
    }
    
    mutating func addHour(_ hour:Int) {
        timeInterval += Double(hour) * 3600
    }
    
    mutating func addMinute(_ minute:Int) {
        timeInterval += Double(minute) * 60
    }
    
    mutating func addSecond(_ second:Int) {
        timeInterval += Double(second)
    }
    
    mutating func addMonth(month m:Int) {
        let (year, month, day) = getDay()
        let (hour, minute, second) = getTime()
        let era = year / 100
        if let date = (Calendar.current as NSCalendar).date(era: era, year: year, month: month + m, day: day, hour: hour, minute: minute, second: second, nanosecond: 0) {
            timeInterval = date.timeIntervalSince1970
        } else {
            timeInterval += Double(m) * 30 * 24 * 3600
        }
    }
    
    mutating func addYear(year y:Int) {
        let (year, month, day) = getDay()
        let (hour, minute, second) = getTime()
        let era = year / 100
        if let date = (Calendar.current as NSCalendar).date(era: era, year: year + y, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: 0) {
            timeInterval = date.timeIntervalSince1970
        } else {
            timeInterval += Double(y) * 365 * 24 * 3600
        }
    }
}

// MARK: - 判断
extension Date {
    
    /**
    判断是否介于两个时间之间
    
    - parameter begin: 开始时间
    - parameter over:  结束时间
    - returns: Bool
    */
    func between(_ begin:Date,_ over:Date) -> Bool {
        return (self >= begin && self <= over) || (self >= over && self <= begin)
    }
}

// MARK: - 获取 日期 或 时间
extension Date {
    
    /**
    获取 年,月,日 for example : let (year, month, day) = date.getDay()
    
    - returns: (year, month, day)
    */
    func getDay() -> (year:Int, month:Int, day:Int) {
        var year:Int = 0, month:Int = 0, day:Int = 0
        let date = Foundation.Date(timeIntervalSince1970: timeInterval)
        (Calendar.current as NSCalendar).getEra(nil, year: &year, month: &month, day: &day, from: date)
        return (year, month, day)
    }
    
    /**
    获取 小时,分钟,秒 for example : let (hour, minute, second) = date.getTime()
    
    - returns: (hour, minute, second)
    */
    func getTime() -> (hour:Int, minute:Int, second:Int) {
        var hour:Int = 0, minute:Int = 0, second:Int = 0
        let date = Foundation.Date(timeIntervalSince1970: timeInterval)
        (Calendar.current as NSCalendar).getHour(&hour, minute: &minute, second: &second, nanosecond: nil, from: date)
        return (hour, minute, second)
    }
    
    /**
    获取周几
    
    - returns: Weekday
    */
    func getWeekday() -> Weekday {
        var weekday = 0
        let date = Foundation.Date(timeIntervalSince1970: timeInterval)
        (Calendar.current as NSCalendar).getEra(nil, yearForWeekOfYear: nil, weekOfYear: nil, weekday: &weekday, from: date)
        return Weekday(rawValue: weekday)!
    }
}

// MARK: - 构造函数
extension Date {
    init(year:Int, month:Int = 1, day:Int = 1, hour:Int = 0, minute:Int = 0, second:Int = 0) {
        let era = year / 100
        if let date = (Calendar.current as NSCalendar).date(era: era, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: 0) {
            timeInterval = date.timeIntervalSince1970
        }
    }
}

extension Date {
    init(_ v: TimeInterval) { timeInterval = v }
    
    init(_ v: TimeInterval, sinceDate:Date) {
        let date = Foundation.Date(timeIntervalSince1970: sinceDate.timeInterval)
        timeInterval = Foundation.Date(timeInterval: v, since: date).timeIntervalSince1970
    }
    
    init(sinceNow: TimeInterval) {
        timeInterval = Foundation.Date(timeIntervalSinceNow: sinceNow).timeIntervalSince1970
    }
    
    init(sinceReferenceDate: TimeInterval) {
        timeInterval = Foundation.Date(timeIntervalSinceReferenceDate: sinceReferenceDate).timeIntervalSince1970
    }
}

extension Date {
    init(_ v: String, style: DateFormatter.Style = .none) {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        if let date = formatter.date(from: v) {
            self.timeInterval = date.timeIntervalSince1970
        }
    }
    
    init(_ v: String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        if let date = formatter.date(from: v) {
            self.timeInterval = date.timeIntervalSince1970
        }
    }
}

extension Date {
    init(_ v: UInt8) { timeInterval = Double(v) }
    init(_ v: Int8) { timeInterval = Double(v) }
    init(_ v: UInt16) { timeInterval = Double(v) }
    init(_ v: Int16) { timeInterval = Double(v) }
    init(_ v: UInt32) { timeInterval = Double(v) }
    init(_ v: Int32) { timeInterval = Double(v) }
    init(_ v: UInt64) { timeInterval = Double(v) }
    init(_ v: Int64) { timeInterval = Double(v) }
    init(_ v: UInt) { timeInterval = Double(v) }
    init(_ v: Int) { timeInterval = Double(v) }
    init(_ v: Float) { timeInterval = Double(v) }
}

// MARK: - 可以直接输出
extension Date : CustomStringConvertible {
    var description: String {
        return Foundation.Date(timeIntervalSince1970: timeInterval).description
    }
}

extension Date : CustomDebugStringConvertible {
    var debugDescription: String {
        return Foundation.Date(timeIntervalSince1970: timeInterval).debugDescription
    }
}

// MARK: - 可以直接赋值整数
extension Date : ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        timeInterval = Double(value)
    }
}

// MARK: - 可以直接赋值浮点数
extension Date : ExpressibleByFloatLiteral {
    init(floatLiteral value: FloatLiteralType) {
        timeInterval = value
    }
}

// MARK: - 可哈希
extension Date : Hashable {
    var hashValue: Int {
        return timeInterval.hashValue
    }
}

// 可以用 == 或 != 对比
extension Date : Equatable {
    
}

// MARK: - 可以用 > < >= <= 对比
extension Date : Comparable {

}

