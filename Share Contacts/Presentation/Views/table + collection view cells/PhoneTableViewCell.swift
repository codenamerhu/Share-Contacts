//
//  PhoneTableViewCell.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/08.
//

import UIKit

class PhoneTableViewCell: UITableViewCell {

    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
