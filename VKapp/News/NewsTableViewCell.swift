//
//  NewsTableViewCell.swift
//  Weather
//
//  Created by Евгений Иванов on 25/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    var isLiked = false
    

    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet var newsPic: UIImageView!
    @IBOutlet var likeButton: LikeFavorite!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var commentCount: UILabel!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var shareCount: UILabel!
    @IBOutlet var viewsCount: UILabel!
    
    @IBAction func likePressed(_ sender: UIButton) {
        
        var likeCountInt: Int = Int(likeCount.text!)!
        
        
        guard isLiked == false else {
            
            UIView.transition(with: likeButton,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: {
                self.likeButton.setImage(UIImage(named: "grayHeart"), for: .normal)
                self.likeCount.textColor = UIColor.black
                likeCountInt -= 1
                self.likeCount.text = String(likeCountInt)
            })
            isLiked = false
            return
        }
        let originalTransform = self.likeButton.transform
        let scaledTransform = originalTransform.scaledBy(x: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: [.transitionCrossDissolve],
                       animations: {
                        self.likeButton.transform = scaledTransform
                        self.likeButton.setImage(UIImage(named: "redHeart"), for: .normal)
                        self.likeCount.textColor = UIColor.red
                        likeCountInt += 1
                        self.likeCount.text = String(likeCountInt)
        },
                       completion: {_ in
                        self.likeButton.transform = originalTransform
        })
        isLiked = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(tapSpring))
        tap.minimumPressDuration = 0.2
        self.newsPic.addGestureRecognizer(tap)
//        let NonScaledPic = self.newsPic.transform
//        let scaledPic = NonScaledPic.scaledBy(x: 0.9, y: 0.9)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func tapSpring(gesture: UITapGestureRecognizer) {
        
        // handle touch down and touch up events separately
//        let tempSize = newsPic.transform
//        let scaledSize = tempSize.scaledBy(x: 0.9, y: 0.9)
        if gesture.state == .began {
            tappedPic()
//            UIView.animate(withDuration: 0.2,
//                           delay: 0,
//                           options: [],
//                           animations: {
//                            self.newsPic.transform = scaledSize
//                            print("тап нажат")
//            })
        } else if gesture.state == .ended {
            untappedPic()
//            UIView.animate(withDuration: 0.5,
//                           delay: 0,
//                           usingSpringWithDamping: 0.5,
//                           initialSpringVelocity: 0,
//                           options: [],
//                           animations: {
//                            self.newsPic.transform = .identity
//                            print("тап отпущен")
//            })
        }
    }
    
    func tappedPic() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.9
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 0.2
        animation.beginTime = 0
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false

        self.newsPic.layer.add(animation, forKey: nil)
    }
//
    func untappedPic() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 0.5
        animation.beginTime = 0
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.autoreverses = false
        animation.isRemovedOnCompletion = false

        self.newsPic.layer.add(animation, forKey: nil)
    }
    

}
