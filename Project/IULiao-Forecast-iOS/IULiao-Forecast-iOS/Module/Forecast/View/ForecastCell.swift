//
//  ForecastCell.swift
//  IULiao-Forecast-iOS
//
//  Created by Sunshine Days on 2018/11/12.
//  Copyright © 2018 Sunshine Days. All rights reserved.
//

import UIKit

protocol ForecastCellDelegate: class {
    func ForecastCell(_ cell: ForecastCell, avatarButtonClick sender: UIButton, userId: Int)
    func ForecastCell(_ cell: ForecastCell, withdrawButtonClick sender: UIButton, alertController: UIAlertController)
}

/// 预测主页
class ForecastCell: UITableViewCell {

    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var keepWinButton: UIButton!
    
    @IBOutlet weak var profitLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var serialALabel: UILabel!
    @IBOutlet weak var leagueALabel: UILabel!
    @IBOutlet weak var homeTeamALabel: UILabel!
    @IBOutlet weak var awayTeamALabel: UILabel!
    
    @IBOutlet weak var serialBLabel: UILabel!
    @IBOutlet weak var leagueBLabel: UILabel!
    @IBOutlet weak var homeTeamBLabel: UILabel!
    @IBOutlet weak var awayTeamBLabel: UILabel!
    @IBOutlet weak var teamBVSLabel: UILabel!
    
    @IBOutlet weak var matchViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var freeLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var originalPriceLineView: UIView!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var currentPriceLabelLeftConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var withdrawButton: UIButton!

    @IBOutlet weak var releaseTimeLabel: UILabel!
    
    public weak var delegate: ForecastCellDelegate?
    
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
    

}


extension ForecastCell {
    private func configCell() {
        
        avatarButton.sd_setImage(
            with: URL(string: ImageURLHelper(string: model.user?.avatar, w: 90, h: 90).chop().urlString), for: .normal,
            placeholderImage: R.image.empty.avatar_90x90(), completed: nil)
        
        nicknameLabel.text = model.user?.nickname
        keepWinButton.setTitle("\(model.user?.keepWin ?? 0)连红", for: .normal)
        profitLabel.text = model.user?.payoff
        
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
            
        
        /// 如果价格和折扣价格一样，说明没打折
        if model.forecast.discount == model.forecast.price {
            originalPriceLabel.text = ""
            currentPriceLabelLeftConstraint.constant = 0
        } else {
            currentPriceLabelLeftConstraint.constant = 10
        }
        
        releaseTimeLabel.text = model.forecast.createTime.timeString(isIntelligent: true) + "发布"
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


extension ForecastCell {
    @IBAction func avatarButtonClick(_ sender: UIButton) {
        delegate?.ForecastCell(self, avatarButtonClick: sender, userId: model.user?.id ?? 0)
    }
    
    @IBAction func withdrawButtonClick(_ sender: UIButton) {
//        let message = "\n免费：不产生料豆消耗可查看预测内容。 \n不中包退：支付料豆查看后，预测内容红了即收费，黑了则退还料豆。"
//        let alertController = UIAlertController(title: "收费类型", message: message, preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: nil))
//        delegate?.ForecastCell(self, withdrawButtonClick: sender, alertController: alertController)
    }
}
