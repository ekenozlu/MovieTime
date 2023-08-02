//
//  ThirdTabVC.swift
//  MovieTime
//
//  Created by Eken Özlü on 15.06.2023.
//

import UIKit

class ThirdTabVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        
        configureNavBar()
    }
    
    func configureNavBar() {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backButtonTitle = "Back"
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        loginVC?.modalPresentationStyle = .fullScreen
        present(loginVC!, animated: true)
    }
}
