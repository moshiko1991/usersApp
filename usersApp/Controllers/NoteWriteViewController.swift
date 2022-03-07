//
//  NoteWriteViewController.swift
//  usersApp
//
//  Created by moshiko elkalay on 02/03/2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class NoteWriteViewController: UIViewController {
    
    let manager = NoteManager()
    
    public var currentUser : User!
    
    
    @IBOutlet weak var noteTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func writeButton(_ sender: UIButton) {
        NoteManager.noteDatabaseReference.setValue("moshiko")
    }
    
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        let userInfoVc = self.storyboard?.instantiateViewController(identifier: "userInfoStoryBoard") as! UserInfoViewController
        userInfoVc.currentUser = currentUser
        userInfoVc.modalPresentationStyle = .fullScreen
        present(userInfoVc, animated: true)
    }
    
    

}
