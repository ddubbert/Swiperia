//
//  SingleItemCell.swift
//  Swiperia
//
//  Created by Dennis Dubbert on 03.10.17.
//  Copyright © 2017 Dennis Dubbert. All rights reserved.
//

import UIKit

class SingleItemCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
