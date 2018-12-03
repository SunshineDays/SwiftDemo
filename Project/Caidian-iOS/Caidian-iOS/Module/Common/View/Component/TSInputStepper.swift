//
//  TSInputStepper.swift
//  Caidian-iOS
//
//  Created by tianshui on 2018/4/23.
//  Copyright © 2018年 com.caidian310. All rights reserved.
//

import UIKit
import SnapKit

// 带输入框的stepper
class TSInputStepper: UIView, UITextFieldDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    
    private var _value = 1 {
        didSet {
            inputTextField.text = "\(_value)"
            valueChangedBlock?(_value)
        }
    }
    var minimumValue = 1
    var maximumValue = Int.max
    var stepValue = 1
    var value: Int {
        get {
            return _value
        }
        set {
            let v = filterValue(v: newValue)
            if newValue != _value {
                _value = v
            }
        }
    }
    var valueChangedBlock: ((_ value: Int) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        inputTextField.delegate = self
        inputTextField.addTarget(self, action: #selector(editingChangedAction(_:)), for: .editingChanged)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromNib()
    }
    
    private func initViewFromNib() {
        contentView = R.nib.tsInputStepper().instantiate(withOwner: self, options: nil).first as! UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        contentView.snp.makeConstraints {
            make in
            make.edges.equalToSuperview()
        }
    }
    
    private func filterValue(v: Int) -> Int {
        var v = v
        v = min(v, maximumValue)
        v = max(v, minimumValue)
        return v
    }

    @IBAction func minusBtnAction(_ sender: UIButton) {
        value -= 1
    }
    
    @IBAction func plusBtnAction(_ sender: UIButton) {
        value += 1
    }
    
    @IBAction func inputTextFieldEditingDidEndAction(_ sender: UITextField) {
        let text = sender.text ?? ""
        if (sender.text?.isEmpty)! || Int(sender.text!)! < 1 {
            sender.text = "1"
        }
        if let v = Int(text) {
            value = v
        }
    }
    
    @objc private func editingChangedAction(_ textField: UITextField) {
        let text = textField.text ?? ""
        if let v = Int(text) {
            value = v
        }
    }
}
