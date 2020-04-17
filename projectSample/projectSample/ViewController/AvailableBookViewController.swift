//
//  AvailableBookViewController.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-24.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class AvailableBookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDelegate.books.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        
        tableCell.primaryLabel.text = mainDelegate.books[rowNum].title
        tableCell.secondaryLabel.text = mainDelegate.books[rowNum].author
        let img = UIImage(named: mainDelegate.books[rowNum].image!) ?? UIImage(named: "none")
        tableCell.myImageView.image = img
        tableCell.myImageView.contentMode = .scaleAspectFit

        
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowNum = indexPath.row
        mainDelegate.bookSelected = mainDelegate.books[rowNum]
        
        performSegue(withIdentifier: "availableBookToBookInfo", sender: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        mainDelegate.readDataFromBook()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToAvailableBook(sender: UIStoryboardSegue){
     viewDidLoad()
        
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
