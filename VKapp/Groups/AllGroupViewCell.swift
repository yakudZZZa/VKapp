//
//  AllGroupViewCell.swift
//  Weather
//
//  Created by Евгений Иванов on 10/11/2018.
//  Copyright © 2018 Евгений Иванов. All rights reserved.
//

import UIKit

class AllGroupViewCell: UITableViewCell {
    
    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
