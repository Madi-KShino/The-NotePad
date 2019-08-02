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
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Actions
    @IBAction func createAccountButtonTapped(_ sender: Any) {
        if hasAccount {
           
            
        } else {
            guard let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let passwordConfirmed = confirmPasswordTextField.text, !passwordConfirmed.isEmpty
            else { return }
            if password == passwordConfirmed {
                UserController.sharedInstance.createNewUser(withEmail: email, firstName: name)
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
