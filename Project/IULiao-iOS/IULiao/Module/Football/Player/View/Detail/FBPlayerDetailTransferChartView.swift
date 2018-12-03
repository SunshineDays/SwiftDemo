//
//  FBPlayerDetailTransferChartView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit


/// 球员 转会图表
class FBPlayerDetailTransferChartView: UIView {

    /// 转会历史
    private var transferList = [FBPlayerDetailModel.Transfer]()
    /// 当前身价
    private var currentMoney = 0

    func configView(transferList: [FBPlayerDetailModel.Transfer], currentMoney: Int) {
        self.transferList = transferList
        self.currentMoney = currentMoney
        setNeedsDisplay()
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        guard let minTime = transferList.first?.beginDate?.timeIntervalSince1970 else {
            return
        }
        let maxTime = Foundation.Date().timeIntervalSince1970
        // 转会时的最高身价
        let transferMaxMoney = transferList.map({ $0.money }).max() ?? currentMoney
        // 最高时的价格(不一定是转会时最高)
        let maxMoney = max(transferMaxMoney , currentMoney)
        
        drawTransferHistoryLine(minTime: minTime, maxTime: maxTime, maxMoney: maxMoney, transferList: transferList)
        drawMaxMoneyLine(transferMaxMoney: transferMaxMoney, maxMoney: maxMoney)
        drawCurrentMoneyLine(currentMoney: currentMoney, maxMoney: maxMoney)
    }
    
    private func drawTransferHistoryLine(minTime: Double, maxTime: Double, maxMoney: Int, transferList:[FBPlayerDetailModel.Transfer]) {
        
        // 折线
        let line = UIBezierPath()
        line.lineCapStyle = .square
        line.lineWidth = 3
        
        // 面积
        let area = UIBezierPath()
        
        for (index, transfer) in transferList.enumerated() {
            var x: CGFloat = 0
            var y: CGFloat = height
            if index != 0 {
                // 坐标点
                let prevTransfer = transferList[index - 1]
                let prevTime = prevTransfer.beginDate?.timeIntervalSince1970 ?? 0
                
                x = width * CGFloat((prevTime - minTime) / (maxTime - minTime))
                if maxMoney != 0 {
                    y = height * CGFloat(maxMoney - transfer.money) / CGFloat(maxMoney)
                }
            }
            
            if index == 0 {
                line.move(to: CGPoint(x: x, y: y))
                area.move(to: CGPoint(x: x, y: y))
            } else {
                line.addLine(to: CGPoint(x: x, y: y))
                area.addLine(to: CGPoint(x: x, y: y))
            }
        }
        
        TSColor.matchResult.draw.setStroke()
        line.stroke()
        
        
        let lastPoint = area.currentPoint
        area.addLine(to: CGPoint(x: width, y: lastPoint.y))
        area.addLine(to: CGPoint(x: width, y: height))
        UIColor(hex: 0xf1dcc8).setFill()
        area.fill()
    }

    /// 绘制转会时最高身价
    private func drawMaxMoneyLine(transferMaxMoney: Int, maxMoney: Int) {
        drawMoneyLine(money: transferMaxMoney, maxMoney: maxMoney, color: TSColor.matchResult.draw)
    }

    /// 绘制目前身价
    private func drawCurrentMoneyLine(currentMoney: Int, maxMoney: Int) {
        drawMoneyLine(money: currentMoney, maxMoney: maxMoney, color: TSColor.logo)
    }
    
    private func drawMoneyLine(money: Int, maxMoney: Int, color: UIColor) {
        var y: CGFloat = 0
        if maxMoney != 0 {
            y = height * CGFloat(maxMoney - money) / CGFloat(maxMoney)
        }
        let currentLine = UIBezierPath()
        currentLine.lineCapStyle = .square
        currentLine.lineWidth = 1
        
        currentLine.move(to: CGPoint(x: 0, y: y))
        currentLine.addLine(to: CGPoint(x: width, y: y))
        color.setStroke()
        currentLine.stroke()
        
        let currentString = "\(money)" as NSString
        currentString.draw(at: CGPoint(x: 2, y: y + 2), withAttributes: [
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: color
        ])
    }
}
