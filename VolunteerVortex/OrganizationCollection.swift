//
//  OrganizationCollection.swift
//  VolunteerVortex
//
//  Created by Xuan Liu on 11/19/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import Foundation

class OrganizationCollection{
    static let sharedInstance = OrganizationCollection(fileName: "organization")
    
    private init(fileName:String) {
        loadFromJSONFile(fileName)
    }
    
    var organizations:[Organization] = Array<Organization>()
    
    private func loadFromJSONFile(fileName: String) {
        let bundle = NSBundle.mainBundle()
        if let path = bundle.pathForResource(fileName, ofType: "json"), jsonData = NSData(contentsOfFile: path) {
            parseJson(jsonData)
        }
    }
    
    private func parseJson(jsonData: NSData) {
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
                            description = organization["categories"] as? String{
                                
                                self.organizations.append(Organization(organizationName: organizationName,  description: description))
                        }
                    }
                }
            }
        }
    }

}