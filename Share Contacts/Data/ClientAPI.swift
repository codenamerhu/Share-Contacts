//
//  ClientAPI.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/09.
//

import Foundation

class ClientSideAPI: ClientSideAPIProtocol {
    
    var session: URLSession!
    public static let shared = ClientSideAPI()
    init() {}
    
    var qrCode: QRCode?
    
    func getRequest(params: String, completion: @escaping (QRCode?) -> Void ){
        
        session = URLSession.shared
        
        var urlBuilder = URLComponents(string: "https://api.qrserver.com/v1/create-qr-code/?data=HelloWorld!&name=rhu&size=100x100")
        urlBuilder?.queryItems = []
        
        guard let url = urlBuilder?.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { [self] (data, response, error) in
            
            print("base is started")
            guard error == nil else {
                
                return
            }
            
            guard let data = data else {
                
                return
            }
            
            do {
                print("data some \(try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? String)")
                DispatchQueue.main.async {
                    //completion(QRCode(imageBase64: data))
                }
            } catch {
                print("data some \(error)")
            }
            
        } .resume()
        
        
    }
    
}
