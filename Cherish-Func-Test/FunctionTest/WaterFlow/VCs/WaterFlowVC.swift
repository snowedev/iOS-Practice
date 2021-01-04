//
//  WaterFlowVC.swift
//  FunctionTest
//
//  Created by 이원석 on 2020/12/30.
//

import UIKit
import Contacts

//MARK: -연락처 가져오기 구현부(메인 뷰컨)
class WaterFlowVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var contacts = [FetchedContact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchContacts()
        // Do any additional setup after loading the view.
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

//MARK: -Protocol Extension
extension WaterFlowVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// return the number of rows
        /// The number of rows is equal to the number of items in the contacts array so the count property of the array class is used.
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        contacts[indexPath.row].telephone = contacts[indexPath.row].telephone.components(separatedBy: ["-","/","/"]).joined()
        print(contacts[indexPath.row].telephone.count)
    
        if  (contacts[indexPath.row].telephone).count == 11 {
            var firstIndex = contacts[indexPath.row].telephone .index(contacts[indexPath.row].telephone .startIndex, offsetBy: 0)
            var lastIndex = contacts[indexPath.row].telephone .index(contacts[indexPath.row].telephone .startIndex, offsetBy: 3)
            let mobCom = "\(contacts[indexPath.row].telephone [firstIndex..<lastIndex])"

            firstIndex = contacts[indexPath.row].telephone .index(contacts[indexPath.row].telephone .startIndex, offsetBy: 3)
            lastIndex = contacts[indexPath.row].telephone .index(contacts[indexPath.row].telephone .endIndex, offsetBy: -4)
            let mobNo1 = "\(contacts[indexPath.row].telephone [firstIndex..<lastIndex])"

            firstIndex = contacts[indexPath.row].telephone .index(contacts[indexPath.row].telephone .endIndex, offsetBy: -4)
            lastIndex = contacts[indexPath.row].telephone .index(contacts[indexPath.row].telephone .endIndex, offsetBy: 0)
            let mobNo2 = "\(contacts[indexPath.row].telephone [firstIndex..<lastIndex])"
            /// Configure the cell
            /// The name and telephone number at the current index of the contacts array is assigned to the text property of the textLabel and detailLabel property of the current cell.
            
            cell.detailTextLabel?.text = "\(mobCom)" + "." + "\(mobNo1)" + "." + "\(mobNo2)"
        }
        else{
            cell.detailTextLabel?.text = contacts[indexPath.row].telephone
        }
        cell.textLabel?.text = contacts[indexPath.row].lastName + "" + contacts[indexPath.row].firstName

            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = contacts[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "WaterFlowChoice", bundle: nil)
        
        ///물줄지, 미룰지 선택하는 팝업 present
        if let vc = storyBoard.instantiateViewController(withIdentifier: "WaterFlowChoiceVC") as? WaterFlowChoiceVC{
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.b_ct = selectedPerson
            self.present(vc, animated: true, completion: nil)
        }
    }
    
}
