//
//  ContactPreferenceCell.swift
//  VolunteerVortex
//
//  Created by Xuan Liu on 12/13/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class ContactPreferenceCell: UITableViewCell {
    
    @IBOutlet weak var contactType: UILabel!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    var contactTypeList = ["Email", "Phone Call", "Text Message"]
    
    @IBAction func switchButton(sender: AnyObject) {
        let switchRow = sender.tag
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
