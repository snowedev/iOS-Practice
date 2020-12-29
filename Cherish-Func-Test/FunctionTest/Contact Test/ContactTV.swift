//
//  ContactTV.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/29.
//

import UIKit
import Contacts

class ContactTV: UITableViewController {
    
    var contacts = [FetchedContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContacts()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        /// 1.
        /// return the number of sections
        /// There is only one section in the Table View so 1 needs to be returned in the numberOfSections(in:) method.
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// 2.
        /// return the number of rows
        /// The number of rows is equal to the number of items in the contacts array so the count property of the array class is used.
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        /// 3.
        /// Configure the cell...
        /// The name and telephone number at the current index of the contacts array is assigned to the text property of the textLabel and detailLabel property of the current cell.
        cell.textLabel?.text = contacts[indexPath.row].lastName + "" + contacts[indexPath.row].firstName
        cell.detailTextLabel?.text = contacts[indexPath.row].telephone
        
        return cell
    }

    private func fetchContacts() {
        /// 1. The CNContactStore object contains the user’s contacts store database
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if let error = error {
                print("failed to request access", error)
                return
            }
            if granted {
                /// 2. a CNContactFetchRequest object is created containing the name and telephone keys .
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    // 3. All contacts are fetched with the request, the corresponding keys are assigned to the property of the FetchContact object and added to the contacts array.
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPointer) in
                        self.contacts.append(FetchedContact(firstName: contact.givenName, lastName: contact.familyName, telephone: contact.phoneNumbers.first?.value.stringValue ?? ""))
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
}
