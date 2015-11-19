//
//  OrganizationCell.swift
//  VolunteerVortex
//
//  Created by MU IT Program on 11/17/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class OrganizationCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var about: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        title.text = "not loaded"
        about.text = "not loaded"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
