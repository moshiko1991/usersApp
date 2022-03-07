//
//  UserCollectionViewCell.swift
//  usersApp
//
//  Created by moshiko elkalay on 26/02/2022.
//

import UIKit
import SDWebImage

class UserCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(with user: User){
        userImageView.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 150, height: 150))
        userImageView.sd_setImage(with: user.avatarURL)
        userImageView.layer.cornerRadius = 10
        userImageView.layer.borderWidth = 5
        userImageView.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        userNameLabel.text = user.first_name
        lastNameLabel.text = user.last_name
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "UserCollectionViewCell", bundle: nil)
    }
    
    
    
}
