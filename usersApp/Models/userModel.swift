//
//  userModel.swift
//  usersApp
//
//  Created by moshiko elkalay on 25/02/2022.
//

import Foundation


struct User {
    
    //mandatory properties
    let id: Int
    var first_name: String
    let last_name: String
    let email: String
    let gender: String
    private let avatar: String?
    
    
    
    var avatarURL : URL? {
        guard let avatar = self.avatar else {
            return nil
        }
        return URL(string: avatar)
    }
    
    
    
   
    init?(_ dictonary : [String:Any]) {
        guard let id = dictonary["id"] as? Int,
              let first_name = dictonary["first_name"] as? String,
              let last_name = dictonary["last_name"] as? String,
              let email = dictonary["email"] as? String,
              let gender = dictonary["gender"] as? String,
              let avatar = dictonary["avatar"] as? String
        else {
            return nil
        }
        
        self.first_name = first_name
        self.last_name = last_name
        self.avatar = avatar
        self.id = id
        self.email = email
        self.gender = gender
        
     }
    
}

