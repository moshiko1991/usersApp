//
//  RegisterViewController.swift
//  usersApp
//
//  Created by moshiko elkalay on 25/02/2022.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    
    //conettion with outlets of the elements
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confimPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //login button design
        registerButton.layer.cornerRadius = 10
        
        //TextFields configuration and design
        emailTextField.becomeFirstResponder()
        emailTextField.layer.cornerRadius = 5
        passwordTextField.layer.cornerRadius = 5
        confimPasswordTextField.layer.cornerRadius = 5
    }
    
    //move to the next page after regiser
    func usersCardVc(){
        let usersCardVc = self.storyboard?.instantiateViewController(identifier: "userListStoryBoard") as! UserListViewController
        usersCardVc.modalPresentationStyle = .fullScreen
        self.present(usersCardVc, animated: true)
    }
    
    
    
    //options and test after pressing the register button
    @IBAction func registerButton(_ sender: UIButton) {
        guard let email = emailTextField.text, email.isValidEmail else {
            let alert = UIAlertController(title: "", message: "Email is not valid or empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
            present(alert, animated: true)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confimPasswordTextField.text, !confirmPassword.isEmpty else {
            let alert = UIAlertController(title: "", message: "Somthing is missin", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
            
            present(alert, animated: true)
            return
            
        }
        
        if passwordTextField.text != confimPasswordTextField.text {
            let alert = UIAlertController(title: "", message: "Passwords are not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in}))
            
            present(alert, animated: true)
        } else {
        
        //if all parameters are correct User Register and Login
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Failed withe error \(error)")
                return
            } else {
                print("Registeration is complete")
                self.usersCardVc()
                }
            }
        }
    }
    
    
    //button for cancel option
    @IBAction func cancelButton(_ sender: UIButton) {
        let viewController = self.storyboard?.instantiateViewController(identifier: "mainStoryboard") as! ViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    

}
