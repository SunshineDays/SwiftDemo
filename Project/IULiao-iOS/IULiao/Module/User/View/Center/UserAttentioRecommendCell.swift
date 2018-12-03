//
//  UserAttentioRecommendCell.swift
//  IULiao
//
//  Created by levine on 2017/9/2.
//  Copyright © 2017年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class UserAttentioRecommendCell: UITableViewCell {

    @IBOutlet weak var lNameLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var homeLabel: UILabel!

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var oddsLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!

    @IBOutlet weak var payoffLabel: UILabel!

    @IBOutlet weak var payPercentLabel: UILabel!

    @IBOutlet weak var analysisLabel: UILabel!
    @IBOutlet weak var recommendAnalystLabel: UILabel!

    
    @IBOutlet weak var monthTimeLabel: UILabel!
    @IBOutlet weak var resultImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configAttentionRecommendHistoryModel(recommendHistoryModel: FBRecommendExpertHistoryModel?) {
        if let recommendHistoryModel = recommendHistoryModel {
            
            resultImageView.image = recommendHistoryModel.resultType.jingCaiImage
            resultImageView.isHidden =  recommendHistoryModel.resultType == GuessResultType.noOpen
            lNameLabel.text = recommendHistoryModel.match.league.name
            lNameLabel.textColor = recommendHistoryModel.match.league.color
            monthLabel.text = recommendHistoryModel.monthDay
            timeLabel.text = recommendHistoryModel.hourMinute
            if recommendHistoryModel.resultType == GuessResultType.noOpen {
                scoreLabel.text = "vs"
                
            }else {
                scoreLabel.text =  "\(recommendHistoryModel.match.homeScore ?? 0)-\(recommendHistoryModel.match.awayScore ?? 0)"
                scoreLabel.textColor = FBColorType.red.color
            }
            homeLabel.text = recommendHistoryModel.match.home
            awayLabel.text = recommendHistoryModel.match.away
            oddsLabel.text =  recommendHistoryModel.oddsType.oddsName + "："
            oddsLabel.textColor = recommendHistoryModel.oddsType.oddsColor
            //显示 发布推荐类型
            

            recommendAnalystLabel.text = recommendHistoryModel.user.nickName
            monthTimeLabel.text = "\(recommendHistoryModel.matchCreated ?? "")"
            //颜色变化
            var resultText1: String = ""
            var resultText2: String = ""
            var payoffText: String = ""
            if recommendHistoryModel.oddsType == OddStype.guess {
                for  beton in recommendHistoryModel.betons {
                    if OddsTypeString.win.rawValue == beton.betKey {
                        resultText2 += "胜、"
                        payoffText += "(" + String(format: "%.2f", beton.sp) + ")、"
                    } else if OddsTypeString.draw.rawValue == beton.betKey {
                        resultText2 += "平、"
                        payoffText += "(" + String(format: "%.2f", beton.sp) + ")、"
                    } else if OddsTypeString.lost.rawValue == beton.betKey {
                        resultText2 += "负、"
                        payoffText += "(" + String(format: "%.2f", beton.sp) + ")、"
                    } else if OddsTypeString.letWin.rawValue == beton.betKey {
                        resultText2 += "让胜、"
                        payoffText += "(" + String(format: "%.2f", beton.sp) + ")、"
                    } else if OddsTypeString.letDraw.rawValue == beton.betKey {
                        resultText2 += "让平、"
                        payoffText += "(" + String(format: "%.2f", beton.sp) + ")、"
                    } else if OddsTypeString.letLost.rawValue == beton.betKey {
                        resultText2 += "让负、"
                        payoffText += "(" + String(format: "%.2f", beton.sp) + ")、"
                    }
                }
                
                resultLabel.text = (resultText2 as NSString).substring(to: resultText2.count - 1)
                payPercentLabel.text = (payoffText as NSString).substring(to: payoffText.count - 1)
            }else {
                for  beton in recommendHistoryModel.betons {
                    if OddsTypeString.big.rawValue == beton.betKey {
                        resultText1 = "大"
                    } else if OddsTypeString.small.rawValue == beton.betKey {
                        resultText1 = "小"
                    } else if OddsTypeString.above.rawValue == beton.betKey {
                        resultText1 = "主"
                    } else  {
                        resultText1 = "客"
                    }
                     payoffText = "(" + String(format: "%.2f", beton.sp) + ")"
                }
                resultLabel.text = resultText1
                payPercentLabel.text = payoffText

            }

            
            
        }
        
    }

}
