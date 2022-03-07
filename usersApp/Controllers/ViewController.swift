//
//  ViewController.swift
//  usersApp
//
//  Created by moshiko elkalay on 24/02/2022.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    //conettion with outlets of the elements
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var registerButtonOutlet: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //buttons design
        loginButtonOutlet.layer.cornerRadius = 10
        registerButtonOutlet.layer.cornerRadius = 10
        
        //TextFields configuration and design
        emailTextField.becomeFirstResponder()
        emailTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
    
    
        //call the method USERLOGIN() to check if there is a user connected
        userLogin()
        
        
        
        
    }
    
    //Firebase test that checks an existing user connection
    func userLogin(){
        if FirebaseAuth.Auth.auth().currentUser != nil {
            DispatchQueue.main.async {
                self.usersCardVc()
            }
        } else {
            print("No user login")
        }
    }
    
    //move to the next page as long the user is connected
    func usersCardVc(){
        let usersCardVc = self.storyboard?.instantiateViewController(identifier: "userListStoryBoard") as? UserListViewController
        self.view.window?.rootViewController = usersCardVc
    }
    
    
    
    //Move to register page
    @IBAction func registerButton(_ sender: UIButton) {
        let registerVc = self.storyboard?.instantiateViewController(identifier: "registerStoryBoard") as! RegisterViewController
        registerVc.modalPresentationStyle = .fullScreen
        self.present(registerVc, animated: true)
    }
    
    
    //options and test after pressing the login button
    @IBAction func loginButton(_ sender: UIButton){
        guard let email = emailTextField.text, email.isValidEmail else {
            let alert = UIAlertController(title: "", message: "Email is not valid or empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
            present(alert, animated: true)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
              let alert = UIAlertController(title: "", message: "Password is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
            present(alert, animated: true)
            return
        }
        
        //if all parameters are correct User Login
        Auth.auth().signIn(withEmail: email, password: password, completion: { rasult, error in
            guard error == nil else {
                //Register alert
                
                //worng password alert
                let alert = UIAlertController(title: "", message: "password is invalid or the user does not have a password", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
                  self.present(alert, animated: true)
                
                return
            }
            print("User signd in")
            
            self.usersCardVc()
        })
        
    }
}

