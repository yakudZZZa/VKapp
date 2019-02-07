//
//  FriendViewCell.swift
//  Weather
//
//  Created by Евгений Иванов on 10/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit
import Kingfisher

class FriendViewCell: UITableViewCell {

    @IBOutlet weak var avatar: Avatar!
    @IBOutlet weak var friend: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with friend: User) {
        self.friend.text = friend.name
        //        cell.avatar.image = friend.image
        self.avatar.kf.setImage(with: URL(string: friend.avatarStringURL))
    }

}
