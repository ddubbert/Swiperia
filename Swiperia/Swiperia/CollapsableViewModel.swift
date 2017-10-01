//
//  CollapsableViewModel.swift
//  Swiperia
//
//  Created by Edgar Gellert on 14.09.17.
//  Copyright © 2017 Dennis Dubbert. All rights reserved.
//

import Foundation

class CollapseableViewModel {
    let label : String
    let image : UIImage?
    let children : [CollapseableViewModel]
    var isCollapsed : Bool
    var needsSeperator : Bool = true
    let opponentPoints : Int?
    let myPoints : Int?
    
    init(label : String, image : UIImage? = nil, children : [CollapseableViewModel] = [], isCollapsed : Bool = true, opponentPoints: Int? = nil, myPoints: Int? = nil) {
        self.label = label
        self.image = image
        self.children = children
        self.isCollapsed = isCollapsed
        self.opponentPoints = opponentPoints
        self.myPoints = myPoints
        
        for child in self.children {
            child.needsSeperator = false
        }
        self.children.last?.needsSeperator = true
    }
}
