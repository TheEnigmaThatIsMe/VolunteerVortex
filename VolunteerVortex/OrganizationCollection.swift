//
//  OrganizationCollection.swift
//  VolunteerVortex
//
//  Created by Xuan Liu on 11/19/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import Foundation

class OrganizationCollection{
    
    static let sharedInstance = OrganizationCollection()
    var organizations:[Organization] = Array<Organization>()
    var events: [Event] = Array<Event>()
    //var tasks: [Task] = Array<Task>()
    
    func readJSON() {
        if let path = NSBundle.mainBundle().pathForResource("organization", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let json = JSON(data: data)
                if json != JSON.null {
                    for organization in json["organizations"].arrayValue {
                        if let organizationName = organization["name"].string, organizationEmail = organization["email"].string, organizationPhone = organization["phone"].string, organizationAddress = organization["address"].string, organizationCity = organization["city"].string, organizationState = organization["state"].string, organizationCategories = organization["categories"].string, organizationDescription = organization["description"].string {
                            let organizationID = organization["id"].intValue
                            self.organizations.append(Organization(organizationName: organizationName, organizationEmail: organizationEmail, organizationPhone: organizationPhone, organizationAddress: organizationAddress, organizationCity: organizationCity,
                                organizationState: organizationState,organizationCategories: organizationCategories,organizationDescription: organizationDescription, organizationID: organizationID))
                        }
                        print("Organization Name: \(organization["name"].string!)")
                        print("Organization Email: \(organization["email"].string!)")
                        print("Organization Phone: \(organization["phone"].string!)")
                        print("Organization Address: \(organization["address"].string!)")
                        print("Organization City: \(organization["city"].string!)")
                        print("Organization State: \(organization["state"].string!)")
                        print("Organization Category: \(organization["categories"].string!)")
                        print("Organization Description: \(organization["description"].string!)")
                        print("Organization ID: \(organization["id"].intValue)")
                        
                        for event in organization["events"].arrayValue {
                            if let eventName = event["eventName"].string, eventAddress = event["address"].string, eventCity = event["city"].string, eventState = event["state"].string, eventStartTime = event["startTime"].string, eventEndTime = event["endTime"].string, eventCategories = event["categories"].string, eventDescription = event["description"].string {
                                let eventVolunteerLimit = event["volunteerLimit"].intValue, eventID = event["id"].intValue
                                self.events.append(Event(eventName: eventName, eventAddress: eventAddress, eventCity: eventCity, eventState: eventState, eventStartTime: eventStartTime, eventEndTime: eventEndTime, eventCategories: eventCategories, eventDescription: eventDescription, eventVolunteerLimit: eventVolunteerLimit, eventID: eventID))
                            }
                            
                            print("Event Name: \(event["eventName"].string!)")
                            print("Event Address: \(event["address"].string!)")
                            print("Event City: \(event["city"].string!)")
                            print("Event State: \(event["state"].string!)")
                            print("Event Start Time: \(event["startTime"].string!)")
                            print("Event End Time: \(event["endTime"].string!)")
                            print("Event Category: \(event["categories"].string!)")
                            print("Event Description: \(event["description"].string!)")
                            print("Event Volunteer Limit: \(event["volunteerLimit"].intValue)")
                            print("Event ID: \(event["id"].intValue)")
                            
                            for task in event["task"].arrayValue {
                                print("Task Name: \(task["name"].string!)")
                                print("Task Description: \(task["description"].string!)")
                                print("Task Start Time: \(task["startTime"].string!)")
                                print("Task ID: \(task["id"].stringValue)")
                            }
                        }
                    }
                }
                else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        else {
            print("Invalid filename/path.")
        }
    }
    
    /*private init(fileName:String) {
        loadFromJSONFile(fileName)
    }
    
    var organizations:[Organization] = Array<Organization>()
    
    private func loadFromJSONFile(fileName: String) {
        let bundle = NSBundle.mainBundle()
        if let path = bundle.pathForResource(fileName, ofType: "json"), jsonData = NSData(contentsOfFile: path) {
            parseJson(jsonData)
        }
    }*/
    
    /*private func parseJson(jsonData: NSData) {
        organizations = Array<Organization>()
        var jsonResultWrapped: NSDictionary?
        do {
            jsonResultWrapped = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
        } catch {
            return
        }
        
        if let jsonResult = jsonResultWrapped where jsonResult.count > 0 {
            if let status = jsonResult["status"] as? String where status == "ok" {
                if let organizationList = jsonResult["organizations"] as? NSArray {
                    for organization in organizationList{
                        if let organizationName = organization["name"] as? String,
                            organizationCategories = organization["categories"] as? String, organizationEmail = organization["email"] as? String, organizationPhone = organization["phone"] as? String, organizationAddress = organization["address"] as? String, organizationCity = organization["city"] as? String, organizationState = organization["state"] as? String, events = organization["events"] as? Array<String>, organizationDescription = organization["description"] as? String, organizationID = organization["id"] as? Int {
                                self.organizations.append(Organization(organizationName: organizationName,   organizationEmail: organizationEmail, organizationPhone: organizationPhone, organizationAddress: organizationAddress, organizationCity: organizationCity,
                                    organizationState: organizationState,organizationCategories: organizationCategories,events: events, organizationDescription: organizationDescription, organizationID: organizationID))
                        }
                    }
                }
            }
        }
    }*/

}