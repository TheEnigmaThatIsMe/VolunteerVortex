//
//  OrganizatonViewController.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 11/22/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class OrganizatonViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var organizationDescriptionLabel: UILabel!
    @IBOutlet weak var organizationProfileImageView: UIImageView!
    @IBOutlet weak var organizationTableView: UITableView!
    

    var organization: Organization? = nil
    var events: [Event] = Array<Event>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        organizationTableView.dataSource = self
        organizationTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        
        events = (organization?.organizationEvents)!
        
        organizationDescriptionLabel.text = organization?.organizationDescription
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
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
