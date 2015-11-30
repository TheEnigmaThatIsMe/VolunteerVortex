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
    //var filteredTasks: [Task]!
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
        //print(filteredOrganizations.count)
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
            return 20//filteredTasks.count // count of items in table, must have data to know
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
            //print(organization.organizationPhone)
            
            orgCell.accessoryType = .DisclosureIndicator
            
            //Reasigning to cell variable
            cell = orgCell
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("opportunities")
            let oppCell = cell as! OpportunitiesCell
            //print(filteredEvents.count)
            
            let event = filteredEvents[indexPath.row]
            
            
            oppCell.opportunityTitleLabel.text = event.eventName
            oppCell.opportunityDateLabel.text = event.eventStartTime
            //oppCell.opportunityOrganizationLabel.text = organization.organizationName
            
            oppCell.accessoryType = .DisclosureIndicator
            //Reasigning to cell variable
            cell = oppCell
            
        case 2:
            //self.title = "Interests"
            cell = tableView.dequeueReusableCellWithIdentifier("interests")
            let intCell = cell as! InterestsCell
            
            //interest specific code
            intCell.interestTitleLabel.text = "Interests Cell"
            
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
