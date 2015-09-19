//
//  CustomSignUpViewController.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/18/15.
//  Copyright © 2015 jay. All rights reserved.
//

import UIKit
import Parse

class CustomSignUpViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confrimPasswordField: UITextField!

     var actInd : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actInd.center = self.view.center
        self.actInd.hidesWhenStopped = true
        self.actInd.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(self.actInd)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction(sender: AnyObject) {
        
        let username = self.usernameField.text
        let password = self.passwordField.text
        let cPassword = self.confrimPasswordField.text
        let email = self.emailField.text
        
        
        if !username!.isEmpty && !email!.isEmpty && !password!.isEmpty &&   !cPassword!.isEmpty {
        
        if (username?.utf16.count < 4 || password?.utf16.count < 5) {
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater then 4 and Password must be a greater then 5.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }else if (email?.utf16.count < 8 ){
            
            let alert = UIAlertView(title: "Invalid", message: "please enter a valid email", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }else {
            
            if password == cPassword {
            
            self.actInd.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = email
            
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                self.actInd.stopAnimating()
                
                if ((error) != nil) {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }else {
                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                }
            })
            
            }else{
                let alert = UIAlertView(title: "Invalid", message: "please enter same password", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }}
        }else {
            let alert = UIAlertView(title: "Invalid", message: "Empty blank", delegate: self, cancelButtonTitle: "OK")
            alert.show()

        }

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
