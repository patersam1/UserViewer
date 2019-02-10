//
//  Model.swift
//  UserViewer
//
//  Created by Sam Paterson on 10/02/19.
//  Copyright © 2019 Sam Paterson. All rights reserved.
//

import Foundation

class Model{
    static let instance = Model()
    
    var userDic: [String : [String]] = [:]
    
    func addUser(fName: String, lName: String, age: String, email: String)-> Bool{
        if (userDic[fName+lName] != nil){
            //error already exists
            return false
        }
        userDic[fName+lName] = [fName, lName, age, email]
        
        return true //successful
    }
    
}
