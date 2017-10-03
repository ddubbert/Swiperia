//
//  MultiplayerGameData.swift
//  Swiperia
//
//  Created by Dennis Dubbert on 02.10.17.
//  Copyright © 2017 Dennis Dubbert. All rights reserved.
//

import Foundation

struct MultiPlayerGameData {
    var image : String
    var opponents : [OpponentData] = []
    
    init(image: String, opponents : [OpponentData] = []) {
        self.image = image
        self.opponents = opponents
    }
    
    mutating func addOpponent(name: String, myPoints: Int, opponentPoints: Int, image: UIImage) {
        let op = opponents.filter({$0.name == name})
        if (op.count > 0) {
            opponents = opponents.map{
                if $0.name == name {
                    return OpponentData(name: name, myPoints: $0.myPoints + myPoints, opponentPoints: $0.opponentPoints + opponentPoints, image: image)
                } else {return $0}
            }
        } else {
            if opponents.count >= 10 {
                var lowestIndex : Int?
                var lowestValue : Int = 0
                opponents.enumerated().forEach{(index, element) in
                    if (element.myPoints + element.opponentPoints) > lowestValue {
                        lowestValue = element.myPoints + element.opponentPoints
                        lowestIndex = index
                    }
                }
                
                if let index = lowestIndex {
                    opponents.remove(at: index)
                }
                
                opponents.append(OpponentData(name: name, myPoints: myPoints, opponentPoints: opponentPoints, image: image))
            }
        }
    }
}

struct OpponentData {
    var name : String
    var myPoints : Int
    var opponentPoints : Int
    var image : UIImage
}
