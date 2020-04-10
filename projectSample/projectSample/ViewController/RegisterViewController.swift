//
//  RegisterViewController.swift
//  projectSample
//
//  Created by Kevin Mutuc on 2020-04-10.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var tfUsername : UITextField!
    @IBOutlet var tfPassword : UITextField!

    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func registerUser(sender: Any)
    {
        let returnCode = mainDelegate.insertDataToUser(username: tfUsername.text!, password: tfPassword.text!)
       
        var returnMSG : String = ""
        
        if returnCode == false {
            
            returnMSG = "User has failed to register try again."
            
        } else {
            
            returnMSG = "User has been registered return to login page to access app."
            
        }
        
        
        let alertController = UIAlertController(title: "Registration", message: returnMSG, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
        
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    


}
