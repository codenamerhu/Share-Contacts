//
//  ContactDetailViewController.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/07.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var backButton       : UIButton!
    @IBOutlet weak var editButton       : UIButton!
    @IBOutlet weak var contactName      : UILabel!
    @IBOutlet weak var contactImage     : UIImageView!
    @IBOutlet weak var tableView        : UITableView!
    
    static let identifier = "ContactDetailViewController"
    var contact: MyContact? {
        didSet { }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        inserData()
        tableView.delegate = self
        tableView.dataSource = self
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

extension ContactDetailViewController : UITableViewDelegate { }

extension ContactDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "phone") as! PhoneTableViewCell
        if let mobile = contact?.cellPhone {
            
            cell.phoneNumber.text = mobile
            return cell
        }
        
        if let mobile = contact?.tellephone {
            
            cell.phoneNumber.text = mobile
            return cell
        }
        
        if let mobile = contact?.homePhone {
            
            cell.phoneNumber.text = mobile
            return cell
        }
        
        if let mobile = contact?.workPhone {
            
            cell.phoneNumber.text = mobile
            return cell
        }
        
        if let mobile = contact?.otherPhone {
            
            cell.phoneNumber.text = mobile
            return cell
        }
        
        return cell
    }
    
    
}
