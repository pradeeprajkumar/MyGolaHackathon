//
//  HomeViewController.swift
//  TravComp
//
//  Created by Pradeep Rajkumar on 25/07/15.
//  Copyright (c) 2015 GIB. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var destinationTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.initializeViewControllerSettings()
    }
    
    func initializeViewControllerSettings () {

        self.title = "Travel Companion"
        self.destinationTextField.becomeFirstResponder()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Textfield delegates
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {

        if (count(textField.text) > 0)
        {
            self.pushMapsViewController(textField.text)
            return true
        }
        else
        {
            return false
        }
    }
    
    func pushMapsViewController (destinationLocation:String) {
        
        let mapViewControllerObejct = self.storyboard?.instantiateViewControllerWithIdentifier("MapViewControllerIdentifier") as? MapViewController
        mapViewControllerObejct?.destinationLocation = destinationLocation
        self.navigationController?.pushViewController(mapViewControllerObejct!, animated: true)

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
