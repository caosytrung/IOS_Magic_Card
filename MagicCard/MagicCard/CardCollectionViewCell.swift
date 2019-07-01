//
//  CardCollectionViewCell.swift
//  MagicCard
//
//  Created by Cao Sy Trung on 6/28/19.
//  Copyright © 2019 Cao Sy Trung. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivCard: UIImageView!
    @IBOutlet weak var containerView: UIView!
    var cardData: CardData?
   
//    var cardData: CardData?{
//        didSet{
//            initDisplayImage()
//        }
//    }
//
    var closureCallBack: ((CardData) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        containerView.backgroundColor = UIColor(white: 1, alpha: 0.01)
        containerView.alpha = 1 
        containerView.isUserInteractionEnabled = true
        containerView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func reload(){
        guard let cardData = self.cardData else {
            return
        }
        
        switch cardData.cardState {
        case .hidden:
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.ivCard.image = UIImage(named: "hidden_card")
                UIView.transition(with: self.ivCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
        case.opened:
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.ivCard.image = self.cardData!.cardImage
                UIView.transition(with: self.ivCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            }
        default:
            UIView.animate(withDuration: 0.4) {
                self.ivCard.alpha = 0
            }
        }
    
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        guard let cardData = cardData, let displayImage = self.ivCard else {
            return
        }
        switch cardData.cardState {
        case .hidden:
//
//            UIView.transition(from: hiddenImage, to: displayImage, duration: 0.5, options: .transitionFlipFromRight, completion: nil)
            
            displayImage.image = cardData.cardImage!
        
//            UIView.transition(with: ivCard, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
            UIView.transition(with: ivCard, duration: 0.3, options: .transitionFlipFromRight, animations: nil) {Bool in
                cardData.cardState = CardState.opened
                guard let closureCallBack = self.closureCallBack else {
                    return
                }
                closureCallBack(cardData)
            }
//            cardData.cardState = CardState.opened
//            guard let closureCallBack = closureCallBack else {
//                return
//            }
//            closureCallBack(cardData)
        case .opened:
            return
        default:
            return
        }
    }
    
    func reset() {
        ivCard.alpha = 1
        containerView.isHidden = false
        ivCard.image = UIImage(named: "hidden_card")
    }
}

enum CardState{
    case hidden
    case opened
    case removed
}
