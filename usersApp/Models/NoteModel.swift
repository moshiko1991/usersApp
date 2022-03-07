//
//  NoteModel.swift
//  usersApp
//
//  Created by moshiko elkalay on 03/03/2022.
//

import Foundation

struct Note {
    let from : String
    let note_id : String
    let note_content : String
    
    init?(_ dictonary : [String:Any]) {
        guard let from = dictonary["from"] as? String,
              let note_id = dictonary["note_id"] as? String,
              let note_content = dictonary["note_content"] as? String
              
        else {
            return nil
        }
        
        self.from = from
        self.note_id = note_id
        self.note_content = note_content
        
        
     }
}
