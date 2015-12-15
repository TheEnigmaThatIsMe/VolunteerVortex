//
//  VolunteerViewController.swift
//  VolunteerVortex
//
//  Created by Joseph Trammel on 11/7/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class VolunteerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let organizationCollection = OrganizationCollection.sharedInstance //get data from OrganizationCollection.swift
    var filteredOrganizations: [Organization]!
    var filteredEvents: [Event]!
    var filteredTasks: [Task]!
    var valueToPass: Int = 0
    var organizationID: Int = 0
    var eventID: Int = 0
    //need to get data that has been loaded or load data from json to use
    
    @IBOutlet weak var volunteerTitleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    @IBAction func opportunitiesSegmentedControl(sender: UISegmentedControl) {
        
        //Load info to put in table View
        //print(sender.selectedSegmentIndex)
        //This should refresh the table view
        table.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Volunteer"
        
        table.delegate = self
        table.dataSource = self
        organizationCollection.readJSON()
        filteredOrganizations = organizationCollection.organizations
        filteredEvents = organizationCollection.events
        filteredTasks = organizationCollection.tasks
    }
    
    /*
    The following functions are necessary for using the table views
*/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("number of rows")
        switch (segmentedControl.selectedSegmentIndex)
        {
        case 0:
            return filteredOrganizations.count
        case 1:
            return filteredEvents.count // count of items in table, must have data to know
        case 2:
            return filteredOrganizations.count // count of items in table, must have data to know
        default:
            return 20
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height : CGFloat
        
        switch (segmentedControl.selectedSegmentIndex)
        {
        case 0:
            height = 70
        case 1:
            height = 70
        case 2:
            height = 70
        default:
            height = 100
        }
        
        return height
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print("cellForRowAtIndexPath")
        //decide which table to build
        
        var cell : UITableViewCell!;
        
        switch (segmentedControl.selectedSegmentIndex)
        {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("organizations")
            let orgCell = cell as! OrganizationCell
            //print(filteredOrganizations.count)
            
            let organization = filteredOrganizations[indexPath.row]
            orgCell.organizationTitleLabel.text = organization.organizationName
            orgCell.organizationCategoryLabel.text = organization.organizationCategories
            
            orgCell.accessoryType = .DisclosureIndicator
            
            //Reasigning to cell variable
            cell = orgCell
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("opportunities")
            let oppCell = cell as! OpportunitiesCell
            //print(filteredEvents.count)
            
            let event = filteredEvents[indexPath.row]
            
            //valueToPass = indexPath.row
            //organizationID = event.organizationID
            //eventID = event.eventID
            //print("OrganizationID: \(organizationID) and EventID: \(eventID)")
            oppCell.opportunityTitleLabel.text = event.eventName
            oppCell.opportunityDateLabel.text = event.eventStartTime
            oppCell.opportunityOrganizationLabel.text = event.organizationName
            
            oppCell.accessoryType = .DisclosureIndicator
            //Reasigning to cell variable
            cell = oppCell
            
        case 2:
            //self.title = "Interests"
            cell = tableView.dequeueReusableCellWithIdentifier("interests")
            let intCell = cell as! InterestsCell
            
            let organization = filteredOrganizations[indexPath.row]
            //interest specific code
            intCell.interestTitleLabel.text = organization.organizationInterest
            intCell.accessoryType = .DisclosureIndicator
            
            //Reasigning to cell variable
            cell = intCell
            
        default:
            //volunteerTitleLabel.text = "Error"
            print("no Data")
            //should print error message, etc.
        }
        
        //print("Returning Cell")
        return cell; //return the cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        valueToPass = indexPath.row
        switch (segmentedControl.selectedSegmentIndex)
        {
        case 0:
            performSegueWithIdentifier("organizationSegue", sender: self)
        case 1:
            organizationID = filteredEvents[valueToPass].organizationID
            eventID = filteredEvents[valueToPass].eventID
            performSegueWithIdentifier("opportunitySegue", sender: self)
        case 2:
            performSegueWithIdentifier("interestsSegue", sender: self)
        default:
            print("not good")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("Prepare for Segue")
        //let cell = sender as! UITableViewCell
        print(segue.identifier!)
        switch (segue.identifier!)
        {
        case "opportunitySegue":
            print("opportunity")
            let vc = segue.destinationViewController as! OpportunitiesViewController
            let event = filteredEvents[valueToPass]
            
            vc.filteredTasks = event.eventTasks;
            vc.filteredEvent = event
            vc.organizationID = organizationID
            vc.eventID = eventID
            print("OrganizationID: \(organizationID) and EventID: \(eventID)")
            vc.valueToPass = valueToPass
        case "interestsSegue":
            
            let vc = segue.destinationViewController as! InterestsViewController
            
        case "organizationSegue":
            
            let vc = segue.destinationViewController as! OrganizatonViewController
            vc.organization = filteredOrganizations[valueToPass]
            
            
        default:
            print("Prepare for Segue Error!")
        }
        
        // initialize new view controller and cast it as your view controller
        //let viewController = segue.destinationViewController as! OpportunitiesViewController
        // your new view controller should have property that will store passed value
        //print("Value to Pass to View Controller = \(valueToPass)")
        //viewController.passedValue = valueToPass
        
        
    }

}
