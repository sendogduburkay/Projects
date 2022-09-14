//
//  HomeTableViewCell.swift
//  HomeWork
//
//  Created by Muhammed Burkay Şendoğdu on 11.09.2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = String(describing: HomeTableViewCell.self)
    // MARK: - UI Properties
    @IBOutlet var genderImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var surnameLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeTableViewCell{
    
    func setupCell(user: User){
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        phoneLabel.text = user.phoneNumber
        genderImageView.image = user.gender == .Male ? UIImage(named: "Male") : UIImage(named: "Female")
    }
}
