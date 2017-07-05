//
//  RealtorCell.swift
//  Realtor Directory
//
//  Created by Lane Faison on 7/3/17.
//  Copyright © 2017 Lane Faison. All rights reserved.
//

import UIKit

class RealtorCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var thumbPortrait: RoundedOutlineImage!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
