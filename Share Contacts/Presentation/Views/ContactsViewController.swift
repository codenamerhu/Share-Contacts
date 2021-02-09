//
//  ContactsViewController.swift
//  Share Contacts
//
//  Created by Rhulani Ndhlovu on 2021/02/07.
//

import UIKit

class ContactsViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let searchController    = UISearchController(searchResultsController: nil)
    
    var myContacts          = [MyContact]()
    var contactsViewModel   = ContactsViewModel()
    var qrCodeImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearch()
        
        contactsViewModel.fetchContactcs(contactResponseHandler: { [self] contacts, error in
            
            if let error = error {
                debugPrint(error)
                return
            }
            
            if let contacts = contacts {
                myContacts.append(contacts)
            }
            
            collectionView.delegate     = self
            collectionView.dataSource   = self
            collectionView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Contact"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @IBAction func addContact(_ sender: UIButton) {
        
        let addContactView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: AddContactViewViewController.identifier)
        self.navigationController?.pushViewController(addContactView, animated: true)
    }

}

extension ContactsViewController : UICollectionViewDelegate { }

extension ContactsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myContacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCollectionViewCell.identifier, for: indexPath) as! ContactCollectionViewCell
        cell.contacts = myContacts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let contactDetialView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: ContactDetailViewController.identifier) as! ContactDetailViewController
        contactDetialView.contact = myContacts[indexPath.row]
        
        self.navigationController?.pushViewController(contactDetialView, animated: true)
    }
}

extension ContactsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let scaleFactor = (screenWidth / 3) - 6

        return CGSize(width: scaleFactor, height: scaleFactor)
    }
}

extension ContactsViewController : UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
