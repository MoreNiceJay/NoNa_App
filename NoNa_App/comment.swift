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
        
        let game = PFObject(className:"Game")
        game["createdBy"] = PFUser.currentUser()
        game["comment"] = "" + textFieldComment.text
        game["parent"] = parentObjectID
        
        game.saveInBackground()
        println("시작 :   \(self.commentArray)")
        commentArray = []
        queryComment()
        //인터넷이 느린지역 바로 업로드 되지 않는 문제
        //타이머를 넣어 해결 혹은 파스 서버와 대조 해보고 에러 메세지 줘야함
        //혹은 클릭 하면 어레이가 늘어나는걸 확인해야함
        self.tableViewComment.reloadData()
        textFieldComment.text = ""
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryComment()
        
         }
    
    func queryComment() {
       
        
        let queryComments = PFQuery(className: "Game")
        
        queryComments.whereKey("parent", equalTo: "\(parentObjectID)")
        queryComments.orderByAscending("createdAt")
        queryComments.findObjectsInBackgroundWithBlock {
            (comments: [AnyObject]?, error: NSError?) -> Void in
           
            // comments now contains the comments for myPost
            
            if error == nil {
                //에러없는 경우
                for post in comments! {
                    self.commentArray.append(post["comment"] as! String)
                    // self.userIdArray.append((PFUser.currentUser()) as! String)
                    // self.userIdArray.append(post["createdBy"] as! String)
                    
                    self.tableViewComment.reloadData()
                    println("시작 :   \(self.commentArray)")
                }
                }else{
                println(error)
            }
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return commentArray.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as! UITableViewCell
       
        cell.textLabel?.text = self.commentArray[indexPath.row]
       // cell.detailTextLabel!.text = self.userIdArray[indexPath.row]
        
        return cell
    }
}
