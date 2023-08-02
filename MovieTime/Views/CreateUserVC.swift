//
//  CreateUserVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 2.08.2023.
//

import UIKit
import FirebaseAuth

class CreateUserVC: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.configureView(UIColor.black, 0, 9, UIColor.black, 1, 20)
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passTextField.text!) { authResult, error in
            if error != nil {
                
            }
            self.moveToNextView()
        }
    }
    
    func moveToNextView(){
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
        tabBarController?.modalPresentationStyle = .fullScreen
        present(tabBarController!, animated: true)
    }
}
