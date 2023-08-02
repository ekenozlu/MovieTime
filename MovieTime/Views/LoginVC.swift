//
//  LoginVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 28.06.2023.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var emailAlertLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        if Auth.auth().currentUser != nil {
            moveToNextScreen()
        }
    }

    @IBAction func loginPressed(_ sender: Any) {
        if isInputsValid() {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passTextField.text!) { authResult, error in
                if error != nil {
                    let ac = UIAlertController(title: "Error in Logging In", message: error?.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(ac, animated: true)
                }
                self.moveToNextScreen()
            }
        }
    }
    
    @IBAction func emailTFChange(_ sender: Any) {
        if emailTextField.text!.isValidEmail() {
            emailAlertLabel.isHidden = true
            emailTextField.layer.borderWidth = 0
        }
        else{
            emailAlertLabel.isHidden = false
            emailTextField.layer.borderColor = UIColor(named: "Tinted Purple")?.cgColor
            emailTextField.layer.borderWidth = 3
        }
    }
    
    func isInputsValid() -> Bool {
        //Check for email and pass
        return true
    }
    
    func configureView() {
        emailAlertLabel.isHidden = true
        backView.configureView(UIColor(named: "Tinted Purple")!, 3, 9, UIColor.systemPurple, 1, 20)
    }
    
    func moveToNextScreen(){
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
        tabBarController?.modalPresentationStyle = .fullScreen
        present(tabBarController!, animated: true)
    }
}

