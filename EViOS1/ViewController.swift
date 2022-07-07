//
//  ViewController.swift
//  EViOS1
//
//  Created by Mavrik on 07/07/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordEyeIcon: UIImageView!
    @IBOutlet weak var newsletterLabel: UILabel!
    @IBOutlet weak var newsletterSwitch: UISwitch!
    @IBOutlet weak var loginConnectionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //TODO
        profilePicture.backgroundColor = UIColor(named: "darkerGreen")
        profilePicture.makeRounded()
        loginConnectionButton.backgroundColor = UIColor(named: "darkerGreen")
        loginConnectionButton.layer.cornerRadius = 10
    }

    @IBAction func didTapLoginConnectionButton(_ sender: Any) {
        
    }
    
}



extension UIImageView {
    func makeRounded() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
