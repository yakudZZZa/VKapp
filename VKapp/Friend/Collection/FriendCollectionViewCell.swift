//
//  FriendCollectionViewCell.swift
//  Weather
//
//  Created by Евгений Иванов on 10/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userPhoto: UIImageView!
    //    @IBOutlet var likeButton: UIButton!
//    @IBOutlet weak var avatar: Avatar!
//    @IBOutlet weak var shadowCollection: AvatarShadow!
//    @IBOutlet var likeCount: UILabel!
//
//    var liked = false
    
//    @IBAction func likePressed(_ sender: Any) {
//
//        var likeCountInt: Int = Int(likeCount.text!)!
//
//        guard liked == false else {
//            UIView.transition(with: likeButton,
//                              duration: 0.25,
//                              options: .transitionCrossDissolve,
//                              animations: {
//                                self.likeButton.setImage(UIImage(named: "grayHeart"), for: .normal)
//                                self.likeCount.textColor = UIColor.black
//                                likeCountInt -= 1
//                                self.likeCount.text = String(likeCountInt)
//            })
//            liked = false
//            return
//        }
//        let originalTransform = self.likeButton.transform
//        let scaledTransform = originalTransform.scaledBy(x: 1.2, y: 1.2)
//        UIView.animate(withDuration: 0.15,
//                       delay: 0,
//                       options: [.transitionCrossDissolve],
//                       animations: {
//                        self.likeButton.transform = scaledTransform
//                        self.likeButton.setImage(UIImage(named: "redHeart"), for: .normal)
//                        self.likeCount.textColor = UIColor.red
//                        likeCountInt += 1
//                        self.likeCount.text = String(likeCountInt)
//                        },
//                       completion: {_ in
//                        self.likeButton.transform = originalTransform
//        })
//        liked = true
//    }
    
}


