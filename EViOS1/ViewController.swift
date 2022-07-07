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
        var popTitle = "ERROR"
        var popDescription = ""
        var popButton = "OK"
        if !(loginTextField.text?.contains("@") == true) {
            popDescription = errorAlertPopUp(loginTextField.placeholder!)
        }
        else if passwordTextField.text?.count ?? 0 < 4 {
            popDescription = errorAlertPopUp(passwordTextField.placeholder!)
        }
        else {
            if newsletterSwitch.isOn {
                popDescription = "Vous vous etes inscris à la news letter"
            }
            else {
                popDescription = "Vous ne vous etes pas inscris à la news letter"
            }
            popTitle = "Bienvenue \(loginTextField.text!) !"
            popButton = "Merci !"
        }
        
        showLoginPopUp(title: popTitle, description: popDescription, buttonText: popButton)
    }
    
    func showLoginPopUp(title: String, description: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default))
        
        present(alert, animated: true, completion: nil)
    }
    
    func errorAlertPopUp(_ field: String) -> String {
        var str = ""
        switch field {
        case "Login":
            str = "Le login doit contenir au moin un \'@\'"
        case "Password":
            str = "Le mot de passe doit contenir au moin 4 caractères"
        default:
            str = "Une condition n'est pas respecté"
        }
        
        return str
    }
    
}



extension UIImageView {
    func makeRounded() {
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
