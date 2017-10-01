//
//  MultiPlayerCellController.swift
//  Swiperia
//
//  Created by Edgar Gellert on 30.08.17.
//  Copyright © 2017 Dedy Gubbert. All rights reserved.
//

import UIKit

class MultiPlayerCellController: UITableViewCell {
    
    @IBOutlet weak var opponentName: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var opponentPoints: UILabel!
    @IBOutlet weak var pointSeperator: UILabel!
    @IBOutlet weak var myPoints: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    let separator = UIView(frame: CGRect.zero)
    
    func configure(viewModel: CollapseableViewModel) {
        let textFont = UIFont(name: "HelveticaNeue-bold", size: 20)
        
        gameImage.image = viewModel.image
        if viewModel.needsSeperator {
            opponentName.text = ""
            opponentPoints.text = ""
            myPoints.text = ""
            pointSeperator.text = ""
            
            cellLabel.text = viewModel.label
            cellLabel.font = textFont
            
            separator.backgroundColor = UIColor.white
            contentView.addSubview(separator)
        } else {
            cellLabel.text = ""
            
            opponentName.text = viewModel.label
            opponentName.font = textFont
            
            opponentPoints.text = String(viewModel.opponentPoints!)
            opponentPoints.font = textFont
            opponentPoints.textColor = UIColor.red
            
            myPoints.text = String(viewModel.myPoints!)
            myPoints.font = textFont
            myPoints.textColor = UIColor.green
            
            pointSeperator.text = "x"
            pointSeperator.font = textFont
            
            separator.removeFromSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let separatorHeight = 1 / UIScreen.main.scale
        separator.frame = CGRect(x: Double(separatorInset.left), y: Double(contentView.bounds.height - separatorHeight), width: Double(contentView.bounds.width - separatorInset.left - separatorInset.right), height: Double(separatorHeight))
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
