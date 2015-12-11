//
//  OpportunitiesViewController.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 11/22/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class OpportunitiesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let organizationCollection = OrganizationCollection.sharedInstance //get data from OrganizationCollection.swift
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var eventsTableView: UITableView!
    
    var valueToPass: Int = 0
    var passedValue: Int = 0
    var filteredEvent: Event!
    var filteredTasks: [Task]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Event Info"
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        print("Value to pass = \(valueToPass)")
        print("Passed Value = \(passedValue)")
        //eventTitle.text = "Pooches and Booches Puppy Playground"
        //filteredTasks = organizationCollection.tasks
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    The following functions are necessary for using the table views
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows \(filteredTasks.count)")
        return filteredTasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //print("cellForRowAtIndexPath")
        //decide which table to build
        
        var cell : UITableViewCell!
        
        cell = tableView.dequeueReusableCellWithIdentifier("taskCell")
        let taskCell = cell as! TaskCell
        
        let task = filteredTasks[indexPath.row]
        
        
        taskCell.taskTitleLabel.text = task.taskName
        taskCell.taskDescriptionLabel.text = task.taskDescription
        taskCell.taskTimeLabel.text = task.taskTime
        
        //Reasigning to cell variable
        cell = taskCell
        
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
