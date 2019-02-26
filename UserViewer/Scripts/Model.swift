//
//  Model.swift
//  UserViewer
//
//  Created by Sam Paterson on 10/02/19.
//  Copyright © 2019 Sam Paterson. All rights reserved.
//

import Foundation

struct User: Codable{
    let firstName: String
    let lastName: String
    let age: String
    let email: String
}

class Model{
    static let instance = Model()
    
    var users: [String: User] = [:]
    
    func addUser(fName: String, lName: String, age: String, email: String)-> Bool{
        if (users[fName+lName] != nil){
            //error already exists
            return false
        }
        users[fName+lName] = User(firstName: fName, lastName: lName, age: age, email: email)  //[fName, lName, age, email]
        if savetoJSON() == -1{
            print("-1 JSON Error-----")
        }
        return true //successful
    }
    
    func savetoJSON() -> Int{
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let usersArray = Array(users.values)
            let data = try encoder.encode(usersArray)
            
            //writing to file
            guard let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return -1}
            let fileUrl = docUrl.appendingPathComponent("Users.json")
            try data.write(to: fileUrl)
        } catch{
            print(error)
        }
        return 0
    }
    
    func loadUsersFromJSON(){
        
        guard let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = docUrl.appendingPathComponent("Users.json")
        
        do{
            let data = try Data(contentsOf: fileUrl)
            let usersArray = try JSONDecoder().decode([User].self, from: data)
            for user in usersArray{
                users[user.firstName+user.lastName] = user
            }
        }catch{
            print(error)
        }
        
    }
    
}
