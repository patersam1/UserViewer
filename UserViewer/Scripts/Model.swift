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
        if savetoJSON() == -1{
            print("-1 JSON Error-----")
        }
        return true //successful
    }
    
    func savetoJSON() -> Int{
        var topLevelDict: [String: Any] = [:]
        for (key, value) in userDic{
            var user: [String : String] = [:]
            user["fName"] = value[0]
            user["lName"] = value[1]
            user["age"] =  value[2]
            user["email"] = value[3]
            topLevelDict[key] = user
            
        }
//        print(topLevelDict)
        //creates the json data
        guard let jsonData = try? JSONSerialization.data(withJSONObject: topLevelDict, options: .prettyPrinted) else{
            return -1
        }
        
        
        guard let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return -1}
        let fileUrl = docUrl.appendingPathComponent("Users.json")
        print("Write url \(fileUrl)")
        do{
            try jsonData.write(to: fileUrl, options: [])
        }catch{
            print("error writing data to disk \(error)")
            return -1
        }
        
        print("write success")
        return 0
    }
    
    func loadUsersFromJSON(){
        
//        guard let path = Bundle.main.path(forResource: "Users", ofType: "json") else { print("error with path"); return }
        guard let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {print("error with path"); return}
        let path = docUrl.appendingPathComponent("Users.json")
        print("Load url: \(path)")
        guard let data = try? Data(contentsOf: path) else { print("error with data"); return }
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { print("error with json"); return }
        
        if let jsonDic = json as? [String: [String: String]]{
            for (key, value) in jsonDic{
                
                guard let fName = value["fName"],
                    let lName = value["fName"],
                    let age = value["age"],
                    let email = value["email"]
                else {
                    print("error extecting data")
                    continue
                }
                
                var userArray = [fName, lName, age, email]
                userDic[key] = userArray
            }
        }
        
    }
    
}
