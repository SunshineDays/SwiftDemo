//
//  ForecastExpertCell.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/14.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

/// 预测专家页
class ForecastExpertCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var resultButton: UIButton!
    
    @IBOutlet weak var matchViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var serialALabel: UILabel!
    @IBOutlet weak var leagueALabel: UILabel!
    @IBOutlet weak var homeTeamALabel: UILabel!
    @IBOutlet weak var awayTeamALabel: UILabel!
    
    @IBOutlet weak var serialBLabel: UILabel!
    @IBOutlet weak var leagueBLabel: UILabel!
    @IBOutlet weak var homeTeamBLabel: UILabel!
    @IBOutlet weak var awayTeamBLabel: UILabel!
    @IBOutlet weak var teamBVSLabel: UILabel!
    
    
    @IBOutlet weak var freeLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var originalPriceLineView: UIView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var currentPriceLabelLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var withdrawButton: UIButton!
    
    @IBOutlet weak var releaseTimeLabel: UILabel!
    
    @IBOutlet weak var historyTimeBackgroundView: UIView!
    @IBOutlet weak var historyReleaseTimeLabel: UILabel!
    
    public var isNotOpen = Bool()
    
    public var model: ForecastExpertHistoryListModel! {
        didSet {
            configCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configCell() {
        titleLabel.text = model.forecast.title
     
        matchViewHeightConstraint.constant = CGFloat(model.detailList.count * 30)
        switch model.detailList.count {
        case 1:
            initMatchAInfo(model: model.detailList[0])
        case 2:
            initMatchAInfo(model: model.detailList[0])
            initMatchBInfo(model: model.detailList[1])
        default:
            break
        }
        serialBLabel.isHidden = model.detailList.count < 2
        leagueBLabel.isHidden = serialBLabel.isHidden
        homeTeamBLabel.isHidden = serialBLabel.isHidden
        awayTeamBLabel.isHidden = serialBLabel.isHidden
        teamBVSLabel.isHidden = serialBLabel.isHidden
        
        isNotOpen(isNotOpen)
        if isNotOpen {
            switch model.forecast.chargeType {
            case .free:
                freeLabel.isHidden = false
                originalPriceLabel.isHidden = true
                originalPriceLineView.isHidden = true
                currentPriceLabel.isHidden = true
                withdrawButton.isHidden = true
            case .lostWithDraw:
                freeLabel.isHidden = true
                originalPriceLabel.isHidden = false
                originalPriceLineView.isHidden = false
                currentPriceLabel.isHidden = false
                withdrawButton.isHidden = false
            case .lostOver:
                freeLabel.isHidden = true
                originalPriceLabel.isHidden = false
                originalPriceLineView.isHidden = false
                currentPriceLabel.isHidden = false
                withdrawButton.isHidden = true
            }
            originalPriceLabel.text = model.forecast.price.moneyText(0) + "料豆"
            currentPriceLabel.text = model.forecast.discount.moneyText(0) + "料豆"
            
        } else {
            historyReleaseTimeLabel.text = model.forecast.createTime.timeString(isIntelligent: true) + "发布"
            resultButton.setBackgroundImage( model.forecast.winNum == 0 ? R.image.forecast.result_lost() : R.image.forecast.result_win(), for: .normal)
            resultButton.setTitle(model.forecast.winNum == 0 ? "黑" : "（\(model.forecast.winNum)/\(model.forecast.num)）红", for: .normal)
            resultButton.isHidden = model.forecast.winStatus == .notOpen
        }
        
        /// 如果价格和折扣价格一样，说明没打折
        if model.forecast.discount == model.forecast.price {
            originalPriceLabel.text = ""
            currentPriceLabelLeftConstraint.constant = 0
        } else {
            currentPriceLabelLeftConstraint.constant = 10
        }
        releaseTimeLabel.text = model.forecast.createTime.timeString(isIntelligent: true) + "发布"
    }
    
    private func isNotOpen(_ isNotOpen: Bool) {
        historyTimeBackgroundView.isHidden = isNotOpen
        resultButton.isHidden = isNotOpen
        titleLabelTrailingConstraint.constant = isNotOpen ? 10 : 75 + 10
    }
    
    private func initMatchAInfo(model: ForecastMatchModel) {
        serialALabel.text = model.serial
        leagueALabel.text = model.leagueName
        homeTeamALabel.text = model.home
        awayTeamALabel.text = model.away
    }
    
    private func initMatchBInfo(model: ForecastMatchModel) {
        serialBLabel.text = model.serial
        leagueBLabel.text = model.leagueName
        homeTeamBLabel.text = model.home
        awayTeamBLabel.text = model.away
    }
}
