//
//  UserInfoViewController.swift
//  IULiao-Forecast-iOS
//
//  Created by tianshui on 2017/7/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

/// 用户资料修改
class UserInfoViewController: BaseTableViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    let infoHandler = UserInfoHandler()
    var userInfo: UserInfoModel? {
        didSet {
            refreshUserInfo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let info = UserToken.shared.userInfo {
            userInfo = info
        }
        MBProgressHUD.showProgress(toView: view)
        infoHandler.detail(
            success: {
                (userInfo) in
                self.userInfo = userInfo.user
                MBProgressHUD.hide(from: self.view)
        },
            failed: {
                error in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        })
    }
   
    func refreshUserInfo() {
        guard let userInfo = userInfo else {
            return
        }
        //更该 头像
        if let url = userInfo.avatar {
            avatarImageView.sd_setImage(
                with: URL(string:ImageURLHelper(string: url, size: CGSize(width: 160, height: 160)).chop().urlString),
                placeholderImage: R.image.user.avatar())
        }
        nicknameLabel.text = userInfo.nickname
        genderLabel.text = userInfo.gender.description
        phoneLabel.text = userInfo.secretPhone
    }
    
}
//MARK:上传头像
extension UserInfoViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //显示的图片
        if let image = info[.editedImage] as? UIImage {
            let reSizeImage = image.resize(size: CGSize(width: 400, height: 400))
            MBProgressHUD.showProgress(toView: view)
            
            infoHandler.uploadAvatar(avatarImage: reSizeImage, success: {
                [weak self] (userInfoModel) in
                self?.avatarImageView.image = image
                MBProgressHUD.hide(from: self?.view)
            }) {
                (error) in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
            }
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
}

extension UserInfoViewController {
    
    func update(gender: UserGenderType) {
        MBProgressHUD.showProgress(toView: view)
        
        infoHandler.update(
            gender: gender,
            success: {
                info in
                self.userInfo = info
                MBProgressHUD.hide(from: self.view)
                MBProgressHUD.show(success: "性别修改成功")
        },
            failed: {
                error in
                MBProgressHUD.hide(from: self.view)
                CRToast.showNotification(with: error.localizedDescription, colorStyle: .error)
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0): // 头像
            let alertCtrl = UIAlertController(title: "用户头像", message: nil, preferredStyle: .actionSheet)
            let camerAction = UIAlertAction(title: "相机", style: .default, handler: { (_) in
                if self.cameraPermissions() {
                    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                        let picker = UIImagePickerController()
                        //设置代理
                        picker.delegate = self
                        //指定图片控制器类型
                        picker.sourceType = UIImagePickerController.SourceType.camera
                        //设置是否允许编辑
                        picker.allowsEditing = true
                        //弹出控制器，显示界面
                        self.present(picker, animated: true)
                        
                    }else {
                        MBProgressHUD.show(info: "无可用相机")
                        return
                    }
                }else {
                    MBProgressHUD.show(info: "请开启相机权限")
                    return
                }
               
            })
            let albumAction = UIAlertAction(title: "相册", style: .default, handler: { (_) in
                if self.PhotoLibraryPermissions() {
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        let picker = UIImagePickerController()
                        //设置代理
                        picker.delegate = self
                        //指定图片控制器类型
                        picker.sourceType = .photoLibrary
                        //设置是否允许编辑
                        picker.allowsEditing = true
                        //弹出控制器，显示界面
                        self.present(picker, animated: true)
                        
                    } else {
                        MBProgressHUD.show(info: "无相册可用")
                        return
                    }
                } else {
                    MBProgressHUD.show(info: "请开启相册权限")
                    return
                }
               
            })
            let cancleAtion = UIAlertAction(title: "取消", style: .cancel)
            alertCtrl.addAction(camerAction)
            alertCtrl.addAction(albumAction)
            alertCtrl.addAction(cancleAtion)
            self.present(alertCtrl, animated: true)
            break
        case (1, 1): // 性别
            let alert = UIAlertController(title: "", message: "修改性别", preferredStyle: .actionSheet)
            let maleAction = UIAlertAction(title: "男", style: .default, handler: {
                (a) in
                self.update(gender: .male)
            })
            let femaleAction = UIAlertAction(title: "女", style: .default, handler: {
                (a) in
                self.update(gender: .female)
            })
            let otherAction = UIAlertAction(title: "保密", style: .default, handler: {
                (a) in
                self.update(gender: .none)
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(maleAction)
            alert.addAction(femaleAction)
            alert.addAction(otherAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    /**
     判断相机权限
     
     - returns: 有权限返回true，没权限返回false
     */
   private func cameraPermissions() -> Bool{
        
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        if(authStatus == AVAuthorizationStatus.denied || authStatus == AVAuthorizationStatus.restricted) {
            return false
        }else {
            return true
        }
        
    }
    /**
     判断相册权限
     
     - returns: 有权限返回ture， 没权限返回false
     */
    
   private func PhotoLibraryPermissions() -> Bool {
        
        let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if(library == PHAuthorizationStatus.denied || library == PHAuthorizationStatus.restricted){
            return false
        }else {
            return true
        }
    }
}
