//
//  NoteManager.swift
//  usersApp
//
//  Created by moshiko elkalay on 03/03/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth


class NoteManager {
    
    static let noteDatabaseReference : DatabaseReference = {
        return Database.database().reference().child("Notes")
    }()
    
    
    
    
}
