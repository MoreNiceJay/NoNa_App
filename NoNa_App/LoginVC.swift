//
//  LoginVC.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/3/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        var username = usernameTextField.text
        var password = passwordTextfield.text
        
        if username.isEmpty || password.isEmpty {
            
            println("로그인 페이지 :빈칸 ")
            
            
            //유저에게 알리기
        }else {
            PFUser.logInWithUsernameInBackground(username, password : password, block: { (user : PFUser?, error : NSError?) -> Void in
                if error == nil {
                    
                    //로그인성공
                    
                println(user)
                    self.performSegueWithIdentifier("loginToHome", sender: self)
                    
                    //유저를 홈으로
                }else{
            //유저에게 얼럴트
                    println("로그인페이지 : 로그인 프로세스 실패")
                    
                }
            })
        
        
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
