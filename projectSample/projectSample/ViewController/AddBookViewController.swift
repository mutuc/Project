//
//  AddBookViewController.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-24.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var tfTitle: UITextField!
    @IBOutlet var tfAuthor: UITextField!
    @IBOutlet var tfPublisher: UITextField!
    @IBOutlet var tfGenre: UITextField!
    
    var imageStr : String!
    
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
//        let imageData:Data = image.pngData()!
//         imageStr = imageData.base64EncodedString()
        //to-do
        //find out how to upload to image folder
        //name of image = Image + counter + .png
        //counter++
        let newImage = UIImage.init(named: "myimage")
        
        
        let date :NSDate = NSDate()
        
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH_mm_ss"
        
        dateFormatter.timeZone = NSTimeZone(name: "GMT") as TimeZone?
        
        let imageName = "/\(dateFormatter.string(from: date as Date)).jpg"
        print(imageName)
        //var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)
        //var documentsDirectoryPath = getDocumentsURL().relativePath
        var documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        documentsDirectoryPath += imageName
        print(documentsDirectoryPath)
        
       // let settingsData: NSData = UIImageJPEGRepresentation(newImage!, 1.0)! as NSData
       imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func addBook(sender: Any)
    {
        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
        let counter = 1;
        let book : BookData = BookData.init()
        let imgData = "image"
       
        book.initWithValues(id: 0, title: tfTitle.text!, author: tfAuthor.text!, publisher: tfPublisher.text!, genre: tfGenre.text!, image: imgData)
      
        
        
        
        mainDelegate.insertDataToBook(title: tfTitle.text!, author: tfAuthor.text!, publisher: tfPublisher.text!, genre: tfGenre.text!, imga: imgData)
        
    
        var returnMSG : String = "Book Added"
    
        let alertController = UIAlertController(title: "SQLite Add", message: returnMSG, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
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
