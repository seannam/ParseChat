//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Sean Nam on 12/2/17.
//  Copyright © 2017 seannam. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onSignUp(_ sender: Any) {
        if !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
            registerUser(username: usernameTextField.text!, password: passwordTextField.text!)
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerUser(username: String, password: String) {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = username
        newUser.password = password
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                // TODO: add alert message
            } else {
                print("User registered successfully")
                // manually segue to logged in view
                self.segueToLogin()
            }
        }
    }
    
    func segueToLogin() {
        
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
