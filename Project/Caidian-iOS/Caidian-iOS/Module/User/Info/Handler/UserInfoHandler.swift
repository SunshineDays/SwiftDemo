//
//  UserInfoHandler.swift
//  IULiao
//
//  Created by tianshui on 2017/6/30.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

/// 用户信息
class UserInfoHandler: BaseHandler {


    /// 上传头像
    func uploadAvatar(avatarImage: UIImage?, success: @escaping ((UserInfoModel) -> Void), faild: @escaping FailedBlock) {
        guard let image = avatarImage else {
            return
        }
        let router = TSRouter.commonUploadAvatar
        Alamofire.upload(
                multipartFormData: { (form) in
                    let data = UIImageJPEGRepresentation(image, 1)
                    let parameters = router.pathAndParameters.parameters
                    let imageName = String(Foundation.Date().timeIntervalSince1970) + ".jpg"
                    form.append(data!, withName: "image", fileName: imageName, mimeType: "image/jpg")
                    for (k, v) in parameters {
                        form.append(String(describing: v).data(using: .utf8)!, withName: k)
                    }

                    // 添加签名 加密操作
                    form.append(router.sign(parameters).data(using: .utf8)!, withName: "sign")

                },
                to: try! (router.asURLRequest().url?.absoluteString)!) {
                      (result) in
                      switch result {
                          case let .success(request, _, _):
                              request.responseJSON(completionHandler: { (res) in
                                  let json = JSON(res.data ?? Data())
                                  let userInfo = UserInfoModel(json: json["data"])
                                  UserToken.shared.update(userInfo: userInfo)
                                  success(userInfo)

                              })
                          case let .failure(error):
                              faild(error as NSError)
                          }
        }

    }

    /// 用户详情
    func detail(success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.userInfoDetail
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    (json) in
                    let userInfo = UserInfoModel(json: json)
                    success(userInfo)

                    UserToken.shared.update(userInfo: userInfo)
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return true
                })

    }

    /// 更新用户资料
    func update(nickname: String? = nil, gender: UserGenderType? = nil, success: @escaping ((UserInfoModel) -> Void), failed: @escaping FailedBlock) {

        let router = TSRouter.userInfoUpdate(nickname: nickname, gender: gender)
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    (json) in
                    let userInfo = UserInfoModel(json: json)
                    success(userInfo)

                    UserToken.shared.update(userInfo: userInfo)
                },
                failed: {
                    (error) -> Bool in
                    failed(error)
                    return true
                })
    }

    ///账户详情
    func accountDetail(success: @escaping ((_ userAccount: UserAccountModel) -> Void), failed: @escaping FailedBlock) {
        let router = TSRouter.userAccountDetail
        defaultRequestManager.request(
                router: router,
                expires: 0,
                success: {
                    json in
                    success(UserAccountModel(json: json))
                },
                failed: {
                    error in
                    failed(error)
                    return true
                })
    }
}

