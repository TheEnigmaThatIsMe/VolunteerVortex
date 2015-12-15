//
//  ContactPreferViewController.swift
//  VolunteerVortex
//
//  Created by Xuan Liu on 12/12/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class ContactPreferViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("contact prefer")
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var contactPreferTable: UITableView!
    
    var cell : UITableViewCell!;
    var contactTypeList = ["Email", "Phone Call", "Text Message"]
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactTypeList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell") as! ContactPreferenceCell
        let mySwitch = cell.viewWithTag(1) as! UISwitch
        mySwitch.tag = indexPath.row
        mySwitch.addTarget(self, action: "switchValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        cell.contactType?.text = "\(contactTypeList[indexPath.row])"
        return cell
    }
    
    
    func switchValueChanged(sender: AnyObject) {
        let switchRow = sender.tag
        let mySwitch = sender as! UISwitch
        print(mySwitch.on)
        if mySwitch.on == true {
        }
        else {
            print("else")
            let title = ""
            let message = "We will not contact you through \(contactTypeList[switchRow])"
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: okText, style: UIAlertActionStyle.Cancel, handler: nil)
            
            alert.addAction(okButton)
            presentViewController(alert, animated: true, completion: nil)
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
