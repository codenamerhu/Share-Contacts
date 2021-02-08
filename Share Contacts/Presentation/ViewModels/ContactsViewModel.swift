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
                        
                        var mobile: String?
                        var main: String?
                        var home: String?
                        var work: String?
                        var telephone: String?
                        var other: String?
                        
                        print(contact.givenName)
                        for phone in contact.phoneNumbers {
                            if var label = phone.label {
                                label = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
                                
                                if label == "mobile" {
                                    mobile = phone.value.stringValue
                                }
                                
                                if label == "main" {
                                    main = phone.value.stringValue
                                }
                                
                                if label == "home" {
                                    home = phone.value.stringValue
                                }
                                
                                if label == "work" {
                                    work = phone.value.stringValue
                                }
                                
                                if label == "other" {
                                    other = phone.value.stringValue
                                }
                                if label == "telephone" {
                                    telephone = phone.value.stringValue
                                }
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
                            fetchedContacts.append(MyContact(firstName: contact.givenName, lastName: contact.familyName, contactImage: imageData, contactThumbnail: thumbnaiImageData, cellPhone: mobile,tellephone: telephone, mainPhone: main, homePhone: home, workPhone: work, otherPhone: other))
                            contactResponseHandler(MyContact(firstName: contact.givenName, lastName: contact.familyName, contactImage: imageData, contactThumbnail: thumbnaiImageData, cellPhone: mobile,tellephone: telephone, mainPhone: main, homePhone: home, workPhone: work, otherPhone: other), nil)
                        }
                        
                    })
                } catch { }
            }
        }
    }
    
    
    
    func numberOfContacts() -> Int { return fetchedContacts.count }
    
}
