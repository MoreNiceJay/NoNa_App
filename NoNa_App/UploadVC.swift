//
//  UploadVC.swift
//  NoNa_App
//
//  Created by Lee Janghyup on 9/4/15.
//  Copyright (c) 2015 jay. All rights reserved.
//

import UIKit
import Parse

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageViewPreview: UIImageView!
    @IBOutlet weak var textFieldPreviewTitle: UITextField!
    
    var beginImage: CIImage!
    var context: CIContext!
    var filter: CIFilter!
    var intensity: Float = 0.5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func uploadPhoto(sender: AnyObject) {
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
    /*func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        //image.size = CGRect(origin: CGPoint, size: CGSize(width: 414, height: 191))
        imageViewPreview.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
      */
    func imagePickerViewController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: NSDictionary!) {
            self.dismissViewControllerAnimated(true, completion: nil)
            beginImage = CIImage(image: info[UIImagePickerControllerOriginalImage] as! UIImage)
            self.updateImageView()
    
    
    }
    
    
    func updateImageView() {
        filter.setValue(beginImage, forKey:kCIInputImageKey)
        filter.setValue(intensity, forKey:kCIInputIntensityKey)
        let output = context.createCGImage(filter.outputImage,
            fromRect: filter.outputImage.extent())
        let newImage = UIImage(CGImage: output)
        self.imageViewPreview.image = newImage
    }
    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        println("업로드 시작")
        var imageText = textFieldPreviewTitle.text
        var previewIamge = imageViewPreview.image
        
        if imageText.isEmpty || previewIamge == nil {
            
        
         //유저에게 채워넣으라고 알럴트
            println("업로드: 유저가 이미지 혹은 텍스트를 넣지않음")
            
        }else {
            
            var imageData = UIImagePNGRepresentation(self.imageViewPreview.image)
            var paseImageFile = PFFile(name: "uploaded_image.png", data : imageData)
            
            
            var save = PFObject(className: "Posts")
            save["imageFile"] = paseImageFile
            save["imageText"] = imageText
            save["uploader"] = PFUser.currentUser()
            save.saveInBackgroundWithBlock({ ( isSucessful: Bool, error : NSError?) -> Void in
               
                
                if error == nil {
                    
                    println("업로드 성공")
                    
                    //저장 성공했다고 표시창
                    self.performSegueWithIdentifier("uploadToHome", sender: self)
                    
                    
                }else { println(error)
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