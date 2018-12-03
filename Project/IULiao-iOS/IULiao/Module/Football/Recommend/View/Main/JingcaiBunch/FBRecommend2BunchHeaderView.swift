//
//  FBRecommend2BunchHeaderView.swift
//  IULiao
//
//  Created by bin zhang on 2018/4/24.
//  Copyright © 2018年 ShangHai Lianbozhongying Network Technology Co., Ltd. All rights reserved.
//

import UIKit

typealias FBBunchHeaderViewExpandBlock = () -> ()

/// 推荐 竞彩2串1 今日推荐 UITableViewHeaderView
class FBRecommend2BunchHeaderView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var avatarButton: UIButton!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var hitPercentLabel: UILabel!
    
    @IBOutlet weak var lookButton: UIButton!
    
    @IBOutlet weak var lookImageView: UIImageView!

    @IBAction func lookButtonAction(_ sender: UIButton) {
        if let block = expandBlock {
            block()
        }
    }
    
    @IBAction func backgroundAction(_ sender: UIButton) {
        //专家页
        if let model = self.model {
            let vc = FBRecommendExpertController()
            vc.initWith(userId: model.id, oddsType: .jingcai)
            vc.hidesBottomBarWhenPushed = true
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    /**
     * model: FBRecommend2BunchModel
     * isExpand:是否展开列表
     * expandType return 展开状态
     */
    public func setupConfigView(model: FBRecommend2BunchModel, isExpand: Bool = false, expandType: @escaping FBBunchHeaderViewExpandBlock) {
        self.model = model
        if let url = TSImageURLHelper.init(string: model.avatar, w: 120, h: 120).chop(mode: .alwayCrop).url {
            avatarButton.sd_setImage(with: url, for: .normal, placeholderImage: R.image.fbRecommend2.avatar60x60(), completed: nil)
        } else {
            avatarButton.setImage(R.image.fbRecommend2.avatar60x60(), for: .normal)
        }
        nicknameLabel.text = model.nickname
        numberLabel.text = String(format: "%d", model.orderCount)
        resultLabel.text = String(format: "%d中%d", model.order10.orderCount, model.order10.win + model.order10.winHalf)
        hitPercentLabel.text = String(format: "%.2f%%", model.order10.payoffPercent)
        
        self.isExpand = isExpand
        
        expandBlock = expandType
    }
    
    /// 展开状态
    private var expandBlock: FBBunchHeaderViewExpandBlock!
    
    private var isExpand: Bool = false {
        didSet {
            lookImageView.image = isExpand ? R.image.fbRecommend.matchlistOpenup() : R.image.fbRecommend.matchlistOpendown()
        }
    }
    
    private var model: FBRecommend2BunchModel!
    
    
    
}
