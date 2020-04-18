//
//  EditReviewViewController.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-24.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class EditReviewViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var tfReview: UITextView!
    @IBOutlet var slRate: UISlider!
    @IBOutlet var lbrate:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainDelegate = UIApplication.shared.delegate as! AppDelegate
   
        
         tfReview.text = mainDelegate.reviewSelected?.review
        // Do any additional setup after loading the view.
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
