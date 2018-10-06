//
//  BillTableViewCell.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit
import CoreData

class BillTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalCodesLabel: UILabel!
    @IBOutlet weak var correctCodesLabel: UILabel!
    @IBOutlet weak var incorrectCodesLabel: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    @IBOutlet weak var openButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        openButton.layer.cornerRadius = openButton.frame.height/2
        cellBackgroundView.layer.cornerRadius = 10.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func inflate(bill: Bill) {
        if bill.date != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            let creationDate = bill.date! as Date
            titleLabel.text = "Bill - \(dateFormatter.string(from: creationDate))"
        }
        else {
            titleLabel.text = "Bill"
        }
        totalCodesLabel.text = "0"
        correctCodesLabel.text = "0"
        incorrectCodesLabel.text = "0"
        if bill.codes != nil, bill.codes!.count > 0 {
            if let codes = bill.codes!.allObjects as? [Code] {
                totalCodesLabel.text = String(codes.count)
                var correctCount = 0
                var incorrectCount = 0
                for code in codes {
                    if code.evaluation == Eval.correct.rawValue {
                        correctCount += 1
                    }
                    else if code.evaluation == Eval.incorrect.rawValue {
                        incorrectCount += 1
                    }
                }
                correctCodesLabel.text = String(correctCount)
                incorrectCodesLabel.text = String(incorrectCount)
            }
        }
    }

}
