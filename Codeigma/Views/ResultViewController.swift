//
//  ResultViewController.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var recropButton: UIButton!
    @IBOutlet weak var nextStepButton: UIButton!
    
    var bill: Bill?
    
    @IBAction func nextStepClicked(_ sender: UIButton) {
    }
    @IBAction func recropClicked(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nextStepButton.layer.cornerRadius = 30.0
        recropButton.layer.cornerRadius = 30.0
        if bill != nil {
            titleLabel.text = "Great News!"
            detailsLabel.text = "We've found your codes!"
            nextStepButton.setTitle("See Codes", for: .normal)
        }
        else {
            titleLabel.text = "Oops!"
            detailsLabel.text = "We weren't able to identify your codes!"
            instructionsLabel.isHidden = false
            recropButton.isHidden = false
            nextStepButton.setTitle("Retake Photo", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
