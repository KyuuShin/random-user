//
//  RandomUserCell.swift
//  RandomUser
//
//  Created by Keuahn Lumanog on 1/3/19.
//  Copyright © 2019 Keuahn Lumanog. All rights reserved.
//

import UIKit

class RandomUserCell: UITableViewCell {

    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    func configureCell(firstName: String, lastName: String, email: String, pictureUrl: String) {
        nameLabel.text = firstName + " " + lastName
        emailLabel.text = email
        if let url = URL(string: pictureUrl) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.userPhotoImageView.image = UIImage(data: data!)
                }
            }
        }
    }

}
