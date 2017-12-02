//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Sean Nam on 12/2/17.
//  Copyright © 2017 seannam. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!

    @IBAction func onSend(_ sender: Any) {
        if !(messageTextField.text?.isEmpty)! {
            let chatMessage = PFObject(className: "Message")
            chatMessage["text"] = messageTextField.text ?? ""
            chatMessage.saveInBackground(block: { (success, error) in
                if success {
                    print("message was saved")
                    self.messageTextField.text = ""
                } else if let error = error {
                    print("Problem saving message: \(error.localizedDescription)")
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
