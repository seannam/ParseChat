//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Sean Nam on 12/2/17.
//  Copyright © 2017 seannam. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [PFObject] = []
    
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
        tableView.dataSource = self
        
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refresh() {
        let query = PFQuery(className:"Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                if let objects = objects {
                    self.messages = objects
                    self.tableView.reloadData()
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        if let user = messages[indexPath.row]["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "�"
        }
        
        cell.messageLabel.text = messages[indexPath.row]["text"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
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
