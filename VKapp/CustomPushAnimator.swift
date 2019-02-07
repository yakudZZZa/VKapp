//
//  CustomPushAnimator.swift
//  Weather
//
//  Created by Евгений Иванов on 02/12/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

final class CustomPushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        source.view.layer.anchorPoint = CGPoint(x:1, y:0)
        destination.view.layer.anchorPoint = CGPoint(x:1, y:0)
        source.view.layer.position = CGPoint(x:source.view.frame.width, y:0)
        destination.view.layer.position = CGPoint(x:destination.view.frame.width, y:0)
        destination.view.frame = source.view.frame
        
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        UIView.animateKeyframes(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.2,
                    relativeDuration: 0.6,
                    animations: {
                        let rotation = CGAffineTransform(rotationAngle: .pi/8)
                        source.view.transform = rotation
                })
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.4,
                    animations: {
                        destination.view.transform = .identity
                })
            },
            completion: { finished in
                if finished && !transitionContext.transitionWasCancelled {
                    source.view.transform = .identity
                }
                transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            }
        )
    }
}
