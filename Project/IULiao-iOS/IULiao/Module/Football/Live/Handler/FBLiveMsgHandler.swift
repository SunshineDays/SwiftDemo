//
//  FBLiveMsgHandler.swift
//  IULiao
//
//  Created by tianshui on 16/8/2.
//  Copyright © 2016年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import SwiftyJSON

/// 即时比分消息
/// 1.先正常同url请求消息(pull)
/// 2.判断消息liveNum是否漏消息
/// 3.漏消息处理漏掉的消息
/// 4.不漏消息n秒后循环1过程
/// 5.当收到极光推送的数据后停止1流程改为push流程 漏消息逻辑不变
class FBLiveMsgHandler: BaseHandler {
    
    typealias UpdateBlock = ((_ msgMatchList: [FBLiveMatchModel2], _ isNeedRefresh: Bool) -> Void)
    
    private var timer: Timer?
    private var retry = 0
    private var isReviseing = false
    
    private var lastMsg: FBLiveMsgModel?
    private var currentLiveNum: Int
    /// 极光推送消息
    private var isPushMessage = false
    
    var intervalTime: TimeInterval = 3
    var updateBlock: UpdateBlock?
    
    init(liveNum: Int) {
        currentLiveNum = liveNum
        super.init()
        initListener()
    }
    
    func start(_ callback: UpdateBlock? = nil) {
        updateBlock = callback
        loop(interval: 2)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
    }
    
    private func loop(interval: TimeInterval) {
        stop()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(requestLiveMsg), userInfo: nil, repeats: false)
    }
    
    /// 通过url取消息
    @objc func requestLiveMsg() {
        getLiveMsg(
            success: {
                [weak self] (msg) in
                self?.receiveMsg(msg: msg)
        })
    }
    
    /// 收到消息
    private func receiveMsg(msg: FBLiveMsgModel) {
        // 继续取消息 补漏时加快循环速度
        if !isPushMessage {
            loop(interval: isReviseing ? 1.0 : intervalTime)
        }
        
        // 与上条消息相同 不处理
        if lastMsg != nil && lastMsg! == msg {
            return
        }
        
        // 需要刷新
        if lastMsg?.refreshFlag != nil && lastMsg?.refreshFlag != msg.refreshFlag {
            updateBlock?(msg.matchList, true)
            stop()
            return
        }
        if msg.nextLiveNum - currentLiveNum > 50 {
            // 误差超过50通知刷新
            updateBlock?(msg.matchList, true)
            stop()
            return
        } else if msg.nextLiveNum - currentLiveNum > 1 {
            // 需要进行消息补漏
            isReviseing = true
            revise()
            return
        }
        
        isReviseing = false
        lastMsg = msg
        currentLiveNum = msg.nextLiveNum
        updateBlock?(msg.matchList, false)
    }
    
    /// 修正错误消息
    private func revise() {
        getLiveMsg(
            liveNum: currentLiveNum,
            success: {
                [weak self] msg in
                guard let me = self else {
                    return
                }
                
                // 与上条消息相同 不处理
                if me.lastMsg != nil && me.lastMsg! == msg {
                    return
                }
                
                if msg.nextLiveNum == 0 {
                    me.retryTimes()
                    return
                }
                
                me.retry = 0
                me.lastMsg = msg
                me.currentLiveNum = msg.nextLiveNum
                
                me.updateBlock?(msg.matchList, false)
            },
            failed: {
                [weak self]error in
                self?.retryTimes()
        })
    }
    
    /// 重试次数
    private func retryTimes() {
        retry += 1
        if retry > 10 {
            currentLiveNum += 1
            retry = 0
        }
    }
    
    /// 即时比分消息
    private func getLiveMsg(liveNum: Int? = nil, success: @escaping ((_ msg: FBLiveMsgModel) -> Void), failed: FailedBlock? = nil) {
        let router = TSRouter.fbLiveMsg(liveNum: liveNum)
        defaultRequestManager.requestWithRouter(
            router,
            expires: 0,
            success: {
                (json) -> Void in
                let msg = FBLiveMsgModel(json: json)
                success(msg)
            },
            failed: {
                (error) -> Bool in
                failed?(error)
                return false
        })
    }
    
    /// 极光推送接受自定义消息
    @objc private func networkDidReceiveMessage(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let title = userInfo["title"] as? String,
            let extras = userInfo["extras"],
            title == "live"
            else {
                return
        }
        isPushMessage = true
        stop()
        let msg = FBLiveMsgModel(json: JSON(extras))
        receiveMsg(msg: msg)
    }
    
    private func initListener() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage(notification:)), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
    }
    
    deinit {
        log.info("deinit live msg")
        NotificationCenter.default.removeObserver(self)
        stop()
    }
}
