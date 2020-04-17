//
//  AppDelegate.swift
//  projectSample
//
//  Created by Xcode User on 2020-02-28.
//  Copyright © 2020 kmutuc. All rights reserved.
//

import UIKit
import SQLite3

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var databaseName : String? = "rateBook.db"
    var databasePath : String?
    var books : [BookData] = []
    var users : [UsersData] = []
    var currentUsers : UsersData?
    var bookSelected : BookData?
    var bookReviewSelected : [BookReviewData] = [] //for  batch of reviews for specific book
    var reviewSelected : BookReviewData? //When user selects particualr review
    var bookReviews : [BookReviewData] = []

    var window: UIWindow?

    func getBookReviews(bookSelectedID bs : Int){
        readDataBookReview()
        bookReviewSelected.removeAll()
        for user in bookReviews{
            if(user.bookId == bs){
                bookReviewSelected.append(user)
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDir = documentPaths[0]
        databasePath = documentsDir.appending("/" + databaseName!)
        checkAndCreateDatbase()
        return true
    }
    
    //Creates the database
    func checkAndCreateDatbase(){
        print("Database created")
        var success = false
        let fileManager = FileManager.default
        
        success = fileManager.fileExists(atPath: databasePath!)
        if success {
            return
        }
        
        let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
        
        try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
    }
    
    //adds book inot the database
    func insertDataToBook( title t : String, author a : String, publisher p : String, genre g : String, imga im : String){
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            var insertStatement: OpaquePointer?
            let insertStatementString = "insert into books values(NULL, '\(t)', '\(a)','\(p)','\(g)','\(im)');"
            
            // 1
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
                SQLITE_OK {
                
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    
                    print("\nSuccessfully inserted row.")
                    print()
                } else {
                    print("\nCould not insert row.")
                }
            } else {
                print("\nINSERT statement is not prepared.")
            }
            // 5
            sqlite3_finalize(insertStatement)
        }
        sqlite3_close(db)
    }
    
    //updates list of book
    func readDataFromBook(){
        books.removeAll()
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            
            
            var queryStatement : OpaquePointer? = nil
            let queryStatementString : String = "Select * from books"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let ctitle = sqlite3_column_text(queryStatement, 1)
                    let cauthor = sqlite3_column_text(queryStatement, 2)
                    let cpublisher = sqlite3_column_text(queryStatement, 3)
                    let cgenre = sqlite3_column_text(queryStatement, 4)
                    let cimage = sqlite3_column_text(queryStatement, 5)

                    let title = String(cString: ctitle!)
                    let author = String(cString: cauthor!)
                    let publisher = String(cString: cpublisher!)
                    let genre = String(cString: cgenre!)
                    let img = String(cString: cimage!)
                    
                    let data : BookData = BookData.init()
                    data.initWithValues(id: id, title: title, author: author, publisher: publisher, genre: genre, image: img)
                    books.append(data)
                   
                    
                  //  print(img)
//                    print(title)
//                    print(author)
//                    print(publisher)
//                    print(genre)
                }
                
                sqlite3_finalize(queryStatement)
                
                
                
            } else {
                print("Select statment could not be prepared")
            }
            
            sqlite3_close(db)
        }
    }
    
    //Upteds list of book review
    func readDataBookReview(){
        bookReviews.removeAll()
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            
            
            var queryStatement : OpaquePointer? = nil
            let queryStatementString : String = "select * from bookReview;"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let userId: Int = Int(sqlite3_column_int(queryStatement, 1))
                    let bookId : Int = Int(sqlite3_column_int(queryStatement, 2))
                    let rating: Int = Int(sqlite3_column_int(queryStatement, 3))
                    let creview = sqlite3_column_text(queryStatement, 4)
                    let cimage = sqlite3_column_text(queryStatement, 5)
                    
                    
                    let review = String(cString: creview!)
                    let img = String(cString: cimage!)
                    
                    let data : BookReviewData = BookReviewData.init()
                    data.initWithValues(id: id, userID: userId, bookId: bookId, rating: rating, review: review, coverImage: img)
                    bookReviews.append(data)
                    
                }
                
                sqlite3_finalize(queryStatement)
                
            } else {
                print("Select statment could not be prepared")
            }
            
            sqlite3_close(db)
        }
    }
    
    //Adds a book review into the database
    func insertDataToBookReview( userId u: Int, bookId b: Int, rating r: Int, review rev: String, coverImg aI : String){
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            var insertStatement: OpaquePointer?
            let insertStatementString = "insert into bookReview values(null, ?,?,?,'\(rev)', '\(aI)');"
            
            // 1
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
                SQLITE_OK {
                sqlite3_bind_int(insertStatement, 1, Int32(u))
                sqlite3_bind_int(insertStatement, 2, Int32(b))
                sqlite3_bind_int(insertStatement, 3, Int32(r))
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    
                    print("\nSuccessfully inserted row.")
                } else {
                    print("\nCould not insert row.")
                }
            } else {
                print("\nINSERT statement is not prepared.")
            }
            // 5
            sqlite3_finalize(insertStatement)
        }
        sqlite3_close(db)
    }
    
    //Adds user to the database
    func insertDataToUser( username u : String, password p : String) -> Bool{
        var db : OpaquePointer? = nil
        var returnCode : Bool = true
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            var insertStatement: OpaquePointer?
            let insertStatementString = "insert into users values(NULL, '\(u)','\(p)');"
            
            // 1
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
                SQLITE_OK {
                
                
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    
                    print("\nSuccessfully inserted row.")
                } else {
                    print("\nCould not insert row.")
                    returnCode = false
                }
            } else {
                print("\nINSERT statement is not prepared.")
                returnCode = false
            }
            // 5
            sqlite3_finalize(insertStatement)
        }
        sqlite3_close(db)
        return returnCode
    }
    
    func getUserName(id i :Int) -> String?{
        readDataFromUser()
        for user in users {
            if(user.id == i){
                return user.username;
            }
        }
        
        return nil
        
    }
    
    func userIsAuthenitcated(username us : String, password pass : String) -> Bool {
        readDataFromUser()
        for user in users {
            if(user.password == pass && user.username == us){
                currentUsers = user
                return true;
            }
        }
        
        return false
        
    }
    
    //Retruns the user if it is authenticated or nil if the user does not exist
    func readDataFromUser()  {
        users.removeAll()
        var db : OpaquePointer? = nil
        
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(String(describing: self.databasePath))")
            
            
            var queryStatement : OpaquePointer? = nil
            let queryStatementString : String = "select * from users;"
            
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK{
                
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id : Int = Int(sqlite3_column_int(queryStatement, 0))
                    let cusername = sqlite3_column_text(queryStatement, 1)
                    let cpassword = sqlite3_column_text(queryStatement, 2)
                    
                    
                    let usrname = String(cString: cusername!)
                    let password = String(cString: cpassword!)
                    
                    let data : UsersData = UsersData.init()
                    data.initWithVar(id: id, user: usrname, pass: password)
                    users.append(data)
                    
                }
                
                sqlite3_finalize(queryStatement)
                
            } else {
                print("Select statment could not be prepared")
            }
            
            sqlite3_close(db)
        }
        
        
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

