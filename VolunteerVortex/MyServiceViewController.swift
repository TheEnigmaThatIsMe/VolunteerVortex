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
    
    var registeredEvents = [NSManagedObject]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var deleteIndexPath: NSIndexPath? = nil
    //Need these varaibles for prepareForSegue function
    /*
    let organizationCollection = OrganizationCollection.sharedInstance //get data from OrganizationCollection.swift
    var filteredOrganizations: [Organization]!
    var filteredEvents: [Event]!
    var event: Event? = nil
    
    var organizationID: Int? = nil
    var eventID: Int? = nil
    var eventList: Event!
    var valueToPass: Int = 0
    */
    
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
            } else {
                print("Could not fetch registeredEvents")
            }
        } catch {
            return
        }
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
        
        var cell : UITableViewCell!;
        cell = tableView.dequeueReusableCellWithIdentifier("myOpportunities")
        let oppCell = cell as! OpportunitiesCell
        let event = registeredEvents[indexPath.row]
        
        //check to make sure values are not nil
        if let eventName = event.valueForKey("eventName") as? String,
        let eventOrg = event.valueForKey("organizationName") as? String,
            let eventTime = event.valueForKey("startTime") as? String{
                oppCell.opportunityTitleLabel.text = eventName
                oppCell.opportunityDateLabel.text = eventTime
                oppCell.opportunityOrganizationLabel.text = eventOrg
        }
        
        /*
        implement this once prepare for segue function is complete
        oppCell.accessoryType = .DisclosureIndicator
        */
        
        //Reassigning to cell variable
        cell = oppCell
        
        return cell; //return the cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        /* Need these values for prepare for segue function
        valueToPass = indexPath.row
        performSegueWithIdentifier("myServices2Opp", sender: self)*/
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let alert = UIAlertController(title: "Wait!", message: "Are you sure you want to delete this event?", preferredStyle: UIAlertControllerStyle.Alert)
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            deleteIndexPath = indexPath
            let indexToDelete = [indexPath.row]
            confirmDelete()
            
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: { action in
                // handle delete (by removing the data from your array and updating the tableview)
                // remove the deleted item from the model
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        }
    }
    
    func confirmDelete() {
        let alert = UIAlertController(title: "Delete Event", message: "Are you sure you want to permanently delete this event?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteIndex)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteIndex)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func handleDeleteIndex(alertAction: UIAlertAction!) -> Void {
        if let indexPath = deleteIndexPath {
            
            let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDel.managedObjectContext
            context.deleteObject(self.registeredEvents[indexPath.row] as NSManagedObject)
            self.registeredEvents.removeAtIndex(indexPath.row)
            myEventsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            do {
                try context.save()
            } catch let error {
                print("Could not cache the response \(error)")
            }
            /*myEventsTableView.beginUpdates()
            
            registeredEvents.removeAtIndex(indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            myEventsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
            deleteIndexPath = nil
            
            myEventsTableView.endUpdates()*/
        }
    }
    
    func cancelDeleteIndex(alertAction: UIAlertAction!) {
        deleteIndexPath = nil
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("Prepare for Opportunity Segue")
        //let cell = sender as! UITableViewCell
        print(segue.identifier!)
        switch (segue.identifier!){
            
        case "myServices2Opp":
            print("Services2Opp")
            let vc = segue.destinationViewController as! OpportunitiesViewController
            let event = registeredEvents[valueToPass]
            //vc.event = event
            if let organizationID = event.valueForKey("organizationId") as? Int,
                let eventID = event.valueForKey("eventId") as? Int {
                    vc.organizationID = organizationID
                    vc.eventID = eventID
            }

            print("OrganizationID: \(vc.organizationID) and EventID: \(vc.eventID)")
            //vc.filteredTasks = event.eventTasks;
            //vc.filteredEvent = event
            vc.valueToPass = valueToPass
        default:
            print("Prepare for Segue Error!")
        }
    }*/
}