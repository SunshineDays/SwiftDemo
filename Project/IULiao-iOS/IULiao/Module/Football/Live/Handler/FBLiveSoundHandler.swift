//
//  FBLiveSoundHandler.swift
//  IULiao
//
//  Created by tianshui on 16/8/9.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import Foundation
import AudioToolbox

/// 声音与震动
class FBLiveSoundHandler: NSObject {
    
    var soundID = SystemSoundID(0)
    
    override init() {
        super.init()
        let path = Bundle.main.path(forResource: "goal", ofType: "wav", inDirectory: "Resource.bundle/sound")
        if let path = path {
            let url = URL(fileURLWithPath: path) as CFURL
            AudioServicesCreateSystemSoundID(url, &soundID)
        }
    }
    
    func playSound() {
        // 播放声音
        AudioServicesPlaySystemSound(soundID)
    }
    
    func playVibrate() {
        // 播放震动
        AudioServicesPlaySystemSound(UInt32(kSystemSoundID_Vibrate))
    }
}
