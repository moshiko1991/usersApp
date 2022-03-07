//
//  UserInfoViewController.swift
//  usersApp
//
//  Created by moshiko elkalay on 28/02/2022.
//

import UIKit
import PKHUD

class UserInfoViewController: UIViewController {
    
  
    //conettion with outlets of the elements
    @IBOutlet weak var noteListOutlet: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userIDlabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    
    
    public var currentUser : User!
    
    var name : String!

    override func viewDidLoad() {
        super.viewDidLoad()

        //set values for outlets and design
        noteListOutlet.layer.cornerRadius = 10
        userImageView.sd_setImage(with: currentUser.avatarURL)
        userIDlabel.text = "ID: \(currentUser.id)"
        userNameLabel.text = currentUser.first_name
        userLastNameLabel.text = currentUser.last_name
        userEmailLabel.text = "Email: " + currentUser.email
        userGenderLabel.text = "Gender: " + currentUser.gender
        
    }
    
    
    

    //back for user list page
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        let usersCardVc = self.storyboard?.instantiateViewController(identifier: "userListStoryBoard") as! UserListViewController
        usersCardVc.modalPresentationStyle = .fullScreen
        self.present(usersCardVc, animated: true)
    }
    
    
    //move to note list page
    @IBAction func noteListButton(_ sender: Any) {
        let noteListVc = self.storyboard?.instantiateViewController(identifier: "noteListStoryBoard") as! NoteListViewController
        noteListVc.currentUser = currentUser
        noteListVc.modalPresentationStyle = .fullScreen
        self.present(noteListVc, animated: true)
    }
    

}
