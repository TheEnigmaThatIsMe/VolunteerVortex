//
//  OrganizatonViewController.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 11/22/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class OrganizatonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //let organizationCollection = OrganizationCollection.sharedInstance //get data from OrganizationCollection.swift
    
    @IBOutlet weak var organizationDescriptionLabel: UILabel!
    @IBOutlet weak var organizationProfileImageView: UIImageView!
    @IBOutlet weak var organizationTableView: UITableView!
    

    var organization: Organization? = nil
    var events: [Event] = Array<Event>()
    var valueToPass: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        organizationTableView.dataSource = self
        organizationTableView.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("opportunities") as! OpportunitiesCell
        let event = events[indexPath.row]
        
        //valueToPass = indexPath.row
        
        cell.opportunityTitleLabel.text = event.eventName
        cell.opportunityDateLabel.text = event.eventStartTime
        cell.opportunityOrganizationLabel.text = event.organizationName
        
        cell.accessoryType = .DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        valueToPass = indexPath.row
        performSegueWithIdentifier("Org2OppSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func viewWillAppear(animated: Bool) {
        
        events = (organization?.organizationEvents)!
        
        organizationDescriptionLabel.text = organization?.organizationDescription
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("Prepare for Opportunity Segue")
        //let cell = sender as! UITableViewCell
        print(segue.identifier!)
        switch (segue.identifier!)
        {
        case "Org2OppSegue":
            print("Org2Opp")
            let vc = segue.destinationViewController as! OpportunitiesViewController
            let event = events[valueToPass]
            vc.event = event
            vc.organizationID = (organization?.organizationID)!
            vc.eventID = event.eventID
            print("OrganizationID: \(vc.organizationID) and EventID: \(vc.eventID)")
            vc.filteredTasks = event.eventTasks;
            vc.filteredEvent = event
            vc.valueToPass = valueToPass
        default:
            print("Prepare for Segue Error!")
        }
        
        // initialize new view controller and cast it as your view controller
        //let viewController = segue.destinationViewController as! OpportunitiesViewController
        // your new view controller should have property that will store passed value
        //print("Value to Pass to View Controller = \(valueToPass)")
        //viewController.passedValue = valueToPass
        
        
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
