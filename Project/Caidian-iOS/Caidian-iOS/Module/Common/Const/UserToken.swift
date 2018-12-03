//
//  UserToken.swift
//  IULiao
//
//  Created by tianshui on 2017/6/20.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import SwiftyJSON

/// 用户免登录令牌
class UserToken: NSObject {

    static let shared = UserToken()
    
    /// 免登录 token
    var token: String? {
        guard let str = UserDefaults.standard.string(forKey: TSSettingKey.token), !str.isEmpty else {
            return nil
        }
        return str
    }
    
    /// 是否登录
    var isLogin: Bool {
        guard let token = token else {
            return false
        }
        return token.count > 0
    }
    
    
    /// 当前的域名
    var router : String{
        var newRouter = "http://iapi.\(kBaseDomain)"
        guard let router = UserDefaults.standard.string(forKey: TSSettingKey.debugUpdateRouter), !router.isEmpty else {
            #if DEBUG
              newRouter  = "http://iapi.\(kBaseDebug)"
            #endif
            return newRouter
        }
        #if DEBUG
         return router
        #else
         return newRouter
        #endif
        
    
    }
    
    /// 登录用户信息
    var userInfo: UserInfoModel? {
        guard let json = UserDefaults.standard.string(forKey: TSSettingKey.loginUserInfo) else {
            return nil
        }
        let userInfo = UserInfoModel(json: JSON(parseJSON: json))
        if isLogin && userInfo.id > 0 {
            return userInfo
        }
        return nil
    }
    
    /// 用户账户信息
    var userAccount: UserAccountModel? {
        guard let json = UserDefaults.standard.string(forKey: TSSettingKey.userAccount) else {
            return nil
        }
        if !isLogin {
            return nil
        }
        let userAccount = UserAccountModel(json: JSON(parseJSON: json))
        if userAccount.userId > 0 {
            return userAccount
        }
        return nil
    }
    
    private override init() {}
    
    /// 更新用户信息
    func update(userInfo: UserInfoModel) {
        let json = userInfo.json.description
        UserDefaults.standard.set(json, forKey: TSSettingKey.loginUserInfo)
        UserDefaults.standard.synchronize()
    }
    
    /// 更新用户账户信息
    func update(userAccount: UserAccountModel) {
        let json = userAccount.json.description
        UserDefaults.standard.set(json, forKey: TSSettingKey.userAccount)
        UserDefaults.standard.synchronize()
    }
    
    /// 更新token
    func update(token: String) {
        UserDefaults.standard.set(token, forKey: TSSettingKey.token)
        UserDefaults.standard.synchronize()
    }
    
    /// 清除token
    func clear() {
        update(token: "")
        UserDefaults.standard.set(nil, forKey: TSSettingKey.loginUserInfo)
        UserDefaults.standard.synchronize()
    }
    
    /// 购物车信息(二维数组)
    var userCartInfos: [[RecommendDetailModel]]? {
        if let userCartInfo = userCartInfo {
            let models = userCartInfo.reversed()
            var modelss = [[RecommendDetailModel]]()
            for m in models {
                var newModels = [RecommendDetailModel]()
                for n in models {
                    if m.matchInfo.id == n.matchInfo.id {
                        newModels.append(n)
                    }
                }
                var isExist = false
                for ss in modelss {
                    for s in ss {
                        if s.matchInfo.id == m.matchInfo.id {
                            isExist = true
                        }
                    }
                }
                if !isExist {
                    modelss.append(newModels)
                }
            }
            return modelss
        } else {
            return nil
        }
    }
    
    /// 购物车信息
    var userCartInfo: [RecommendDetailModel]? {
        if let list = UserDefaults.standard.array(forKey: TSSettingKey.userCartInfo) {
            var newList = [Any]()
            var models = [RecommendDetailModel]()
            list.forEach{  item in
                let model = RecommendDetailModel(json: JSON(parseJSON: item as! String))
                if Date().timeIntervalSince1970 < model.matchInfo.saleEndTime {
                    models.append(model)
                    newList.append(item)
                }
            }
            UserDefaults.standard.set(newList, forKey: TSSettingKey.userCartInfo)
            UserDefaults.standard.synchronize()
            return models
    
        } else {
            return nil
        }
    }
    
    /// 购物车中是否有这个推荐
    func isHaveRecommend(cartInfo: RecommendDetailModel) -> Bool {
        var isHave = false
        if let list = userCartInfo {
            for l in list {
                ///  判断购物车中是否存在
                if l.recommend.id == cartInfo.recommend.id {
                    isHave = true
                }
            }
        }
        return isHave
    }
    
    /// 更新购物车
    func addToCart(cartInfo: RecommendDetailModel) {
        var models = [String]()
        if let list = userCartInfo {
            for l in list {
                ///  判断购物车中是否存在
                if l.recommend.id != cartInfo.recommend.id {
                    models.append(l.json.description)
                }
            }
        }
        models.append(cartInfo.json.description)
        UserDefaults.standard.set(models, forKey: TSSettingKey.userCartInfo)
        UserDefaults.standard.synchronize()
    }

    /// 删除购物车中的数据
    func deleteFromCart(models: [RecommendDetailModel]) {
        var modelStrings = [String]()
        if let list = userCartInfo {
            for l in list {
                var isExit = false
                for model in models {
                    ///  判断购物车中是否存在
                    if l.recommend.id == model.recommend.id {
                        isExit = true
                    }
                }
                if !isExit {
                    modelStrings.append(l.json.description)
                }
            }
        }
        UserDefaults.standard.set(modelStrings, forKey: TSSettingKey.userCartInfo)
        UserDefaults.standard.synchronize()
    }
    
    /// 清空购物车
    func clearWithCart() {
        UserDefaults.standard.set(nil, forKey: TSSettingKey.userCartInfo)
        UserDefaults.standard.synchronize()
    }
    
    /// 购买成功的推荐id
    func buySuccessInCartRecommendIDs() -> [Int]? {
        if let list = UserDefaults.standard.array(forKey: TSSettingKey.userCartBuySuccessIDs) {
            var resultList = [Int]()
            for l in list {
                resultList.append(l as! Int)
            }
            return resultList
        } else {
            return nil
        }
    }
    
    /// 更新购买成功的推荐id
    func addToCartSuccess(recommendIDs: [Int]) {
        
        var resultList = [Int]()
        if let list = buySuccessInCartRecommendIDs() {
            resultList = list
        }

        // 先判断是否已经存在  如果数据已经存在 不再继续添加
        recommendIDs.forEach{
            if !resultList.contains($0){
                resultList.append($0)
            }
        }
        // 如果没有数据符合的数据不再添加
        if resultList.count > 0 {
            UserDefaults.standard.set(resultList, forKey: TSSettingKey.userCartBuySuccessIDs)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// 判断用户是否购买过该推荐
    func isBuySuccessInCart(with recommendId: Int) -> Bool {
        return (UserToken.shared.buySuccessInCartRecommendIDs()?.contains(recommendId) ?? false)
    }

}
