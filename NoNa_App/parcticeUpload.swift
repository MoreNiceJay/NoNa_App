//
//  parcticeUpload.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/11/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class parcticeUpload: UIViewController {
    @IBOutlet weak var textFieldComment: UITextField!
    @IBOutlet weak var labelComment: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        var gameScore = PFObject(className:"GameScore")
        gameScore["score"] = 1337
        gameScore["playerName"] = "Sean Plott"
        gameScore["cheatMode"] = false
        gameScore.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
        
        
        
        var query = PFQuery(className:"GameScore")
        query.getObjectInBackgroundWithId("uzJlVAlaAC") {
            (gameScore: PFObject?, error: NSError?) -> Void in
            if error == nil && gameScore != nil {
               
                let objectId = gameScore!.objectId
                println("여기부터")
                
                println(objectId!)
                
                println("여기까지")
                
                
                self.labelComment.text = objectId!
            } else {
                println(error)
            }
        }
        
    
    }


    
}
