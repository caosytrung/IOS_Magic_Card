//
//  ViewController.swift
//  MagicCard
//
//  Created by Cao Sy Trung on 6/28/19.
//  Copyright © 2019 Cao Sy Trung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func playGame(_ sender: UIButton) {
        let myStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainController = myStoryBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.navigationController?.pushViewController(mainController, animated: true)
    }
}

