//
//  EditProfileViewController.swift
//  VolunteerVortex
//
//  Created by George Gilmartin on 11/9/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class EditProfileViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var aboutTextView: UITextView!

    var profile: NSManagedObject?
    var activeTextField: UITextField? = nil
    var activeTextView: UITextView? = nil
    let keyboardVerticalSpacing: CGFloat = 10
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        
        aboutTextView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"User")
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults where results.count > 0{
                profile = results[0]
                firstNameTextField.text = results[0].valueForKey("firstName") as? String
                lastNameTextField.text = results[0].valueForKey("lastName") as? String
                ageTextField.text = results[0].valueForKey("age") as? String
                stateTextField.text = results[0].valueForKey("state") as? String
                cityNameTextField.text = results[0].valueForKey("city") as? String
                emailTextField.text = results[0].valueForKey("email") as? String
            } else {
                print("Could not fetch profiles")
            }
        } catch {
            return
        }
        
    }

    
    
    
    @IBAction func saveButton(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        if profile == nil {
            print("exist")
            let profileEntity =  NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
            profile = NSManagedObject(entity: profileEntity!, insertIntoManagedObjectContext:managedContext)
        }
        
        if(firstNameTextField.text == "" || lastNameTextField.text == "" || cityNameTextField.text == "" || emailTextField.text == ""||ageTextField.text == "" || stateTextField.text == ""){
            let title = "Information required"
            let message = "Check out your information"
            let okText = "OK"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            let okButton = UIAlertAction(title: okText, style: UIAlertActionStyle.Cancel, handler: nil)
            
            alert.addAction(okButton)
            presentViewController(alert, animated: true, completion: nil)
        }
        
        else{
            profile?.setValue(firstNameTextField.text, forKey: "firstName")
            profile?.setValue(lastNameTextField.text, forKey: "lastName")
            profile?.setValue(ageTextField.text, forKey: "age")
            profile?.setValue(stateTextField.text, forKey: "state")
            profile?.setValue(cityNameTextField.text, forKey: "city")
            profile?.setValue(emailTextField.text, forKey: "email")
            profile?.setValue(aboutTextView.text, forKey: "about")
            
            // Complete save and handle potential error
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            let dataString = "firstName=" + firstNameTextField.text! + "&lastName=" + lastNameTextField.text! + "&age=" + ageTextField.text! + "&state=" + stateTextField.text! + "&city=" + cityNameTextField.text! + "&email=" + emailTextField.text! + "&about=" + aboutTextView.text!
            print(dataString)
            
            let url = "http://phantom1.cloudapp.net/app/echo.php"
            
            
            doPost(url, dataString: dataString) {
                (response, errorStr) -> Void in
                if let errorString = errorStr {
                    print(errorString)
                } else {
                    print(response)
                }
            }
            
            self.navigationController?.popToRootViewControllerAnimated(true)
        }

    }
    
    func doPost(toURLString: String, dataString: String, completionHandler: (NSDictionary, String?) -> Void) {
        let myUrl = NSURL(string: toURLString)
        let urlRequest = NSMutableURLRequest(URL: myUrl!)
        urlRequest.HTTPMethod = "POST"
        
        
        urlRequest.HTTPBody = dataString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest, completionHandler:{
            (data, response, error) -> Void in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    completionHandler(NSDictionary(), error!.localizedDescription)
                })
            } else {
                self.parse(data!, completionHandler: completionHandler)
                //print(response)
                //return
            }
        })
        task.resume()
    }
    
    private func parse(jsonData: NSData, completionHandler: (NSDictionary, String?) -> Void) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            print(jsonResult)
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(jsonResult!, nil)
            })
        } catch {
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(NSDictionary(), "Error parsing returned JSON")
            })
        }
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
