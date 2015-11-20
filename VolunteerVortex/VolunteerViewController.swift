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
    //need to get data that has been loaded or load data from json to use
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    @IBAction func opportunitiesSegmentedControl(sender: UISegmentedControl) {
        
        //Load info to put in table View
        print(sender.selectedSegmentIndex)
        //This should refresh the table view
        table.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        filteredOrganizations = organizationCollection.organizations
        print(filteredOrganizations.count)
    }
    /*
    The following functions are necessary for using the table views
*/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows")
        switch (segmentedControl.selectedSegmentIndex)
        {
        case 0:
            return filteredOrganizations.count
        case 1:
            return 20 // count of items in table, must have data to know
        case 2:
            return 20 // count of items in table, must have data to know
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
        print("cellForRowAtIndexPath")
        //decide which table to build
        
        var cell : UITableViewCell!;
        
        switch (segmentedControl.selectedSegmentIndex)
        {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("organizations")
            let orgCell = cell as! OrganizationCell
            print(filteredOrganizations.count)
            
            let organization = filteredOrganizations[indexPath.row]
            orgCell.title.text = organization.organizationName
            orgCell.about.text = organization.description
            
            orgCell.accessoryType = .DisclosureIndicator
            
            //return orgCell

            
            //organization specific code
            //orgCell.title.text = "Organization Cell"
            
            //Reasigning to cell variable
            cell = orgCell
            
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("opportunities")
            let oppCell = cell as! OpportunitiesCell
        
            
            //oppurtunity specific code
            oppCell.title.text = "Oppurtunities Cell"
            
            //Reasigning to cell variable
            cell = oppCell
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("interests")
            let intCell = cell as! InterestsCell
            
            //interest specific code
            intCell.title.text = "Interests Cell"
            
            //Reasigning to cell variable
            cell = intCell
        default:
            print("no Data")
            //should print error message, etc.
        }
        
        print("Returning Cell")
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
