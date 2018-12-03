//
//  FireWorkButton.swift
//  FireWorkButton
//
//  Created by 李来伟 on 2017/8/14.
//  Copyright © 2017年 李来伟. All rights reserved.
//

import UIKit

class FBRecommendFireWorkButton: UIButton {

    func popOutsideWithDuration(duration: TimeInterval) {
        transform = CGAffineTransform.identity
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: 0), animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3.0, animations: {
                [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/3.0, relativeDuration: 1/3.0, animations: {
                [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            })
            UIView.addKeyframe(withRelativeStartTime: 2/3.0, relativeDuration: 1/3.0, animations: {
                [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            })

        }) { (_) in
            
        }
      
    }
    
    func popInsideWithDuration(duration: TimeInterval) {
        transform = CGAffineTransform.identity
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: UIViewKeyframeAnimationOptions(rawValue: 0), animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/2.0, animations: {
                [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2.0, relativeDuration: 1/2.0, animations: {
                [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            })

        }) { (_) in
            
        }

    }

}
