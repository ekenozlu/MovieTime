//
//  LoginVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 28.06.2023.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        backView.layer.cornerRadius = 9
        backView.layer.borderColor = UIColor(named: "Tinted Purple")?.cgColor
        backView.layer.borderWidth = 3
        backView.layer.shadowColor = UIColor.systemPurple.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = .zero
        backView.layer.shadowRadius = 20
    }

    @IBAction func loginPressed(_ sender: Any) {
        let tabBarController = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
        tabBarController?.modalPresentationStyle = .fullScreen
        present(tabBarController!, animated: true)
    }
}

