//
//  ClientSideAPIProtocol.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/09.
//

import Foundation

protocol ClientSideAPIProtocol {
    
    func getRequest (params: String, completion: @escaping (QRCode?) -> Void )
}
