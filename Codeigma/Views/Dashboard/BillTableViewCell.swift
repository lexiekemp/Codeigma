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
    @IBOutlet weak var openButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        openButton.layer.cornerRadius = 30.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func inflate(bill: Bill) {
        
    }

}
