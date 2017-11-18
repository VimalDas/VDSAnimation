//
//  ViewController.swift
//  DemoAnimation
//
//  Created by Vimal Das on 17/11/17.
//  Copyright © 2017 Vimal Das. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: VDSSwipeAnimation!

    @IBAction func resetAction(_ sender: UIButton) {
        cardView.reset()
    }
    
    
}

