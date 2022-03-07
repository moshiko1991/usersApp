//
//  NoteViewController.swift
//  usersApp
//
//  Created by moshiko elkalay on 05/03/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class NoteViewController: UIViewController {
    
    public var note : Note!
    
    //database reference
    private let noteDatabaseReference = Database.database().reference().child("Notes")

    @IBOutlet weak var saveOutlet: UIButton!
    
    @IBOutlet weak var titleOutlet: UINavigationItem!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleOutlet.title = note.from
        noteTextView.text = note.note_content
        saveOutlet.layer.cornerRadius = 10
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
    }
}
