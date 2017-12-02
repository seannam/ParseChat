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

    let alertController = UIAlertController(title: "Error!", message: "Missing username or password!", preferredStyle: .alert)
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func onSignUp(_ sender: Any) {
        if !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
            registerUser(username: usernameTextField.text!, password: passwordTextField.text!)
        } else {
            present(alertController, animated: true)
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if !(usernameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! {
            loginUser(username: usernameTextField.text!, password: passwordTextField.text!)
        } else {
            present(alertController, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here. Doing nothing will dismiss the view.
        }
        // add the OK action to the alertController
        self.alertController.addAction(OKAction)
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
                self.segueToMain()
            }
        }
    }
    
    func loginUser(username: String, password: String) {

        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("user log in failed: \(error.localizedDescription)")
            } else {
                print("user logged in successfully")
                self.segueToMain()
            }
        }
    }
    
    func segueToMain() {
        print("segueToMain")
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
