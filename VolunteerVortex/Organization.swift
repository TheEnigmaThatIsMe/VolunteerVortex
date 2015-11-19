//
//  Organization.swift
//  VolunteerVortex
//
//  Created by Xuan Liu on 11/19/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import Foundation

class Organization{
    var organizationName: String = ""
    var description: String = ""
    
    init(organizationName: String, description: String) {
        self.organizationName = organizationName
        self.description = description
    }
}