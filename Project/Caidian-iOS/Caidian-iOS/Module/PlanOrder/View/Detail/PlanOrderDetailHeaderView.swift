//
//  PlanOrderDetailHeaderView.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation



/// 计划跟单 详情 HeaderView
class PlanOrderDetailHeaderView: UIView {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var lotteryNameLable: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var winStatueLabel: UILabel!
    
    @IBOutlet weak var followUserCountLabel: UILabel!
    @IBOutlet weak var followMoneyLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    public var  tabViewHeaderHeight : CGFloat = 307
    @IBOutlet weak var statueMoneyLabel: UILabel!
    @IBOutlet weak var followSingMoneyLabel: UILabel!
    
    @IBOutlet weak var winImageView: UIImageView!
    
    @IBOutlet weak var ticketOneButton: UIButton!
    @IBOutlet weak var ticketTwoButton: UIButton!
    @IBOutlet weak var ticketThreeButton: UIButton!
    
    @IBOutlet weak var ticketTimeUIView: UIView!
    @IBOutlet weak var statueConstraint: NSLayoutConstraint!
    
    private  var uiViewController :UIViewController?
    

    @IBOutlet weak var saleEndTimeLabel: UILabel!
    @IBOutlet weak var describeViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var bounsLabel: UILabel!
    
    @IBOutlet weak var spLabel: UILabel!
    
    private var selectedButton = UIButton()
    
    var  statueConstraintHeight :CGFloat = 0{
        didSet{
            statueConstraint.constant = statueConstraintHeight
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        describeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newDetail)))
        describeLabel.isUserInteractionEnabled = false

    }
    
    private var planDetailModel: PlanOrderDetailModel!
    
    
    func getHeight() -> CGFloat {
        
        /// tabviewHeaderView 原有的高度 + 奖金一行的高度 + remark的修改后的高度- remark的高度   (remark的高度 原有的高度已包含在tabviewHeaderView  因此减去)
        return tabViewHeaderHeight + statueConstraintHeight + describeViewConstraint.constant - 75
    }
    
    func configView(
        uiViewController :UIViewController,
        planModel :PlanModel,
        planDetailModel:PlanOrderDetailModel,
        planOrderFollowAccountModelList:[PlanOrderFollowAccountModel]
        )
    {
        
    self.planDetailModel = planDetailModel
        
        self.uiViewController = uiViewController
        
        saleEndTimeLabel.text = "预计\(TSUtils.timestampToString(planDetailModel.saleEndTime +  30*60, withFormat: "HH:mm"))上传实票"
        
        titleLabel.text = planDetailModel.title
        authorLabel.text = "\(planModel.author)发起"
        lotteryNameLable.text = TSUtils.timestampToString(planDetailModel.saleEndTime, withFormat: "MM-dd")  + "  \(planDetailModel.lotteryName) "
        
        winStatueLabel.text = planDetailModel.winStatus.name
        followMoneyLabel.text = planDetailModel.followMoney.moneyText()
        followUserCountLabel.text = "\(planDetailModel.followUser)"
        
        var winStatueLabelString = ""
        var winStatueLabelColor : UIColor = UIColor.grayGamut.gamut666666
        
        /// 购买金额
        var accountMoney = 0
        /// 中奖金额
        var accountBonus = 0.00
        
        planOrderFollowAccountModelList.forEach{
            accountMoney += $0.buyMoney
            accountBonus += $0.bonus
        }
      

        describeLabel.numberOfLines = 1
        describeLabel.textAlignment = .center
        describeLabel.font = UIFont.systemFont(ofSize: 14) //调整文字大小

        describeLabel.isUserInteractionEnabled = accountMoney == 0
        describeViewConstraint.constant = 75
        //未购买
        if accountMoney == 0 {
            let remark = planDetailModel.remark ?? ""
            if remark.isEmpty  {
                describeLabel.text = "如何合理跟单"
                describeLabel.isUserInteractionEnabled = true
                describeLabel.textColor = UIColor.matchResult.lost
            }else{
                describeLabel.isUserInteractionEnabled = false
                self.labelRemark(remark:remark, labelView: describeLabel)
            }
        
    
        }else{
            //已购买
            let attrStr = NSMutableAttributedString()
            attrStr.append(NSAttributedString(string: "您已认购 ", attributes: [:]))
            attrStr.append(NSAttributedString(string: accountMoney.moneyText(), attributes: [NSAttributedStringKey.foregroundColor: UIColor.matchResult.lost]))
            attrStr.append(NSAttributedString(string: " 元", attributes: [:]))
            describeLabel.attributedText = attrStr
        }
        
        /// 截止之前 -> 认购中
        if planDetailModel.saleEndTime >= NSDate().timeIntervalSince1970{
            winStatueLabelString = "认购中"
            winStatueLabelColor =  UIColor.matchResult.lost
        }
        
        /// 截止之后 没有上传图片  -> 出票中
        if planDetailModel.saleEndTime < NSDate().timeIntervalSince1970 && planDetailModel.ticketImgs.count == 0 {
            winStatueLabelString = "出票中"
            winStatueLabelColor = UIColor.matchResult.win
        }
        
        /// 截止&&上传图片 ->
        if planDetailModel.saleEndTime < NSDate().timeIntervalSince1970 && planDetailModel.ticketImgs.count != 0 {

            ticketTimeUIView.isHidden = true
            
            // 显示票据
            let buttons = [ticketOneButton, ticketTwoButton, ticketThreeButton]
            for (index, ticketImageString) in planDetailModel.ticketImgs.enumerated() {
                let urlString = URL(string: TSImageURLHelper(string: ticketImageString, size: CGSize(width: 160, height: 160)).chop().urlString)
                buttons[index]?.sd_setBackgroundImage(with: urlString, for: .normal, placeholderImage: R.image.empty.image120x160(), options: [.retryFailed, .progressiveDownload], completed: nil)
                buttons[index]?.tag = index
                buttons[index]?.addTarget(self, action: #selector(showImageAction(_:)), for: .touchUpInside)
            }

            
            /// 已开奖情况下  未中奖或者中奖情况下  才显示方案中奖情况描述
            if planDetailModel.winStatus == OrderWinStatusType.notOpen {
                winStatueLabelString = "已出票"
                winStatueLabelColor = UIColor.matchResult.win
                statueConstraintHeight = 0
                
            }else if planDetailModel.winStatus == OrderWinStatusType.lost{
                
                winStatueLabelString = "未中奖"
                winStatueLabelColor = UIColor.grayGamut.gamut666666
                statueConstraintHeight = 40
                statueMoneyLabel.isHidden = false
                resultView.isHidden = true
                statueMoneyLabel.text = "本方案未中奖"
                statueMoneyLabel.textColor = UIColor.grayGamut.gamut666666
                
            }else if planDetailModel.winStatus  == OrderWinStatusType.win{
                
                winStatueLabelString = "已中奖"
                winStatueLabelColor = UIColor.matchResult.win
                statueConstraintHeight = 40
                statueMoneyLabel.isHidden = true
                resultView.isHidden = false
                
                bounsLabel.text = planDetailModel.bonus.moneyText(2)
                spLabel.text = planDetailModel.sp
                
                // 用户中奖 金额描述
                if accountMoney != 0 {
                    let attrStr = NSMutableAttributedString()
                    attrStr.append(NSAttributedString(string: "您已认购 ", attributes: [:]))
                    attrStr.append(NSAttributedString(string: accountMoney.moneyText(), attributes: [NSAttributedStringKey.foregroundColor: UIColor.matchResult.lost]))
                    attrStr.append(NSAttributedString(string: " 元, ", attributes: [:]))
                    attrStr.append(NSAttributedString(string: "中奖 ", attributes: [:]))
                    attrStr.append(NSAttributedString(string: accountBonus.moneyText(2), attributes: [NSAttributedStringKey.foregroundColor: UIColor.matchResult.win]))
                    attrStr.append(NSAttributedString(string: " 元 ", attributes: [:]))
                    describeLabel.attributedText = attrStr
                    
                }
                
                winImageView.isHidden = false
            }
        
        }
        
        winStatueLabel.textColor = winStatueLabelColor
        winStatueLabel.text = winStatueLabelString
        self.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: getHeight())
    }
    
    /// 如何合理跟单
    
    @objc func newDetail() {
        let ctrl = TSEntryViewControllerHelper.newsDetailViewController(newsId: 59)
        ctrl.hidesBottomBarWhenPushed = true
        uiViewController?.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
    @objc func showImageAction(_ sender: UIButton) {
        selectedButton = sender
        let browser = YBImageBrowser()
        browser.dataSource = self
        browser.currentIndex = UInt(sender.tag)
        browser.show()
    }
    
    /// 用户购买提示显示规则  需求 最多显示两行...

    func labelRemark(remark :String ,labelView : UILabel) {
  
        let attrStr = NSMutableAttributedString()
        let smileImage : UIImage = R.image.order.message()!
        let textAttachment : NSTextAttachment = NSTextAttachment()
        textAttachment.image = smileImage
        textAttachment.bounds = CGRect(x: 0, y: -3, width: 15, height: 15)
        attrStr.append(NSAttributedString(attachment: textAttachment))
        attrStr.append(NSAttributedString(string: " ", attributes: [:]))
        attrStr.append(NSAttributedString(string: remark, attributes: [NSAttributedStringKey.foregroundColor: UIColor.grayGamut.gamut999999]))
        
        //调整行间距
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6.0
        attrStr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: remark.count))

        describeLabel.font=UIFont.systemFont(ofSize: 12) //调整文字大小
        describeLabel.attributedText = attrStr
        describeLabel.lineBreakMode = .byTruncatingTail
        describeLabel.textAlignment = .left
        let size = remark.boundingRect(with: CGSize(width: describeLabel.frame.width, height: 8000), options: .usesLineFragmentOrigin, attributes: [.font: describeLabel.font], context: nil)
        if size.height < 20 {
            describeViewConstraint.constant = 75
        }else{
           describeLabel.numberOfLines = 2
           describeViewConstraint.constant = 95
        }
    }
}

extension PlanOrderDetailHeaderView: YBImageBrowserDataSource {
    func imageViewOfTouch(for imageBrowser: YBImageBrowser) -> UIImageView? {
        return selectedButton.imageView
    }

    func number(in imageBrowser: YBImageBrowser) -> Int {
        return planDetailModel.ticketImgs.count
    }

    func yBImageBrowser(_ imageBrowser: YBImageBrowser, modelForCellAt index: Int) -> YBImageBrowserModel {
        let model = YBImageBrowserModel()
        model.url = URL(string: planDetailModel.ticketImgs[index])
        model.sourceImageView = selectedButton.imageView
        return model
    }


}

