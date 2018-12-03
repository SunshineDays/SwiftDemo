//
//  FBMatchWarRecentTableFooterView.swift
//  IULiao
//
//  Created by tianshui on 2017/12/7.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

/// 赛事分析 战绩 表尾统计
class FBMatchWarRecentTableFooterView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    
    func configView(teamName: String?, statistics: FBMatchWarStatisticsHelper.Statistics) {
        
        let attrString = NSMutableAttributedString()
        
        if let teamName = teamName {
            attrString.append(NSAttributedString(string: teamName + " ", attributes: [
                .foregroundColor: TSColor.homeTeam,
                ]))
        }
        
        attrString.append(NSAttributedString(string: "\(statistics.win)胜", attributes: [
            .foregroundColor: TSColor.matchResult.win,
            ]))
        
        attrString.append(NSAttributedString(string: "\(statistics.draw)平", attributes: [
            .foregroundColor: TSColor.matchResult.draw,
            ]))
    
        attrString.append(NSAttributedString(string: "\(statistics.lost)负", attributes: [
            .foregroundColor: TSColor.matchResult.lost,
            ]))
    
        
        attrString.append(NSAttributedString(string: "，进", attributes: [
            .foregroundColor: TSColor.gray.gamut333333,
            ]))
        attrString.append(NSAttributedString(string: "\(statistics.goal)", attributes: [
            .foregroundColor: TSColor.matchResult.win,
            ]))
        attrString.append(NSAttributedString(string: "球", attributes: [
            .foregroundColor: TSColor.gray.gamut333333,
            ]))
        
        attrString.append(NSAttributedString(string: "失", attributes: [
            .foregroundColor: TSColor.gray.gamut333333,
            ]))
        attrString.append(NSAttributedString(string: "\(statistics.fumble)", attributes: [
            .foregroundColor: TSColor.matchResult.lost,
            ]))
        attrString.append(NSAttributedString(string: "球", attributes: [
            .foregroundColor: TSColor.gray.gamut333333,
            ]))
        
        attrString.addAttributes([.font: UIFont.systemFont(ofSize: 12)], range: NSRange(location: 0, length: attrString.string.count))
        
        titleLabel.attributedText = attrString
        
    }
}
