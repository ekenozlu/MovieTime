//
//  ForgotPassVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 2.08.2023.
//

import UIKit
import FirebaseAuth

class ForgotPassVC: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.configureView(UIColor.black, 0, 9, UIColor.black, 1, 20)
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        //Send Password Reset Mail
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            if error != nil {
                
            }
            self.dismiss(animated: true)
        }
    }
}
