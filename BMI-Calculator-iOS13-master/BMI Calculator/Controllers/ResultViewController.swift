//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Muhammed Burkay Şendoğdu on 4.09.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var bmiLabel: UILabel!
    @IBOutlet var adviceLabel: UILabel!
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmiLabel.text = bmiValue
        view.backgroundColor = color
        adviceLabel.text = advice
        
    }

    @IBAction func recalculateClicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

}
