//
//  Event.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 11/27/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import Foundation

class Event {
    var organizationName: String? = ""
    var eventName: String? = ""
    var eventAddress: String? = ""
    var eventCity: String? = ""
    var eventState: String? = ""
    var eventStartTime: String? = ""
    var eventEndTime: String? = ""
    var eventCategories: String? = ""
    var eventDescription: String? = ""
    var eventVolunteerLimit: Int = 0
    var eventID: Int = 0
    
    init(organizationName: String, eventName: String, eventAddress: String, eventCity: String, eventState: String, eventStartTime: String, eventEndTime: String, eventCategories: String, eventDescription: String, eventVolunteerLimit:Int, eventID: Int) {
        self.organizationName = organizationName
        self.eventName = eventName
        self.eventAddress = eventAddress
        self.eventCity = eventCity
        self.eventState = eventState
        self.eventStartTime = eventStartTime
        self.eventEndTime = eventEndTime
        self.eventCategories = eventCategories
        self.eventDescription = eventDescription
        self.eventVolunteerLimit = eventVolunteerLimit
        self.eventID = eventID
    }
}