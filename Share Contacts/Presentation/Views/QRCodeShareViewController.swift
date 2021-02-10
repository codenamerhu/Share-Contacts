//
//  QRCodeShareViewController.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/09.
//

import UIKit

class QRCodeShareViewController: UIViewController {

    static let identifier = "QRCodeShareViewController"
    
    @IBOutlet weak var qrCodeImage: UIImageView!
    
    var contact: MyContact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationController?.isNavigationBarHidden = false
        
        var params = [String]()
        
        if let firstName = contact?.firstName {
            params.append("givename=\(replaceSymbols(string: firstName))")
        }
        
        if let lastName = contact?.lastName {
            params.append("familyname=\(replaceSymbols(string: lastName))")
        }
        
        if let mobile = contact?.cellPhone {
            params.append("mobile=\(replaceSymbols(string: mobile).removingWhitespaces())")
        }
        
        if let telephone = contact?.tellephone {
            params.append("telephone=\(replaceSymbols(string: telephone).removingWhitespaces())")
        }
        
        if let home = contact?.homePhone {
            params.append("homephone=\(replaceSymbols(string: home).removingWhitespaces())")
        }
        
        if let work = contact?.workPhone {
            params.append("workphone=\(replaceSymbols(string: work).removingWhitespaces())")
        }
        
        if let mainPhone = contact?.mainPhone {
            params.append("mainphone=\(replaceSymbols(string: mainPhone).removingWhitespaces())")
        }
        
        if let otherPhone = contact?.otherPhone {
            params.append("otherphone=\(replaceSymbols(string: otherPhone).removingWhitespaces())")
        }
        
        
        let joined_array = params.joined(separator: ",")
        let encode_url = joined_array.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        print("joined is \(encode_url)")
        qrCodeImage.load(url: URL(string: "https://api.qrserver.com/v1/create-qr-code/?data=\(encode_url)")!)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: UIButton ) {
        _ = navigationController?.popViewController(animated: true)
    }

}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

func arrayToJson(from object:Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
        return nil
    }
    return String(data: data, encoding: String.Encoding.utf8)
}

func replaceSymbols(string: String) -> String {
    let value = string.replacingOccurrences(of: ",", with: "%2C", options: .literal, range: nil)
    return value.replacingOccurrences(of: "=", with: "%3D", options: .literal, range: nil)
}

func decryptSymbols(string: String) -> String {
    let value =  string.replacingOccurrences(of: "%2C", with: ",", options: .literal, range: nil)
    return value.replacingOccurrences(of: "%3D", with: "=", options: .literal, range: nil)
}
