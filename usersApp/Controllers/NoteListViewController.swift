//
//  NoteListViewController.swift
//  usersApp
//
//  Created by moshiko elkalay on 02/03/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class NoteListViewController: UIViewController {
    
    //make new array of Note for current controller
    var notesTableArray : [Note] = []
    
    //database reference
    private let noteDatabaseReference = Database.database().reference().child("Notes")
    
    //conettion with outlets of the elements
    @IBOutlet weak var notesTableView: UITableView!
    
    public var email = ""
    
    
    public var currentUser : User!
    let fromEmail : String! = Auth.auth().currentUser?.email

    override func viewDidLoad() {
        super.viewDidLoad()
      
        notesTableView.delegate = self
        notesTableView.dataSource = self
        listenTodata()
        
    }
    
    //get data of notes from firebase
    func listenTodata(){
        getAllNotes { [weak self](notes) in
            guard let self = self else { return }
            self.notesTableArray = notes
            self.notesTableView.reloadData()
        }
    }
    

    //back to user info viewController
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        let userInfoVc = self.storyboard?.instantiateViewController(identifier: "userInfoStoryBoard") as! UserInfoViewController
        userInfoVc.currentUser = currentUser
        userInfoVc.modalPresentationStyle = .fullScreen
        present(userInfoVc, animated: true)
    }
    
    
    //add new note for the currner user
    @IBAction func newNoteButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add note", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (_) in
           
            if alert.textFields?[0].text != "" {
                let uuid = UUID().uuidString
                let noteObject : [String : Any] = [
                    "from" : self.fromEmail!,
                    "note_id" : uuid,
                    "note_content" : alert.textFields?[0].text]

                let userIdInt = self.currentUser.id
                let userIdSringValue = userIdInt as NSNumber
                let userId = userIdSringValue.stringValue
                self.noteDatabaseReference.child(userId).child(uuid).setValue(noteObject)
                self.listenTodata()
            } else {
                let errorAlert = UIAlertController(title: "Empty note", message: "Please try agin", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(errorAlert, animated: true)
            }
        }))
        present(alert, animated: true)
    }
    
    
    //get all the notes data array of json
    func getAllNotes(with complition : @escaping ([Note]) -> Void){
        let userIdInt = currentUser.id
        let userIdSringValue = userIdInt as NSNumber
        let userId = userIdSringValue.stringValue
        noteDatabaseReference.child(userId).observeSingleEvent(of: .value) { (snapshot) in
            guard let json = snapshot.value as? [String : Any] else {
                complition([])
                return
            }
            
            let result = Array(json.values).compactMap{ $0 as? [String : Any] }.compactMap{ Note( $0 ) }
            complition(result)
        }
    }
}

extension NoteListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
       
            return notesTableArray.count
        
        
        
    }

    //set data in the table array of notes withe taableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let noteEmail = notesTableArray[indexPath.row].from
            let noteContent = notesTableArray[indexPath.row].note_content
            cell.textLabel?.text = "From: " + noteEmail
            cell.detailTextLabel?.text = "Content: " + noteContent
            email = noteEmail
        return cell
        
    }

    //options whene the user tap on cell edit/delete/cancel
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: "Note from: \(email)", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Edit Note", style: .default, handler: { (_) in
            
            let editAlert = UIAlertController(title: "Edit Note", message: "Write Somthing", preferredStyle: .alert)
            editAlert.addTextField()
            
            editAlert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
                if editAlert.textFields?[0].text == "" {
                    let emptyAlert = UIAlertController(title: "Empty note", message: "Try agin", preferredStyle: .alert)
                    emptyAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    self.present(emptyAlert, animated: true)
                } else {
                    let userIdInt = self.currentUser.id
                    let userIdSringValue = userIdInt as NSNumber
                    let userId = userIdSringValue.stringValue
                    self.noteDatabaseReference.child(userId).child(self.notesTableArray[indexPath.row].note_id).child("note_content").setValue(editAlert.textFields![0].text)
                }
                
            }))
            self.present(editAlert, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Delete Note", style: .default, handler: { (_) in
            let userIdInt = self.currentUser.id
            let userIdSringValue = userIdInt as NSNumber
            let userId = userIdSringValue.stringValue
            self.noteDatabaseReference.child(userId).child(self.notesTableArray[indexPath.row].note_id).removeValue()
            self.listenTodata()
        }))
        present(alert, animated: true)
        }

}

