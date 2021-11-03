//
//  ViewController.swift
//  chatRoomApp
//
//  Created by 吉村舜也 on 2021/06/06.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController {
    
    struct Message {
        var senderID: String
        var name: String
        var message: String
    }
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    
    private var messages = [Message]()
    private var messageListener:ListenerRegistration?
    var giveNameData:String!
    var giveMessageData:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        chatTableView.delegate = self
        chatTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.messageListener = Firestore.firestore().collection("chat").order(by: "date").addSnapshotListener({ snapShot, err in
            if let snapShot = snapShot {
                self.messages = snapShot.documents.map{ message -> Message in
                    let data = message.data()
                    return Message(senderID: data["sender_id"] as! String, name: data["name"] as! String, message: data["text"] as! String)
                }
                self.chatTableView.reloadData()
            }
        })
    }
    
    
    @IBAction func trappedSendButton(_ sender: Any) {
        sendChatMessage(name: nameTextField.text ?? "", message: messageTextField.text ?? "")
    }
    
    private func sendChatMessage(name: String, message: String) {
        guard let id = UIDevice.current.identifierForVendor?.uuidString else {return}
        let dataStore = Firestore.firestore()
        dataStore.collection("chat").addDocument(data: ["text": message, "name": name, "sender_id": id, "date": Date()]) { err in
            DispatchQueue.main.async {
                if err != nil {
                    print(err.debugDescription)
                } else {
                    self.messageTextField.text = ""
                }
            }
        }
    }
    

}

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        giveNameData = messages[indexPath.row].name
        giveMessageData = messages[indexPath.row].message
        performSegue(withIdentifier: "next", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let nextVC = segue.destination as! NextViewController
            nextVC.gotNameData =  giveNameData
            nextVC.gotMessageData = giveMessageData
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        cell.nameTextLabel.text = message.name
        cell.messageTextLabel.text = message.message
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

