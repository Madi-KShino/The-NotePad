//
//  SignInViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/1/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    //Properties
    var hasAccount = false
    
    //Outlets
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var toggleActionButton: UIButton!
    @IBOutlet weak var securityInfoButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordErrorLabel.isHidden = true
    }

    //Actions
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        let authGroup = DispatchGroup()
        guard let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
            else { return }
        //Sign User In
        if hasAccount {
            authGroup.enter()
            guard let currentUser = FirebaseController.sharedInstance.currentUser else { return }
            FirebaseController.sharedInstance.authenticateUserWith(email: email, password: password) { (success) in
                if success {
                    print("User was Authenticated Successfully")
                    authGroup.leave()
                } else {
                    print("User Authentication Failed")
                }
            }
            UserController.sharedInstance.fetchUserWith(uuid: currentUser.uid) { (success) in
                if success {
                    print("User Successfully Signed In")
                    self.performSegue(withIdentifier: "toDetailVC", sender: self.createAccountButton)
                } else {
                    print("User Sign In Failed")
                }
            }
            //Create New User
        } else {
            guard let confirmedPass = confirmPasswordTextField.text, !confirmedPass.isEmpty else { return }
            if password == confirmedPass {
                authGroup.enter()
                passwordErrorLabel.isHidden = true
                FirebaseController.sharedInstance.authenticateUserWith(email: email, password: password) { (success) in
                    if success {
                        print("User was Authenticated Successfully")
                        authGroup.leave()
                    } else {
                        print("User Authentication Failed")
                    }
                }
                UserController.sharedInstance.createNewUser(withEmail: email, firstName: name) { (success) in
                    if success {
                        print("User Successfully Created")
                        self.performSegue(withIdentifier: "toDetailVC", sender: self.createAccountButton)
                    } else {
                        print("User Creation Failed")
                    }
                }
//                authGroup.notify(queue: .main, work: <#T##DispatchWorkItem#>)
            } else {
                passwordErrorLabel.isHidden = false
            }
        }
    }
    
    @IBAction func toggleActionButtonTapped(_ sender: Any) {
        if hasAccount {
            toggleCreateAccount()
        } else {
            toggleSignInToAccount()
        }
    }
    
    func toggleCreateAccount() {
        hasAccount = false
        UIView.animate(withDuration: 0.5) {
            self.toggleActionButton.setTitle("Already Have Account?", for: .normal)
            self.createAccountButton.titleLabel?.text = "Create Account"
            self.createAccountLabel.text = "Create Your Account"
            self.confirmPasswordTextField.isHidden = false
        }
    }
    
    func toggleSignInToAccount() {
        hasAccount = true
        UIView.animate(withDuration: 0.5) {
            self.toggleActionButton.setTitle("Create an Account?", for: .normal)
            self.createAccountButton.titleLabel?.text = "Sign In"
            self.createAccountLabel.text = "Sign In To Your Account"
            self.confirmPasswordTextField.isHidden = true
        }
    }
}
