//
//  BookData.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-23.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class BookData: NSObject {
    var id : Int?
    var title: String?
    var author : String?
    var publisher: String?
    var genre: String?
    var image: String?
    
    func initWithValues(id i : Int, title t : String, author a : String, publisher p: String, genre g : String, image im : String){
        id = i
        title = t
        author = a
        publisher = p
        genre = g
        image = im
    }
    
    
}
