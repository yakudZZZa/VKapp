//
//  Avatar.swift
//  Weather
//
//  Created by Евгений Иванов on 15/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

class Avatar: UIImageView {
    
    @IBInspectable var shadowOpacity: Float = 1 {
        
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
        
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
        
}
    
@IBDesignable class AvatarShadow: UIView {
    
    @IBInspectable var shadowOpacity: Float = 1 {
        
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 10 {
        
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize.zero
    }
}
