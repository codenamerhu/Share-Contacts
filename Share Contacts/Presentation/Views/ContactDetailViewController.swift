//
//  ContactDetailViewController.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/07.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactImage : UIImageView!
    
    static let identifier = "ContactDetailViewController"
    var contact: MyContact? {
        didSet { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        inserData()
        //self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func back(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func inserData() {
        contactName.text = contact?.firstName
        
        if let image = contact?.contactImage {
            contactImage.image = UIImage(data: image)
        } else {
            contactImage.load(url: URL(string: "https://picsum.photos/200")!)
        }
    }
    
    func configureUI(){
        contactImage.layer.cornerRadius = 25
        contactImage.clipsToBounds = true
    }

}
