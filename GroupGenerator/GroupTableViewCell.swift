//
//  GroupTableViewCell.swift
//  GroupGenerator
//
//  Created by Kayode Oguntimehin on 12/03/2017.
//  Copyright © 2017 Kayode Oguntimehin. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userIcon: UIImageView!
   
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var removeUserBut: UIButton!
      override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}
