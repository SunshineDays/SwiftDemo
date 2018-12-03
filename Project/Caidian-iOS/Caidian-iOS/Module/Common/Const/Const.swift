//
//  系统常量
//

import Foundation

#if DEBUG
let isDebug = true
#else
let isDebug = false
#endif

/// domain
//let kBaseDomain = "bzcp188.com"
let kBaseDomain = "caidian310.com"
let kBaseDebug = "caidian310.cn"

/// app本站下载地址
let kAppDownloadURLString = "http://bzcp188.com/app"

/// 资源文件名
let kTSResourceBundleName = "Resource.bundle"

// 本应用appStore链接
let kConstantsAppItunesURLString = "https://itunes.apple.com/cn/app/id1147456885"

/// umeng key
let kUmengAppKey = "5b209169f43e483f5d0000ec"

// jpush key
let kJPushAppKey = "7654b53299377de911e77989"

/// 微信id
let kWechatAppID = "wx54d2c7d8b511b156"

/// 微信key
let kWechatAppSecret = "4caa216ecd79d3cfaa0fc8a652687532"

// qq id
let kQQAppID = "1105950826"

// 微博 id
let kWeiboAppID = "333474937"

// 微博key
let kWeiboAppSecret = "b0d780612a80f3ae1a987d7e7155b72e"

/// 刷新间隔
let kRefreshDataTime: Double = 300

/// 目前已经支持的彩种
let isHaveLotteryList = [
    LotteryType.jclq,
    LotteryType.jczq,
    LotteryType.bd,
 ]
