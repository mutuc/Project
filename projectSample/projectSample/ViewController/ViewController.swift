//
//  ViewController.swift
//  projectSample
//
//  Created by Xcode User on 2020-02-28.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Hello World!!!!
    }
    
    @IBAction func loginOnClick(){
        mainDelegate.readDataFromUser()
        print(mainDelegate.userIsAuthenitcated(username: "miguel", password: "password1"))
    }


}

