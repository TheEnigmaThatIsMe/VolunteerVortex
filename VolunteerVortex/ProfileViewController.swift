//
//  ProfileViewController.swift
//  VolunteerVortex
//
//  Created by Joseph Trammel on 11/7/15.
//  Copyright © 2015 George Gilmartin. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var profile = NSManagedObject?()
    var imageFilePath : String?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var organizationCollectionView: UICollectionView!
    @IBOutlet weak var aboutMe: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapGesture:")
        // add it to the image view;
        profileImage.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        profileImage.userInteractionEnabled = true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        loadProfile()
        
        if profile != nil{
            if let firstname = profile!.valueForKey("firstName"){
                if let lastname = profile!.valueForKey("lastName"){
                    nameLabel.text = (firstname as! String) + " " + (lastname as! String)
                }
            }
        
        if let city = profile!.valueForKey("city"){
            if let state = profile!.valueForKey("state"){
                locationLabel.text = (city as! String) + " " + (state as! String)

            }
        }
        if let age = profile!.valueForKey("age"){
            ageLabel.text = age as? String
        }
        if let about = profile!.valueForKey("about"){
            aboutMe.text = about as? String
        }
            
        imageFilePath = profile!.valueForKey("profileImagePath") as? String
        print(imageFilePath)
        }
        
        //print("will load: path")
        
        if imageFilePath != nil{
            // image is the image loaded from the file that was saved when image was loaded
            print("output photo")
            print("!!"+imageFilePath!)
            
            // this is where the image is to be saved after it is retrieved
            let directoryPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentDir = directoryPaths[0]
            let imageFilePath2 = (documentDir as NSString).stringByAppendingPathComponent("profileImage.png")
            print("image picker")
            print(imageFilePath2)
            
            self.profileImage.image = UIImage(contentsOfFile: imageFilePath2)
            
        }
    }
    
    //get image from photo library
    func tapGesture(gesture: UIGestureRecognizer) {
        print("add")
        let imagePicker = UIImagePickerController()
        imagePicker.editing = false
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Action Sheet", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let libraryButton = UIAlertAction(title: "Select from photo library", style: UIAlertActionStyle.Default){(librarySelected)->Void in
            print("Library selected")
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker,animated: true, completion: nil)
        }
        let cameraButton = UIAlertAction(title: "Take Picture", style: UIAlertActionStyle.Default){(cameraSelected)->Void in
            print("Camera selected")
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker,animated: true, completion: nil)
        }
        let cancelButton = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel){(cameraSelected)->Void in
            print("Cancel")
        }
        actionSheet.addAction(libraryButton)
        actionSheet.addAction(cameraButton)
        actionSheet.addAction(cancelButton)
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject: AnyObject]!){
        self.dismissViewControllerAnimated(true, completion: nil)
        self.profileImage.image = image
        
        // this is where the image is to be saved after it is retrieved
        let directoryPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDir = directoryPaths[0]
        let imageFilePath = (documentDir as NSString).stringByAppendingPathComponent("profileImage.png")
        print("image picker")
        print(imageFilePath)
        
        saveImage(image, toFilePath: imageFilePath, imageSaveType: "PNG") {
            (img, filePath, errorString) -> Void in
            if let errorString = errorString {
                print(errorString)
            } else {
                print("image picker: get photo")
                // image is the image loaded from the file that was saved when image was loaded
                self.profileImage.image = UIImage(contentsOfFile: imageFilePath)
            }
        }
        
    }
    
    
    
    
    
    //save image to filepath
    func saveImage(image: UIImage, toFilePath: String, imageSaveType: String?, completionHandler: (UIImage?, String, String?) -> Void) {
        //save file and call completion handler with imagevar success: Bool?
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        print("!!!!previous")
        print(profile)
        if profile == nil {
            print("exist")
            let profileEntity =  NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
            profile = NSManagedObject(entity: profileEntity!, insertIntoManagedObjectContext:managedContext)
        }
        print("save image: photo")
        print(image)
        var success: Bool?
        
        if let imageSaveType = imageSaveType where imageSaveType == "JPEG" {
            success = UIImageJPEGRepresentation(image, 1.0)?.writeToFile(toFilePath, atomically: true)
            print(toFilePath)
        } else {
            success = UIImagePNGRepresentation(image)?.writeToFile(toFilePath, atomically: true)
        }
        
        if (success!) {
            profile!.setValue(toFilePath, forKey: "profileImagePath")
            
            // Complete save and handle potential error
            do {
                try managedContext.save()
                print("saved")
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(image, toFilePath, nil)
            })
        } else {
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler(image, toFilePath, "error saving image")
            })
        }
        
    }
    
    
    
    
    func loadProfile(){
        // Load saved note entities from core data
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName:"User")
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults where results.count > 0 {
                profile = results[0]
                print("load profile: profile")
                print(profile)
                //deleteProfileAtIndex(1)
            } else {
                print("Could not fetch profiles")
            }
        } catch {
            return
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
