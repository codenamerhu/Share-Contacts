//
//  ViewController.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/05.
//

import UIKit

class ViewController: UIViewController {

    var alertController: UIAlertController?
    
    var myContacts = [MyContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ContactsViewModel().fetchContactcs(contactResponseHandler: { [self] contacts, error in
            
            if let error = error {
                debugPrint(error)
                return
            }
            
            if let contacts = contacts {
                myContacts.append(contacts)
            }
        })
        
        print(myContacts[3])
    }


}

