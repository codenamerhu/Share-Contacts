//
//  ContactsViewModel.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/06.
//

import Foundation
import Contacts

class ContactsViewModel {
    
    var cStore: CNContactStore?
    
    func ferchedContactcs() {
        
        cStore = CNContactStore()
        
        cStore?.requestAccess(for: .contacts, completionHandler: <#T##(Bool, Error?) -> Void#>)
        
    }
    
}
