//
//  MyServiceViewController.swift
//  VolunteerVortex
//
//  Created by Joseph Trammel on 11/7/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit
import CoreData

class MyServiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myEventsTableView: UITableView!
    
    let organizationCollection = OrganizationCollection.sharedInstance //get data from OrganizationCollection.swift
    var filteredOrganizations: [Organization]!
    var filteredEvents: [Event]!
    var event: Event? = nil
    var registeredEvents = [NSManagedObject]()
    var organizationID: Int? = nil
    var eventID: Int? = nil
    var eventList: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myEventsTableView.delegate = self
        myEventsTableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        loadRegisteredEvents()
        myEventsTableView.reloadData()
    }
    
    func loadRegisteredEvents(){
        // Load saved note entities from core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"Event")
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                    registeredEvents = results
                    print("Load Registered Events: registeredEvents")
                    print(registeredEvents)
                
                //deleteProfileAtIndex(1)
            } else {
                print("Could not fetch registeredEvents")
            }
        } catch {
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registeredEvents.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let height:CGFloat = 70
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print("cellForRowAtIndexPath")
        
        var cell : UITableViewCell!;
        cell = tableView.dequeueReusableCellWithIdentifier("myOpportunities")
        let oppCell = cell as! OpportunitiesCell
        //print(filteredEvents.count)
        let event = registeredEvents[indexPath.row]
        //let registeredEvent = myServicesCollection.servicesArray[indexPath.row]
        print(event.valueForKey("eventName") as? String)
        let eventName = event.valueForKey("eventName") as? String
        let eventOrg = event.valueForKey("organizationName") as? String
        let eventTime = event.valueForKey("startTime") as? String
        
        //valueToPass = indexPath.row
        //organizationID = event.organizationID
        //eventID = event.eventID
        //print("OrganizationID: \(organizationID) and EventID: \(eventID)")
        oppCell.opportunityTitleLabel.text = eventName
        oppCell.opportunityDateLabel.text = eventTime
        oppCell.opportunityOrganizationLabel.text = eventOrg
            //        oppCell.opportunityTitleLabel.text = "Title Label"
//        oppCell.opportunityDateLabel.text = "Date text"
//        oppCell.opportunityOrganizationLabel.text = "Organization"
        
        oppCell.accessoryType = .DisclosureIndicator
        //Reasigning to cell variable
        cell = oppCell
        
        return cell; //return the cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        performSegueWithIdentifier("opportunitySegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("Prepare for Segue")
        //let cell = sender as! UITableViewCell
        print(segue.identifier!)
        switch (segue.identifier!){

        case "opportunitySegue":
            print("opportunity")
            let vc = segue.destinationViewController as! OpportunitiesViewController
            //let event = filteredEvents[valueToPass]
            //vc.filteredTasks = event.eventTasks;
            //vc.filteredEvent = event
            //vc.valueToPass = valueToPass

        default:
            print("Prepare for Segue Error!")
        }
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
