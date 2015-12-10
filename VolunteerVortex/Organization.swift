//
//  Organization.swift
//  VolunteerVortex
//
//  Created by Xuan Liu on 11/19/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import Foundation

class Organization {
    var organizationName: String? = ""
    var organizationEmail: String? = ""
    var organizationPhone: String? = ""
    var organizationAddress: String? = ""
    var organizationCity: String? = ""
    var organizationState: String? = ""
    var organizationCategories: String? = ""
    var organizationDescription: String? = ""
    var organizationID: Int = 0
    var organizationInterest: String? = ""
    
    init(organizationName: String, organizationEmail:String, organizationPhone: String, organizationAddress: String, organizationCity: String, organizationState: String,organizationCategories: String, organizationDescription: String, organizationID: Int, organizationInterest: String) {
        self.organizationName = organizationName
        self.organizationEmail = organizationEmail
        self.organizationPhone = organizationPhone
        self.organizationAddress = organizationAddress
        self.organizationCity = organizationCity
        self.organizationState = organizationState
        self.organizationCategories = organizationCategories
        self.organizationDescription = organizationDescription
        self.organizationID = organizationID
        self.organizationInterest = organizationInterest
    }
}