//
//  ViewController.swift
//  Contact
//
//  Created by Wonseok Lee on 2021/06/14.
//

// info.plist에 Privacy - Contacts Usage Description 추가
import UIKit
import Contacts
import MessageUI
import CallKit

class ViewController: UIViewController {
    var deviceContacts = [FetchedContact]()
    let callObserver = CXCallObserver()
    var didDetectOutgoingCall = false
    
    @IBOutlet weak var contactTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTV.dataSource = self
        contactTV.delegate = self
    }
    
    // MARK: - 확인 Alert 생성
    func makeAlert(title : String, message : String?, callingAction : ((UIAlertAction) -> Void)? = nil, messageAction : ((UIAlertAction) -> Void)? = nil, completion : (() -> Void)? = nil) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let callingAction = UIAlertAction(title: "전화", style: .default, handler: callingAction)
        let messageAction = UIAlertAction(title: "문자", style: .default, handler: messageAction)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertViewController.addAction(callingAction)
        alertViewController.addAction(messageAction)
        alertViewController.addAction(cancel)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}

//MARK: - 전화
extension ViewController: CXCallObserverDelegate {
    
    //MARK: - 전화번호에서 숫자만 parsing
    func numberParsing(number: String) -> String {
        let pattern: String = "[0-9]*"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let result = regex.matches(in: number, options: [], range: NSRange(location: 0, length: number.count))
            
            let rexStrings = result.map { (element) -> String in
                let range = Range(element.range, in: number)!
                return String(number[range])
            }.reduce(""){$0+$1}
            
            return rexStrings
        } catch let error {
            print(error.localizedDescription)
        }
        return "0000"
    }
    //MARK: - 연락처 동기화
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
                    try store.enumerateContacts(with: request, usingBlock: { [self] (contact, stopPointer) in
                        deviceContacts.append(FetchedContact(fristName: contact.givenName, lastName: contact.familyName, telephone: numberParsing(number: contact.phoneNumbers.first?.value.stringValue ?? "")))
                    })
                } catch let error {
                    print("Failed to enumerate contact", error)
                }
            } else {
                print("access denied")
            }
        }
    }
    
    //MARK: - 전화 걸기
    func showCallAlert(phoneNumber: String) {
        guard let url = NSURL(string: "tel://" + phoneNumber),
              UIApplication.shared.canOpenURL(url as URL) else {
            return
        }
        callObserver.setDelegate(self, queue: nil)
        didDetectOutgoingCall = false
        //we only want to add the observer after the alert is displayed,
        //that's why we're using asyncAfter(deadline:)
        UIApplication.shared.open(url as URL, options: [:]) { [weak self] success in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self?.addNotifObserver()
                }
            }
        }
    }
    // 통화하려다가 취소눌렀을 때를 감지하기 위한 옵저버 등록
    func addNotifObserver() {
        let selector = #selector(appDidBecomeActive)
        let notifName = UIApplication.didBecomeActiveNotification
        NotificationCenter.default.addObserver(self, selector: selector, name: notifName, object: nil)
    }
    @objc func appDidBecomeActive() {
        //if callObserver(_:callChanged:) doesn't get called after a certain time,
        //the call dialog was not shown - so the Cancel button was pressed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            if !(self?.didDetectOutgoingCall ?? true) {
                print("Cancel button pressed")
            }
        }
    }
    
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        /// 통화를 하게 되면
        if call.isOutgoing && !didDetectOutgoingCall {
            didDetectOutgoingCall = true
            print("Call button pressed")
        }
    }
}

//MARK: - 메시지
extension ViewController: MFMessageComposeViewControllerDelegate {
    // 메시지 전송 결과
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case MessageComposeResult.sent:
            print("전송 완료")
            break
        case MessageComposeResult.cancelled:
            print("취소")
            break
        case MessageComposeResult.failed:
            print("전송 실패")
            break
        @unknown default:
            fatalError()
        }
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchContacts()
        return deviceContacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: contactTVCell.identifier, for: indexPath) as? contactTVCell else { return UITableViewCell() }
        
        cell.nameLabel.text = deviceContacts[indexPath.row].lastName+deviceContacts[indexPath.row].fristName
        cell.phoneLabel.text = deviceContacts[indexPath.row].telephone
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = deviceContacts[indexPath.row].lastName+deviceContacts[indexPath.row].fristName
        let phoneNumber = deviceContacts[indexPath.row].telephone
        makeAlert(title: "\(name)에게 연락하기", message: nil) { [self] _ in
            // 전화하기
            showCallAlert(phoneNumber: "\(phoneNumber)")
        } messageAction: { [self] _ in
            // 문자보내기
            if MFMessageComposeViewController.canSendText(){
                let messageComposer = MFMessageComposeViewController()
                messageComposer.messageComposeDelegate = self
                messageComposer.recipients = [phoneNumber]
                messageComposer.body = ""
                messageComposer.modalPresentationStyle = .currentContext
                self.present(messageComposer, animated: true)
            }
        } completion: {}
    }
}
