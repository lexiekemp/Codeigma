//
//  CodeTableViewCell.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit
import CoreData

class CodeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var incorrectButton: UIButton!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    var code: Code?
    
    @IBAction func correctButtonClicked(_ sender: UIButton) {
        correctButton.isEnabled = false
        correctButton.setImage(UIImage(named: "checkmark-gray"), for: .normal)
        incorrectButton.isEnabled = true
        incorrectButton.setImage(UIImage(named: "cross-red"), for: .normal)
        if code != nil {
            Code.updateEval(code: code!, eval: Eval.correct.rawValue)
        }
    }
    @IBAction func incorrectButtonClicked(_ sender: UIButton) {
        correctButton.isEnabled = true
        correctButton.setImage(UIImage(named: "checkmark-green"), for: .normal)
        incorrectButton.isEnabled = false
        incorrectButton.setImage(UIImage(named: "cross-gray"), for: .normal)
        if code != nil {
            Code.updateEval(code: code!, eval: Eval.incorrect.rawValue)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.layer.cornerRadius = 10.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func inflate(code: Code) {
        self.code = code
        titleLabel.text = code.title
        detailLabel.text = code.detail
        switch code.evaluation {
        case Eval.correct.rawValue:
            correctButton.isEnabled = false
            incorrectButton.isEnabled = true
        case Eval.incorrect.rawValue:
            correctButton.isEnabled = true
            incorrectButton.isEnabled = false
        default:
            correctButton.isEnabled = true
            incorrectButton.isEnabled = true
        }
    }
}
