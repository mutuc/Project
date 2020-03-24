//
//  UsersData.swift
//  projectSample
//
//  Created by Miguel Ramos González on 2020-03-23.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit

class UsersData: NSObject {
    var id : Int?
    var username : String?
    var password : String?
    
    func initWithVar(id d : Int,user u : String, pass p : String){
        id = d
        username = u
        password = p
    }
}
