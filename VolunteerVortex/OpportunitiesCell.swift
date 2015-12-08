//
//  OpportunitiesCell.swift
//  VolunteerVortex
//
//  Created by MU IT Program on 11/17/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class OpportunitiesCell: UITableViewCell {
    
    @IBOutlet weak var opportunityTitleLabel: UILabel!
    @IBOutlet weak var opportunityOrganizationLabel: UILabel!
    @IBOutlet weak var opportunityDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
