//
//  InfoUserTableViewCell.swift
//  testBalinaSoft
//
//  Created by Ilya Lagutovsky on 2/18/20.
//  Copyright © 2020 Ilya Lagutovsky. All rights reserved.
//

import UIKit

protocol InfoCellContentViewModel {
    var userId: String { get }
    var userName: String { get }
}

class InfoUserTableViewCell: UITableViewCell {

    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(userInformation: InfoCellContentViewModel) {
        userIdLabel.text = userInformation.userId
        userNameLabel.text = userInformation.userName
    }

}
