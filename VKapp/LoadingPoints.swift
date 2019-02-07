//
//  LoadingPoints.swift
//  Weather
//
//  Created by Евгений Иванов on 29/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

class LoadingPoints: UIView {
    let firstPoint = CAShapeLayer()
    let secondPoint = CAShapeLayer()
    let thridPoint = CAShapeLayer()
    let fadeInAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
//        self.alpha = 0
        firstPoint.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        secondPoint.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        thridPoint.path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        firstPoint.fillColor = nil
        secondPoint.fillColor = nil
        thridPoint.fillColor = nil
        firstPoint.backgroundColor = UIColor.blue.withAlphaComponent(1).cgColor
        secondPoint.backgroundColor = UIColor.blue.withAlphaComponent(1).cgColor
        thridPoint.backgroundColor = UIColor.blue.withAlphaComponent(1).cgColor
        firstPoint.frame = CGRect(x: self.frame.size.width/2 - 25, y: self.frame.size.height/2 - 5, width: 10, height: 10)
        secondPoint.frame = CGRect(x: self.frame.size.width/2 - 5, y: self.frame.size.height/2 - 5, width: 10, height: 10)
        thridPoint.frame = CGRect(x: self.frame.size.width/2 + 15, y: self.frame.size.height/2 - 5, width: 10, height: 10)
        firstPoint.masksToBounds = true
        secondPoint.masksToBounds = true
        thridPoint.masksToBounds = true
        firstPoint.cornerRadius = 5
        secondPoint.cornerRadius = 5
        thridPoint.cornerRadius = 5
        self.layer.addSublayer(firstPoint)
        self.layer.addSublayer(secondPoint)
        self.layer.addSublayer(thridPoint)
        fadeInAnimation.fromValue = 1
        fadeInAnimation.toValue = 0
        fadeInAnimation.duration = 0.75
        fadeInAnimation.repeatCount = Float.infinity
        fadeInAnimation.autoreverses = true
        fadeInAnimation.beginTime = CACurrentMediaTime()
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        animate()
    }
    func animate() {
        self.alpha = 0.5
        firstPoint.add(fadeInAnimation, forKey: nil)
        fadeInAnimation.beginTime = CACurrentMediaTime() + 0.5
        secondPoint.add(fadeInAnimation, forKey: nil)
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        thridPoint.add(fadeInAnimation, forKey: nil)
    }
}
