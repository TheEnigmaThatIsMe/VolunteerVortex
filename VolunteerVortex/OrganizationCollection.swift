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
    var tasks: [Task] = Array<Task>()
    
    func readJSON() {
        if let path = NSBundle.mainBundle().pathForResource("organization", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let json = JSON(data: data)
                if json != JSON.null {
                    for organization in json["organizations"].arrayValue {
                        
                        print("Loading an Organization: ...")
                        if let organizationName = organization["name"].string, organizationEmail = organization["email"].string, organizationPhone = organization["phone"].string, organizationAddress = organization["address"].string, organizationCity = organization["city"].string, organizationState = organization["state"].string, organizationCategories = organization["categories"].string, organizationDescription = organization["description"].string {
                            
                            let organizationID = organization["id"].intValue
                            var eventList: [Event] = Array<Event>()
                            
                            for event in organization["events"].arrayValue {
                                
                                if let eventName = event["eventName"].string, eventAddress = event["address"].string, eventCity = event["city"].string, eventState = event["state"].string, eventStartTime = event["startTime"].string, eventEndTime = event["endTime"].string, eventCategories = event["categories"].string, eventDescription = event["description"].string, eventTasks = event["task"].array {
                                    
                                    let eventVolunteerLimit = event["volunteerLimit"].intValue, eventID = event["id"].intValue
                                    let registered = false
                                    
                                    var taskList: [Task] = Array<Task>()
                                    print("Loading Tasks: ...")
                                    for task in eventTasks{
                                        
                                        let newTask = Task(taskName: task["name"].string!, taskTime: task["startTime"].string!, taskDescription: task["description"].string!, taskID: task["id"].int!)
                                        taskList.append(newTask)
                                    }
                                    
                                    self.tasks.appendContentsOf(taskList)
                                    
                                    eventList.append(Event(organizationName: organizationName, organizationID: organizationID, eventName: eventName, eventAddress: eventAddress, eventCity: eventCity, eventState: eventState, eventStartTime: eventStartTime, eventEndTime: eventEndTime, eventCategories: eventCategories, eventDescription: eventDescription, eventVolunteerLimit: eventVolunteerLimit, eventID: eventID, eventTasks: taskList, registered: registered))
                                }
                            }
                            self.events.appendContentsOf(eventList)
                            
                            self.organizations.append(Organization(organizationName: organizationName, organizationEmail: organizationEmail, organizationPhone: organizationPhone, organizationAddress: organizationAddress, organizationCity: organizationCity,
                                organizationState: organizationState,organizationCategories: organizationCategories,organizationDescription: organizationDescription, organizationID: organizationID,organizationInterest: organization["interest"].string!,organizationEvents: eventList))
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
}