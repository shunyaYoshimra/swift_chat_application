//
//  NextViewController.swift
//  chatRoomApp
//
//  Created by 吉村舜也 on 2021/06/07.
//

import UIKit

class NextViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    var gotNameData:String!
    var gotMessageData:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = gotNameData
        messageLabel.text = gotMessageData
        // Do any additional setup after loading the view.
    }
    

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
