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
        let textFont2 = UIFont(name: "HelveticaNeue-bold", size: 30)
        contentView.addSubview(separator)
        gameImage.image = viewModel.image
        if  viewModel.myPoints == nil && viewModel.opponentPoints == nil {
            contentView.backgroundColor = UIColor.init(red: 99/255, green: 100/255, blue: 100/255, alpha: 1)
            backgroundColor = UIColor.init(red: 99/255, green: 100/255, blue: 100/255, alpha: 1)
            isUserInteractionEnabled = true
            opponentName.text = ""
            opponentPoints.text = ""
            myPoints.text = ""
            pointSeperator.text = ""
            
            cellLabel.text = viewModel.label
            cellLabel.font = textFont
            
            separator.backgroundColor = UIColor.white
            contentView.addSubview(separator)
        } else {
            isUserInteractionEnabled = false
            contentView.backgroundColor = UIColor.init(red: 199/255, green: 199/255, blue: 204/255, alpha: 1)
            backgroundColor = UIColor.init(red: 199/255, green: 199/255, blue: 204/255, alpha: 1)
            
            cellLabel.text = ""
            
            opponentName.text = viewModel.label
            opponentName.font = textFont
            opponentName.textColor = UIColor.init(red: 99/255, green: 100/255, blue: 100/255, alpha: 1)
            
            opponentPoints.text = String((viewModel.opponentPoints != nil) ? viewModel.opponentPoints! : 0)
            opponentPoints.font = textFont2
            opponentPoints.textColor = UIColor.red
            
            myPoints.text = String((viewModel.myPoints != nil) ? viewModel.myPoints! : 0)
            myPoints.font = textFont2
            myPoints.textColor = UIColor.green
            
            pointSeperator.text = "x"
            pointSeperator.font = textFont
            pointSeperator.textColor = UIColor.init(red: 99/255, green: 100/255, blue: 100/255, alpha: 1)
            
            if !viewModel.needsSeperator {
                separator.backgroundColor = UIColor.init(red: 99/255, green: 100/255, blue: 100/255, alpha: 1)
            } else {
                separator.backgroundColor = UIColor.white
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
