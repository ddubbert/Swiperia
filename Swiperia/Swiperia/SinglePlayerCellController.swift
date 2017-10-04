//
//  SinglePlayerCellController.swift
//  Swiperia
//
//  Created by Edgar Gellert on 30.08.17.
//  Copyright © 2017 Dedy Gubbert. All rights reserved.
//

import UIKit

class SinglePlayerCellController: UITableViewCell {
    
    // GameImageView in Cell
    @IBOutlet weak var gameImageView: UIImageView!
    // gameNameLabel in Cell
    @IBOutlet weak var gameNameLabel: UILabel!
    // gameScoreLabel in Cell
    @IBOutlet weak var gameScoreLabel: UILabel!

    let separator = UIView(frame: CGRect.zero)
    
    func configure(withSeperator: Bool) {
        separator.backgroundColor = UIColor.white
        contentView.addSubview(separator)
    }
    
    override func layoutSubviews() {
        let separatorHeight = 1 / UIScreen.main.scale
        separator.frame = CGRect(x: Double(separatorInset.left), y: Double(bounds.height - separatorHeight), width: Double(bounds.width - separatorInset.left - separatorInset.right), height: Double(separatorHeight))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
