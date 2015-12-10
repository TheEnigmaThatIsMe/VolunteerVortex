//
//  EditProfileViewController.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 11/9/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!

    
    var activeTextField: UITextField? = nil
    var activeTextView: UITextView? = nil
    let keyboardVerticalSpacing: CGFloat = 10
    
    @IBAction func saveButton(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        
        aboutTextView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)

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
        if ((activeTextField?.isFirstResponder()) != nil){
            activeTextField?.resignFirstResponder()
        }
        else if ((activeTextView?.isFirstResponder()) != nil){
            activeTextView?.resignFirstResponder()
        }
        
    }
    
    func keyboardWasShown(aNotification: NSNotification) {
        let userInfo = aNotification.userInfo
        
        if let info = userInfo {
            let kbSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
            
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            if((activeTextField?.isFirstResponder()) != nil){
            let activeTextFieldSize = CGRectMake(activeTextField!.frame.origin.x, activeTextField!.frame.origin.y, activeTextField!.frame.width, activeTextField!.frame.height + keyboardVerticalSpacing)
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.scrollView.scrollRectToVisible(activeTextFieldSize, animated: true)
                })
            }
            else if (activeTextView?.isFirstResponder() != nil){
                let activeTextViewSize = CGRectMake(activeTextView!.frame.origin.x, activeTextView!.frame.origin.y, activeTextView!.frame.width, activeTextView!.frame.height + keyboardVerticalSpacing)
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.scrollView.scrollRectToVisible(activeTextViewSize, animated: true)
                })
            }
            
            
        }
    }
    
    func keyboardWillBeHidden(aNotification: NSNotification) {
        scrollView.contentInset = UIEdgeInsetsZero
        scrollView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    // MARK: UITextViewDelegate
    func textViewDidBeginEditing(textView: UITextView) {
        activeTextView = textView
        
        let activeTextViewSize = CGRectMake(activeTextView!.frame.origin.x, activeTextView!.frame.origin.y, activeTextView!.frame.width, activeTextView!.frame.height + keyboardVerticalSpacing)
        
        dispatch_async(dispatch_get_main_queue(), {
            self.scrollView.scrollRectToVisible(activeTextViewSize, animated: true)
        })
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        activeTextView = nil
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
