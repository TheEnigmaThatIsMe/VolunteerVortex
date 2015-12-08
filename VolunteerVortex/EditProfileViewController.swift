//
//  EditProfileViewController.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 11/9/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    var activeTextField: UITextField? = nil
    let keyboardVerticalSpacing: CGFloat = 30
    
    @IBAction func saveButton(sender: AnyObject) {
        
    }
    
    @IBOutlet weak var agePicker: UIPickerView!
    let agePickerData = ["18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120", "121", "122"]
    
    @IBOutlet weak var statePicker: UIPickerView!
    let statePickerData = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit My Profile"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
        /*agePicker.dataSource = self
        agePicker.delegate = self
        statePicker.dataSource = self
        statePicker.delegate = self*/

    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return agePickerData.count
        }
        else{
            return statePickerData.count
        }
    }
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return agePickerData[row]
        }
        else{
            return statePickerData[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
        
        let activeTextFieldSize = CGRectMake(activeTextField!.frame.origin.x, activeTextField!.frame.origin.y, activeTextField!.frame.width, activeTextField!.frame.height + keyboardVerticalSpacing)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.scrollView.scrollRectToVisible(activeTextFieldSize, animated: true)
        })
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        activeTextField?.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        activeTextField?.resignFirstResponder()
    }
    
    func keyboardWasShown(aNotification: NSNotification) {
        let userInfo = aNotification.userInfo
        
        if let info = userInfo {
            let kbSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
            
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            let activeTextFieldSize = CGRectMake(activeTextField!.frame.origin.x, activeTextField!.frame.origin.y, activeTextField!.frame.width, activeTextField!.frame.height + keyboardVerticalSpacing)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.scrollView.scrollRectToVisible(activeTextFieldSize, animated: true)
            })
        }
    }
    
    func keyboardWillBeHidden(aNotification: NSNotification) {
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
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
