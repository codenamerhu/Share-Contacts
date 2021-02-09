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
    
    var phonenumbers = [String]()
    var count = 0
    
    static let identifier = "ContactDetailViewController"
    var contact: MyContact? {
        didSet { }
    }
    var contactsViewModel   = ContactsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNumberOfPhones()

        configureUI()
        inserData()
        tableView.delegate = self
        tableView.dataSource = self
        print("count is \(count)")
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
    
    @IBAction func ahare(_ sender: UIButton ){
        let shareVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: QRCodeShareViewController.identifier) as! QRCodeShareViewController
        
        print("img \(contactsViewModel.qRCodeImage(params: "data=contacts&name=rhu&size=100x100"))")
        shareVC.contact = contact
        self.navigationController?.pushViewController(shareVC, animated: true)
    }
    
    func inserData() {
        var fullname = ""
        if let firstbame = contact?.firstName {
            fullname = firstbame
        }
        
        if let lastname = contact?.lastName {
            fullname.append(" \(lastname)")
            
        }
        contactName.text = fullname
        
        if let image = contact?.contactImage {
            contactImage.image = UIImage(data: image)
        }
    }
    
    func configureUI(){
        contactImage.layer.cornerRadius = 25
        contactImage.clipsToBounds = true
    }
    
    func getNumberOfPhones() {
        if (contact?.cellPhone) != nil {
            count = count + 1
        }
        
        if (contact?.tellephone) != nil {
            count = count + 1
        }
        
        if (contact?.homePhone) != nil {
            count = count + 1
        }
        
        if (contact?.workPhone) != nil {
            count = count + 1
        }
        
        if (contact?.otherPhone) != nil {
            count = count + 1
        }
    }

}

extension ContactDetailViewController : UITableViewDelegate { }

extension ContactDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("on count table \(count)")
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "phone") as! PhoneTableViewCell
        if let mobile = contact?.cellPhone {
            
            cell.phoneLabel.text = "Mobile"
            cell.phoneNumber.text = mobile
            return cell
        }
        
        if let mobile = contact?.tellephone {
            
            cell.phoneLabel.text = "Telephone"
            cell.phoneNumber.text = mobile
            return cell
        }
        
        if let mobile = contact?.homePhone {
            
            cell.phoneLabel.text = "Home"
            cell.phoneNumber.text = mobile
            return cell
        }
        
        if let mobile = contact?.workPhone {
            
            cell.phoneLabel.text = "Work"
            cell.phoneNumber.text = mobile
            return cell
        }
        
        if let mobile = contact?.otherPhone {
            
            cell.phoneLabel.text = "Other"
            cell.phoneNumber.text = mobile
            return cell
        }
        
        return cell
    }
    
    
}
