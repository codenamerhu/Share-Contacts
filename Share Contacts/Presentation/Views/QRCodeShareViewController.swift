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
        
        var params = "data=contact"
        
        if let firstName = contact?.firstName {
            params.append("&firstName=\(firstName)")
        }
        
        if let lastName = contact?.lastName {
            params.append("&lastName=\(lastName)")
        }
        
        if let mobile = contact?.cellPhone {
            params.append("&mobile=\(mobile)")
        }
        
        if let telephone = contact?.tellephone {
            params.append("&telePhone=\(telephone)")
        }
        
        if let home = contact?.homePhone {
            params.append("&homePhone=\(home)")
        }
        
        if let work = contact?.workPhone {
            params.append("&workPhone=\(work)")
        }
        
        if let mainPhone = contact?.mainPhone {
            params.append("&mainPhone=\(mainPhone)")
        }
        
        if let otherPhone = contact?.otherPhone {
            params.append("&otherPhone\(otherPhone)")
        }
        
        
        print("my params \(params)")
        
        qrCodeImage.load(url: URL(string: "https://api.qrserver.com/v1/create-qr-code/?\(params.removingWhitespaces())")!)
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
