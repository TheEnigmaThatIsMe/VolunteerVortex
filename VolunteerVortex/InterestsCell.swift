//
//  InterestsCell.swift
//  VolunteerVortex
//
//  Created by MU IT Program on 11/17/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class InterestsCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.text = "not loaded"
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
