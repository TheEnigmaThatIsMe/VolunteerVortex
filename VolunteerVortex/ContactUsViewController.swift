//
//  ContactUsViewController.swift
//  VolunteerVortex
//
//  Created by Xuan Liu on 12/12/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var comment: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("contact us")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendComment(sender: AnyObject) {
        if(name.text == "" || email.text == "" || comment.text == ""){
            let title = "Information required"
            let message = "Check out your information"
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: okText, style: UIAlertActionStyle.Cancel, handler: nil)
            
            alert.addAction(okButton)
            presentViewController(alert, animated: true, completion: nil)
        }

        let title = "Thank You"
        let message = "We get your comment!"
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: okText, style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(okButton)
        presentViewController(alert, animated: true, completion: nil)
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
