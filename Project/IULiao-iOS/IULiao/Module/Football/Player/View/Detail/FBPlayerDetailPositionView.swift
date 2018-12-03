//
//  FBPlayerDetailPositionView.swift
//  IULiao
//
//  Created by tianshui on 2017/11/16.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

private let kPaddingTopRate: CGFloat = 3 / 400
private let kPaddingLeftRate: CGFloat = 20 / 400

/// 位置
private enum Position: String {
    case st, f, rb, lb, rm, cf, am, d, cb, dm, gk, rw, lm, ss, cm, m, lw
    
    var point: CGPoint {
        switch self {
        case .st, .f: return CGPoint(x: 7, y: 3)
        case .rb: return CGPoint(x: 2, y: 5)
        case .lb: return CGPoint(x: 2, y: 1)
        case .rm: return CGPoint(x: 5, y: 5)
        case .cf: return CGPoint(x: 9, y: 3)
        case .am: return CGPoint(x: 6, y: 3)
        case .cb, .d: return CGPoint(x: 2, y: 3)
        case .dm: return CGPoint(x: 4, y: 3)
        case .gk: return CGPoint(x: 1, y: 3)
        case .rw: return CGPoint(x: 8, y: 5)
        case .lm: return CGPoint(x: 5, y: 1)
        case .ss: return CGPoint(x: 8, y: 3)
        case .cm, .m: return CGPoint(x: 5, y: 3)
        case .lw: return CGPoint(x: 8, y: 1)
        }
    }
    
    var text: String {
        return rawValue.uppercased()
    }
    
}

/// 球员位置图
class FBPlayerDetailPositionView: UIView {

    
    
    func configView(skill: FBPlayerDetailModel.Skill) {
        let positions = skill.positions.flatMap { Position(rawValue: $0.en.lowercased() ) }
        for (index, position) in positions.enumerated() {
            draw(position: position, isPrimary: index == 0)
        }
    }
    
    private func draw(position: Position, isPrimary: Bool) {
        let x = position.point.x
        let y = position.point.y
        // 球场带边框的 去除padding
        let paddingTop = kPaddingTopRate * width
        let paddingLeft = kPaddingLeftRate * width
        // 每块的大小
        let cellWidth = (width - 2 * paddingLeft) / 9
        let cellHeight = (height - 2 * paddingTop) / 5
        
        // 圆需要放置的位置
        let circleWidth: CGFloat = 30
        let pX = paddingLeft + cellWidth * (x - 1) + (cellWidth - circleWidth) / 2
        let pY = paddingTop + cellHeight * (y - 1) + (cellHeight - circleWidth) / 2
        
        let borderColor = isPrimary ? TSColor.matchResult.win : TSColor.matchResult.lost
        let circleView = UIView(frame: CGRect(x: pX, y: pY, width: circleWidth, height: circleWidth))
        circleView.setCornerRadius(radius: circleWidth / 2 - 1, borderWidth: 2, backgroundColor: .white, borderColor: borderColor)
        
        let circleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: circleWidth, height: circleWidth))
        circleLabel.text = position.text
        circleLabel.font = UIFont.systemFont(ofSize: 12)
        circleLabel.textColor = TSColor.logo
        circleLabel.textAlignment = .center
        
        circleView.addSubview(circleLabel)
        addSubview(circleView)
    }

}
