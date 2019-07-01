//
//  MainViewController.swift
//  MagicCard
//
//  Created by Cao Sy Trung on 6/28/19.
//  Copyright © 2019 Cao Sy Trung. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    let NO_COLUMS:Int  = 4
    let NO_ROWS:Int = 4
    let PADDING:CGFloat = 8
    var cardList = [CardData]()
    var cellList = [CardCollectionViewCell]()
    var firstData: Int = -1
    var remainingTime = 30
    var timer = Timer()
    var remainingCards:Int = 16
    
    @IBOutlet weak var lbRemainingTime: UILabel!
    @IBOutlet weak var clCard: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        clCard.delegate = self
        clCard.dataSource = self
        clCard.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        cardList.append(CardData(cardNumber: 1))
        cardList.append(CardData(cardNumber: 4))
        cardList.append(CardData(cardNumber: 1))
        cardList.append(CardData(cardNumber: 7))
        cardList.append(CardData(cardNumber: 8))
        cardList.append(CardData(cardNumber: 3))
        cardList.append(CardData(cardNumber: 2))
        cardList.append(CardData(cardNumber: 5))
        //
        cardList.append(CardData(cardNumber: 4))
        cardList.append(CardData(cardNumber: 6))
        cardList.append(CardData(cardNumber: 7))
        cardList.append(CardData(cardNumber: 8))
        cardList.append(CardData(cardNumber: 5))
        cardList.append(CardData(cardNumber: 3))
        cardList.append(CardData(cardNumber: 2))
        cardList.append(CardData(cardNumber: 6))
        
        for index in 0..<cardList.count{
            cardList[index].index = index;
        }
        initTimer()
    }
    
    func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MainViewController.updateTimer)), userInfo: nil, repeats: true )
    }

    @objc func updateTimer()  {
        remainingTime -= 1
        lbRemainingTime.text = "Remaining Time: \(remainingTime)"
        if remainingTime == 0 {
            timer.invalidate()
            showAlert(isWin: false)
        }
    }
    
    func showAlert(isWin: Bool){
        let title = isWin ? "Congratulation" : "Game over"
        let message = isWin ? "You Won" : "You're fucking Idiot!"
        let alerController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alerController.addAction(isWin ? getBackAction() : getReloadAcion())
        self.present(alerController,animated: true,completion: nil)
    }
    
    func getBackAction() -> UIAlertAction {
        return UIAlertAction(title: "Okey Bro! Exit Game!", style: .default, handler: { (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func getReloadAcion() -> UIAlertAction {
        return UIAlertAction(title: "Ok! I'm Fine! Reload", style: .default, handler: { (UIAlertAction) in
            self.reloadGame()
        })
    }
    
    func reloadGame() {
        for item in cardList{
            item.cardState = .hidden
        }

        for cell in cellList{
            cell.reset()
        }
        
        firstData = -1
        remainingCards = 16
        remainingTime = 30
        lbRemainingTime.text = "Remaining Time: 30"
        initTimer()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NO_ROWS * NO_COLUMS
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = clCard.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
        cell.closureCallBack = {cardData in
            guard self.firstData >= 0 else {
                self.firstData = cardData.index!
                return
            }
            
            if self.cardList[self.firstData].cardNumber == cardData.cardNumber{
                self.cardList[self.firstData].cardState = .removed
                cardData.cardState = .removed
                self.remainingCards -= 2
            
            } else{
                self.cardList[self.firstData].cardState = .hidden
                cardData.cardState = .hidden
            }
            
            self.cellList[cardData.index!].reload()
            self.cellList[self.firstData].reload()
            self.firstData = -1
            if self.remainingCards == 0{
                self.showAlert(isWin: true)
            }
            
            
        }
        
        cell.cardData = cardList[indexPath.row]
        cellList.append(cell)
       // cell.mainCard = UIImage(named: "card_0\(RANDOM_ARRAY.index(indexPath.row, offsetBy: <#T##Int#>))")
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (self.clCard.frame.width - PADDING * CGFloat(NO_COLUMS) * 2) / 4
        return CGSize(width: cellWidth, height: cellWidth * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: PADDING, left: PADDING, bottom: PADDING, right: PADDING)
    }
}
