//
//  comment.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/12/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class comment: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableViewComment: UITableView!
    @IBOutlet weak var textFieldComment: UITextField!
    
    var commentArray = [String]()
    var parentObjectID = String()
    var userIdArray = [String]()
    
    @IBAction func uploadComment(sender: AnyObject) {
        
        
        
       // var myComment = PFObject(className:"Comment")
       // myComment["parent"] = "\(parentObjectID)"
        
       // myComment.saveInBackground()
        let game = PFObject(className:"Game")
        game["createdBy"] = PFUser.currentUser()
        game["comment"] = "" + textFieldComment.text
        game["parent"] = parentObjectID
        
        game.saveInBackground()
        
      
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         println(self.parentObjectID)
        let queryComments = PFQuery(className: "Game")
        // queryComments.whereKey(kPAPActivityPhotoKey, equalTo: photo)
        queryComments.whereKey("parent", equalTo: "\(parentObjectID)")
        
        queryComments.findObjectsInBackgroundWithBlock {
            (comments: [AnyObject]?, error: NSError?) -> Void in
            // comments now contains the comments for myPost
            
            if error == nil {
                //에러없는 경우
               
                for post in comments! {
                    
                    self.commentArray.append(post["comment"] as! String)
                   // self.userIdArray.append(post["createdBy"] as! String)
                    self.tableViewComment.reloadData()
                }

                
                
            }else{
                
                println(error)
                
            }

        
       
    }
    }
    
          /*

    //오브젝트 변경 저장
        var myComment = PFQuery(className:"Comment")
        myComment.getObjectInBackgroundWithId("AHGsDW3QnU") {
            (comment: PFObject?, error: NSError?) -> Void in
            if error != nil {
                println(error)
            } else if let comment = comment {
                comment["content"] = self.textFieldComment.text
                comment["uploader"] = PFUser.currentUser()
              //  comment.addUniqueObjectsFromArray(["flying", "kungfu"], forKey:"content")
                comment.saveInBackground()
            }
        }
        
        // Assume PFObject *myPost was previously created.
        // Using PFQuery
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        let queryComments = PFQuery(className: "Comment")
        // queryComments.whereKey(kPAPActivityPhotoKey, equalTo: photo)
        queryComments.whereKey("parrent", equalTo: "QrGLu1tyuK")
        
        queryComments.findObjectsInBackgroundWithBlock {
            (comments: [AnyObject]?, error: NSError?) -> Void in
            // comments now contains the comments for myPost
            
            if error == nil {
                //에러없는 경우
                
                for post in comments! {
                    
                    self.commentArray.append(post["commentArray"] as! String)
                    
                    
                            }
                
            } else { println(error)
            }

        
    }
    

        

        
      /*  let query = PFQuery(className: "Comment")
        //query.whereKey("post", equalTo: myPost)
        query.whereKey("post", equalTo: PFObject(withoutDataWithClassName: "parent", objectId: "QrGLu1tyuK"))

        query.findObjectsInBackgroundWithBlock {
            (comments: [AnyObject]?, error: NSError?) -> Void in
            // comments now contains the comments for myPost
        }
        
        // Using NSPredicate
        let predicate = NSPredicate(format: "post = %@", myPost)
        let query = PFQuery(className: "Comment", predicate: predicate)
        
        query.findObjectsInBackgroundWithBlock {
            (comments: [AnyObject]?, error: NSError?) -> Void in
            // comments now contains the comments for myPost
        }*/
           }

    
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return commentArray.count
        
    }
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as! UITableViewCell
       
        cell.textLabel?.text = self.commentArray[indexPath.row]
       // cell.detailTextLabel!.text = self.userIdArray[indexPath.row]
        
        return cell
    }
}
