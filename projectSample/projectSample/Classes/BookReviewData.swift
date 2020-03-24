//
//  BookReviewData.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-23.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class BookReviewData: NSObject {
    var id : Int?
    var userId: Int?
    var bookId : Int?
    var rating : Int?
    var review : String?
    var coverImage : String?
    
    func initWithValues(id i : Int, userID u : Int, bookId b : Int, rating r : Int, review re : String, coverImage c : String){
        id = i
        userId = u
        rating = r
        bookId = b
        review = re
        coverImage = c
    }
    
    
}
