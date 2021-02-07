//
//  ContactsViewModel.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/06.
//

import Foundation
import Contacts
import UIKit
typealias successHandler = (MyContact, ContactsError) -> Void
class ContactsViewModel {
    
    var cStore: CNContactStore?
    let cKeys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactImageDataAvailableKey, CNContactImageDataKey, CNContactThumbnailImageDataKey, CNContactPhoneNumbersKey]
    
    var fetchedContacts = [MyContact]()
    
    func fetchContactcs(contactResponseHandler: @escaping (MyContact?, ContactsError?) -> Void) {
        
        cStore = CNContactStore()
        cStore?.requestAccess(for: .contacts) { [self] (granted, error ) in
            if let error = error {
                debugPrint("permission - access error: \(error)")
                contactResponseHandler(nil, .permissionDenied)
                //return
            }
            
            if granted {
                debugPrint("perssion - perssion granted")
                
                let request = CNContactFetchRequest(keysToFetch: cKeys as [CNKeyDescriptor])
                do {
                    try cStore?.enumerateContacts(with: request, usingBlock: {(contact, stopPointer) in
                        
                        var phoneNumber: String?
                        
                        print(contact.givenName)
                        for phone in contact.phoneNumbers {
                            if var label = phone.label {
                                label = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                                
                                print(" tt ", label, phone.value.stringValue)
                            }
                        }
                        
                        var imageData               : Data?
                        var thumbnaiImageData       : Data?
                        
                        if contact.imageDataAvailable {
                            
                            if let image = contact.imageData {
                                imageData = image
                            }
                            
                            if let thumbnail = contact.thumbnailImageData {
                                thumbnaiImageData = thumbnail
                            }
                        }
                        DispatchQueue.main.async {
                            fetchedContacts.append(MyContact(firstName: contact.givenName, lastName: contact.familyName, contactImage: imageData, contactThumbnail: thumbnaiImageData, cellPhone: "\(contact.phoneNumbers)"))
                            contactResponseHandler(MyContact(firstName: contact.givenName, lastName: contact.familyName, contactImage: imageData, contactThumbnail: thumbnaiImageData, cellPhone: "\(contact.phoneNumbers)"), nil)
                        }
                        
                    })
                } catch { }
            }
        }
    }
    
    
    
    func numberOfContacts() -> Int { return fetchedContacts.count }
    
}
