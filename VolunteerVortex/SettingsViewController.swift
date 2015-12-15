//
//  SettingsViewController.swift
//  VolunteerVortex
//
//  Created by Joseph Trammel on 11/7/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        print("did load")
    }
    
    var cell : UITableViewCell!;
    var settingList = ["Contact Volunteer Vortex", "My Contact Preference"]
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var height : CGFloat
        
        height = 50
        
        return height
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("table view")
        let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell") as! SettingsCell
        print("settingscell")
        cell.titleLabel?.text = "\(settingList[indexPath.row])"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            performSegueWithIdentifier("contactUsSegue", sender: self)
        }
        else{
            performSegueWithIdentifier("contactPreferSegue", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch (segue.identifier!)
        {
            case "contactUsSegue":
                let vc = segue.destinationViewController as! ContactUsViewController
            case "contactPreferSegue":
                let vc = segue.destinationViewController as! ContactPreferViewController
            default:
                print("Prepare for Segue Error!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
