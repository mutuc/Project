//
//  YourReviewViewController.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-24.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class YourReviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var tfReview: UITextView!
    @IBOutlet var slRate: UISlider!
    @IBOutlet var lbrate:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseImage(_sender: Any)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction)in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            else
            {
                print("Camera not available")
            }
        } ))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction)in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
        
    @IBAction func addReview(sender: Any)
    {
       let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        
     //   let rate = slRate.value
      //  let strVol = String(format: "%.2f", vol)
        
//        let book : BookData = mainDelegate.books[1];
//        let user : UsersData = UsersData.init()
//        let review : BookReviewData = BookReviewData.init()
         let imgData = imageView.debugDescription
        
//        mainDelegate.bookReviews.in(id: 0, userID: UsersData.id!, bookId: BookData.id!, rating: Int(slRate.value), review: tfReview.text!, coverImage: imgData)
        
        mainDelegate.insertDataToBookReview(userId: mainDelegate.currentUsers!.id!, bookId: mainDelegate.bookSelected!.id!, rating: Int(slRate.value), review: tfReview.text!, coverImg: imgData)
        
        
        var returnMSG : String = "Review Added"
        
        let alertController = UIAlertController(title: "SQLite Add", message: returnMSG, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }
    
    @IBAction func sliderValueChange(sender : UISlider)
    {
          let rate = slRate.value
         let strRate = String(rate)
        lbrate.text = strRate
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
