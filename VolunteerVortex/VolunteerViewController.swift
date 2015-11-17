//
//  VolunteerViewController.swift
//  VolunteerVortex
//
//  Created by Joseph Trammel on 11/7/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class VolunteerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //need to get data that has been loaded or load data from json to use
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var table: UITableView!
    @IBAction func opportunitiesSegmentedControl(sender: UISegmentedControl) {
        
        //Load info to put in table View
        
        //This should refresh the table view
        table.reloadData()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial Loading of Data

        
    }
    /*
    The following functions are necessary for using the table views
*/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0; //count of items in table, must have data to know
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //decide which table to build
        
        var cell : UITableViewCell!;
        
        switch (segmentedControl.selectedSegmentIndex)
        {
        case 0:
            cell = tableView.dequeueReusableCellWithIdentifier("organizations")
            //organization specific code
        case 1:
            cell = tableView.dequeueReusableCellWithIdentifier("opportunities")
            //oppurtunity specific code
        case 2:
            cell = tableView.dequeueReusableCellWithIdentifier("interests")
            //interest specific code
        default:
            print("no Data")
            //should print error message, etc.
        }
        
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
