//
//  ViewController.swift
//  EViOS1
//
//  Created by Mavrik on 07/07/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
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
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapShowPasswordEyeIcon))
        tap.numberOfTapsRequired = 1
        showPasswordEyeIcon.isUserInteractionEnabled = true
        showPasswordEyeIcon.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //TODO
        profilePicture.backgroundColor = UIColor(named: "darkerGreen")
        profilePicture.makeRounded()
        loginConnectionButton.backgroundColor = UIColor(named: "darkerGreen")
        loginConnectionButton.layer.cornerRadius = 10
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @objc func didTapShowPasswordEyeIcon() {
        if passwordTextField.isSecureTextEntry {
            showPasswordEyeIcon.image = UIImage(named: "eye_off_icon")
        }
        else {
            showPasswordEyeIcon.image = UIImage(named: "eye_on_icon")
        }
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
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
