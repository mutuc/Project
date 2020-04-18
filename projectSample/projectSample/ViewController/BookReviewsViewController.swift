//
//  BookReviewsViewController.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-24.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class BookReviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.bookReviewSelected.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.getUserName(id: mainDelegate.bookReviewSelected[rowNum].userId!) ?? "N/A"
        
        tableCell.secondaryLabel.text = "Score: " + String(mainDelegate.bookReviewSelected[rowNum].rating!)
        let img = UIImage(named: "userIcon")
        tableCell.myImageView.image = img
        tableCell.myImageView.contentMode = .scaleAspectFit
        
 
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNum = indexPath.row
        
        if(mainDelegate.currentUsers?.id == mainDelegate.bookReviewSelected[rowNum].userId)
        {
            mainDelegate.reviewSelected = mainDelegate.bookReviewSelected[rowNum]
            performSegue(withIdentifier: "bookReviewToEditReview", sender: nil)

        } else {
            performSegue(withIdentifier: "BookReviewToViewReview", sender: nil)
        }
    }
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        mainDelegate.getBookReviews(bookSelectedID: mainDelegate.bookSelected!.id!)

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var tableControl:UITableView!
    
    
    
    @IBAction func unwindToBookReview(sender: UIStoryboardSegue){
     mainDelegate.getBookReviews(bookSelectedID: mainDelegate.bookSelected!.id!)
        tableControl.reloadData()
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
