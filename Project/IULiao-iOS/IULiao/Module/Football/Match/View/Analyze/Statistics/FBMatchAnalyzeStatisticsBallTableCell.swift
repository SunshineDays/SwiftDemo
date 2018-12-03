//
//  FBMatchAnalyzeStatisticsBallTableCell.swift
//  IULiao
//
//  Created by tianshui on 2017/12/4.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 赛况 控球cell
class FBMatchAnalyzeStatisticsBallTableCell: UITableViewCell {

    @IBOutlet weak var homeCountLabel: UILabel!
    @IBOutlet weak var awayCountLable: UILabel!
    @IBOutlet weak var ballView: FBMatchAnalyzeStatisticsBallView!
    
    func configCell(homeCount: Int, awayCount: Int) {
        
        ballView.configView(homeCount: homeCount, awayCount: awayCount)
        let total = homeCount + awayCount
        guard total > 0 else {
            homeCountLabel.text = "\(homeCount)%"
            awayCountLable.text = "\(awayCount)%"
            return
        }
        
        homeCountLabel.text = (Float(homeCount) / Float(total) * 100).decimal(0) + "%"
        awayCountLable.text = (Float(awayCount) / Float(total) * 100).decimal(0) + "%"
    }

}

/// 控球率百分条
class FBMatchAnalyzeStatisticsBallView: UIView {
    
    private var homeCount = 50
    private var awayCount = 50
    
    override func draw(_ rect: CGRect) {
        let total = homeCount + awayCount
        let maxY: CGFloat = 10
        // 间隔
        let offset: CGFloat = 2
        // 箭头宽度
        let arrowWidth: CGFloat = 5
        var x = CGFloat(homeCount) / CGFloat(total) * width
        x = max(arrowWidth + offset, x)
        x = min(width - arrowWidth - offset, x)
        
        let lightColor = UIColor(hex: 0xFCCA97)
        let darkColor = UIColor(hex: 0xFC7939)
        var homeColor = lightColor
        if homeCount > awayCount {
            homeColor = darkColor
        }
        var awayColor = lightColor
        if awayCount > homeCount {
            awayColor = darkColor
        }
        
        let home = UIBezierPath()
        home.move(to: CGPoint(x: 0, y: 0))
        home.addLine(to: CGPoint(x: x - offset / 2, y: 0))
        home.addLine(to: CGPoint(x: x - offset / 2 - arrowWidth, y: maxY))
        home.addLine(to: CGPoint(x: 0, y: maxY))
        homeColor.setFill()
        home.fill()
        
        let away = UIBezierPath()
        away.move(to: CGPoint(x: x + offset, y: 0))
        away.addLine(to: CGPoint(x: width, y: 0))
        away.addLine(to: CGPoint(x: width, y: maxY))
        away.addLine(to: CGPoint(x: x + offset - arrowWidth, y: maxY))
        awayColor.setFill()
        away.fill()
    }
    
    func configView(homeCount: Int, awayCount: Int) {
        var homeCount = homeCount
        var awayCount = awayCount
        if homeCount == 0 && awayCount == 0 {
            homeCount = 50
            awayCount = 50
        }
        self.homeCount = homeCount
        self.awayCount = awayCount
        setNeedsDisplay()
    }
}
