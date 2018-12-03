//
//  PlanOrderDetailFooterView.swift
//  Caidian-iOS
//
//  Created by mac on 2018/5/30.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import Foundation

/// 计划跟单 详情 FooterView
class PlanOrderDetailFooterView : UIView {
    
    public var  deafaultTabFooterViewHeight : CGFloat = 135
    @IBOutlet weak var bottomImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBOutlet weak var moreBtn: UIButton!
    
    func configView(planOrderFollowAccountModelList :[PlanOrderFollowAccountModel],page:Int,pageModel :TSPageInfoModel)  {
        
        self.frame = CGRect(x: 0, y: 0, width: TSScreen.currentWidth, height: deafaultTabFooterViewHeight)
        // 最后一页
        if planOrderFollowAccountModelList.count == 0 {
            moreBtn.setTitle("暂无数据", for: UIControlState.normal)
            moreBtn.isEnabled = false
        }else if  page == pageModel.pageCount{
            moreBtn.setTitle("已加载全部数据", for: UIControlState.normal)
            moreBtn.isEnabled = false
        }else{
            moreBtn.setTitle("点击查看更多", for: UIControlState.normal)
            moreBtn.isEnabled = true
        }
    }
}
