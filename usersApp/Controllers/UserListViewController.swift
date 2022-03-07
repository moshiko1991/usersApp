//
//  UserListViewController.swift
//  usersApp
//
//  Created by moshiko elkalay on 24/02/2022.
//

import UIKit
import FirebaseAuth
import PKHUD

class UserListViewController: UIViewController {
    
    //conettion with outlets of the elements
    @IBOutlet weak var usersCollectionView: UICollectionView!
    
    //make noew array for this controller
    var userTableArray : [User] = []
    
    //make a network methot as a let
    let networking = Networking()

   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call to methots
        loadData()
        collectionViewCofifg()
        
        
    }
    
    
    
    //style and configuration for collectionView
    func collectionViewCofifg(){
        let layout = UICollectionViewFlowLayout()
        let itemWidth = usersCollectionView.bounds.width - 100
        let itemHeight = usersCollectionView.bounds.height - 300
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        usersCollectionView.collectionViewLayout = layout
        usersCollectionView.register(UserCollectionViewCell.nib(), forCellWithReuseIdentifier: "UserCollectionViewCell")
        usersCollectionView.delegate = self
        usersCollectionView.dataSource = self
    }
    
    
    //get the data and load on collectionView the of the users from API and json
    private func loadData(){
        //show progress
        HUD.show(.progress)
        //fetch data from service
        networking.requestJson { [weak self](result) in
            guard let self = self else {
                return
            }
            
            self.usersCollectionView.reloadData()

            //remove progress
            HUD.hide(animated: true)

            //handle result
            switch result {
            case .failure(let error):
                HUD.flash(.labeledError(title: error.localizedDescription, subtitle: nil), delay: 3)
                print("Error JSON \(error.localizedDescription)")
            case .success(let users):
                self.userTableArray = users
                self.usersCollectionView.reloadData()
                
            }
        }
    }

    
    //butoon to log of the user from firebase and back to login page
    @IBAction func logoutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let mainVc = self.storyboard?.instantiateViewController(identifier: "mainStoryboard") as! ViewController
            mainVc.modalPresentationStyle = .fullScreen
            self.present(mainVc, animated: true)
        } catch {
            print("Error logout")
        }
    }
    
    
    
    
}

extension UserListViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    //delegate method
    
    //when the user tap on the selected item from the collectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //set the values to next viewController and show him
        collectionView.deselectItem(at: indexPath, animated: true)
        let userInfoVc = self.storyboard?.instantiateViewController(identifier: "userInfoStoryBoard") as! UserInfoViewController
        userInfoVc.currentUser = userTableArray[indexPath.item]
        userInfoVc.modalPresentationStyle = .fullScreen
        self.present(userInfoVc, animated: true)
        }
    
    
   
    
    //datasource method
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userTableArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        
        //configur and design of collectionViewCell
        cell.configure(with: userTableArray[indexPath.item])
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        return cell
        }

    }
    
    
    

   
    
   
    


