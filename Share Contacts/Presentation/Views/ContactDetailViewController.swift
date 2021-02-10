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
    
    @IBOutlet weak var buttonTackView: UIStackView!
    
    var phonenumbers = [String]()
    var count = 0
    
    static let identifier = "ContactDetailViewController"
    var contact: MyContact? {
        didSet { }
    }
    var contactsViewModel   = ContactsViewModel()
    
    var sectionCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getNumberOfPhones()

        configureUI()
        inserData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
        
        buttonTackView.layer.cornerRadius = 10
        buttonTackView.clipsToBounds = true
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
        
        if (contact?.mainPhone) != nil {
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
        
        
        print("contact is \(contact!)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "phone") as! PhoneTableViewCell
        
        if indexPath.section == sectionCount {
            if let mobile = contact?.cellPhone {
                
                
                    print("sections \(indexPath.section) count \(sectionCount)")
                    cell.phoneLabel.text = "Mobile"
                    cell.phoneNumber.text = mobile
                    sectionCount = sectionCount + 1
                    
                }
            return cell
        }
        
        if indexPath.section == sectionCount {
            if let telephone = contact?.tellephone {
                
                    print("sections \(indexPath.section) count \(sectionCount)")
                    cell.phoneLabel.text = "Telephone"
                    cell.phoneNumber.text = telephone
                    sectionCount = sectionCount + 1
                    
            }
            return cell
        }
        
        if indexPath.section == sectionCount {
            if let homephone = contact?.homePhone {
            
                print("sections \(indexPath.section) count \(sectionCount)")
                cell.phoneLabel.text = "Home"
                cell.phoneNumber.text = homephone
                sectionCount = sectionCount + 1
                
            }
            return cell
        }
        
        if indexPath.section == sectionCount {
            if let workphone = contact?.workPhone {
            
                print("sections \(indexPath.section) count \(sectionCount)")
                cell.phoneLabel.text = "Work"
                cell.phoneNumber.text = workphone
                sectionCount = sectionCount + 1
                
            }
            return cell
        }
        
        if indexPath.section == sectionCount {
            if let otherphone = contact?.otherPhone {
            
                print("sections \(indexPath.section) count \(sectionCount)")
                cell.phoneLabel.text = "Other"
                cell.phoneNumber.text = otherphone
                sectionCount = sectionCount + 1
                return cell
            }
        }
        
        if indexPath.section == sectionCount {
            if let mainphone = contact?.mainPhone {
            
                print("sections \(indexPath.section) count \(sectionCount)")
                cell.phoneLabel.text = "Main"
                cell.phoneNumber.text = mainphone
                sectionCount = sectionCount + 1
                
            }
            return cell
        }
        
        return cell
    }
    
    
}
