//
//  ContactCollectionViewCell.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/07.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    
    static let identifier = "ContactCollectionViewCell"
    
    var contacts: MyContact? {
        didSet {
            contactName.text = contacts?.firstName
            
            if let thumbail = contacts?.contactThumbnail {
                contactImage.image = UIImage(data: thumbail)
            } else {
                contactImage.load(url: URL(string: "https://picsum.photos/200")!)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        contactImage.layer.cornerRadius = 25
        contactImage.clipsToBounds = true
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
