//
//  RecommendCartContentCell.swift
//  Caidian-iOS
//
//  Created by Sunshine Days on 2018/9/12.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit

class RecommendCartContentCell: UITableViewCell {
    
    @IBOutlet weak var selectedRowButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var betContentLabel: UILabel!
    
    @IBOutlet weak var betSuccessLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    typealias SelectedBlock = (_ isSelected: Bool) -> Void
    
    private var selectedBlock: SelectedBlock!
    
    private var model: RecommendExpertListModel!
    
    private var isSetting = Bool()
    
    public func configCell(model: RecommendExpertListModel, isSetting: Bool, selectedBlock: @escaping SelectedBlock) {
        self.model = model
        titleLabel.text = "【" + model.serial + "】" + model.title
        betContentLabel.text = TSPublicTool.footballCodeString(betKeyTypes: model.code, letBall: model.odds.letBall)
        self.selectedBlock = selectedBlock
        self.isSetting = isSetting
//        if isSetting {
//            selectedBlock(selectedRowButton.isSelected)
//        }
        if isSetting {
            selectedRowButton.isSelected = model.isSelectedToDelete
        } else {
            selectedRowButton.isSelected = model.isSelectedToBuy
        }

        betSuccessLabel.isHidden = !UserToken.shared.isBuySuccessInCart(with: model.id)
    }
    
    @IBAction func selectedAction(_ sender: UIButton) {
        selectedRowButton.isSelected = !selectedRowButton.isSelected
        
        if isSetting {
            model.isSelectedToDelete = !model.isSelectedToDelete
            selectedBlock(model.isSelectedToDelete)
        } else {
            model.isSelectedToBuy = !model.isSelectedToBuy
            selectedBlock(model.isSelectedToBuy)
        }
        
//        selectedBlock(selectedRowButton.isSelected)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedRowButton.setImage(R.image.cartSelectedDefault(), for: .normal)
        selectedRowButton.setImage(R.image.cartSelectedSelected(), for: .selected)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
