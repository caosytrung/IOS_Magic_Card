//
//  CardData.swift
//  MagicCard
//
//  Created by Cao Sy Trung on 6/29/19.
//  Copyright © 2019 Cao Sy Trung. All rights reserved.
//

import UIKit

class CardData {
    var cardImage: UIImage?
    var cardNumber: Int?
    var cardState:CardState = CardState.hidden
    var index: Int?
    
    init(cardNumber: Int) {
        self.cardNumber = cardNumber 
        cardImage = UIImage(named: "card_0\(self.cardNumber!)")
    }
}
