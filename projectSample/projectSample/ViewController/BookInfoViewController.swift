//
//  BookInfoViewController.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-24.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class BookInfoViewController: UIViewController {
    @IBOutlet var titleLbl : UILabel!
    @IBOutlet var authorlbl : UILabel!
    @IBOutlet var publisherlbl : UILabel!
    @IBOutlet var genrelbl
    : UILabel!
    @IBOutlet var img : UIImageView!
    
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        let bookSelected = mainDelegate.bookSelected
        
        titleLbl.text = bookSelected?.title
        authorlbl.text = bookSelected?.author
        publisherlbl.text = bookSelected?.publisher
        genrelbl.text = bookSelected?.genre
        
        let bookImg = bookSelected?.image
        
        
        img.image = UIImage(named: bookImg!) ?? UIImage(named: "none")
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToBookInfo(sender: UIStoryboardSegue){
        
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
