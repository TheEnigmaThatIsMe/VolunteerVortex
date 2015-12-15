//
//  ContactUsViewController.swift
//  VolunteerVortex
//
//  Created by Xuan Liu on 12/12/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit
import CoreData

class ContactUsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var comment: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var profile: NSManagedObject?
    var lastName: String? = ""
    var firstName: String? = ""
    var activeTextField: UITextField? = nil
    var activeTextView: UITextView? = nil
    let keyboardVerticalSpacing: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("contact us")
        comment.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"User")
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults where results.count > 0{
                profile = results[0]
                firstName = results[0].valueForKey("firstName") as? String
                lastName = results[0].valueForKey("lastName") as? String
                email.text = results[0].valueForKey("email") as? String
                name.text = "\(firstName!) \(lastName!)"
            } else {
                print("Could not fetch profiles")
            }
        } catch {
            return
        }
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
        let message = "We received your comment!"
        let okText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: okText, style: UIAlertActionStyle.Default, handler: { action in
            self.navigationController?.popViewControllerAnimated(true)
        })
        
        alert.addAction(okButton)
        presentViewController(alert, animated: true, completion: nil)
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
