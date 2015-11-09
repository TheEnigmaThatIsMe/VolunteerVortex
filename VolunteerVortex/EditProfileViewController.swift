//
//  EditProfileViewController.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 11/9/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBAction func cancelButton(sender: AnyObject) {
    }
    
    @IBAction func saveButton(sender: AnyObject) {
    }
    
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var statePicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
