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
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //contactImage.layer.cornerRadius = 25
        contactImage.roundedImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        contactImage.image = UIImage(named: "no image")
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


extension UIImageView {

    func roundedImage() {

        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
