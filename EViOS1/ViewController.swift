//
//  ViewController.swift
//  EViOS1
//
//  Created by Mavrik on 07/07/2022.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBOutlet weak var newsletterLabel: UILabel!
    @IBOutlet weak var newsletterSwitch: UISwitch!
    @IBOutlet weak var loginConnectionButton: UIButton!
    @IBOutlet weak var busyIndicator: UIActivityIndicatorView!
    
    var userList = [RegisteredUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapShowPasswordEyeIcon))
        tap.numberOfTapsRequired = 1
        showPasswordButton.isUserInteractionEnabled = true
        showPasswordButton.addGestureRecognizer(tap)
        
        profilePicture.image = UIImage(named: "user_icon")
        backgroundImage.image = UIImage(named: "background_image")
        showPasswordButton.setImage(UIImage(named: "eye_on_icon"), for: .normal)
        
        
        busyIndicator.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profilePicture.backgroundColor = UIColor(named: "darkerGreen")
        profilePicture.makeRounded()
        loginConnectionButton.backgroundColor = UIColor(named: "darkerGreen")
        loginConnectionButton.layer.cornerRadius = 10
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func didTapShowPasswordEyeIcon() {
        if passwordTextField.isSecureTextEntry {
            showPasswordButton.setImage(UIImage(named: "eye_off_icon"), for: .normal)
        }
        else {
            showPasswordButton.setImage(UIImage(named: "eye_on_icon"), for: .normal)
        }
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }

    @IBAction func didTapLoginConnectionButton(_ sender: Any) {
        
        busyIndicator.startAnimating()
        busyIndicator.isHidden = false
        
        downloadDatas() { title, description, buttonText in
            DispatchQueue.main.async {
                self.showLoginPopUp(title: title, description: description, buttonText: buttonText)
                self.busyIndicator.isHidden = true
                self.busyIndicator.stopAnimating()
            }
        }
    }
    
    func downloadDatas(completionHandler: @escaping (String, String, String) -> Void) {
        let login = loginTextField.text
        let password = passwordTextField.text
        let switchStatus = newsletterSwitch.isOn
        
        DispatchQueue.global().async {
            var popTitle = "ERROR"
            var popDescription = ""
            var popButton = "OK"
            let predicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            
            if !predicate.evaluate(with: login) {
                popDescription = self.errorAlertPopUp(.login)
            }
            else if password?.count ?? 0 < 4 {
                popDescription = self.errorAlertPopUp(.password)
            }
            else {
                if switchStatus {
                    popDescription = "Vous vous etes inscris à la news letter"
                }
                else {
                    popDescription = "Vous ne vous etes pas inscris à la news letter"
                }
                popTitle = "Bienvenue \(login!) !"
                popButton = "Merci !"
                
                sleep(3)
                
                self.userList.append(RegisteredUser(login: login!, password: password!, newsletter: switchStatus))
            }
            
            completionHandler(popTitle, popDescription, popButton)
        }
    }
    
    func showLoginPopUp(title: String, description: String, buttonText: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default))
        
        present(alert, animated: true, completion: nil)
    }
    
    func errorAlertPopUp(_ field: FieldType) -> String {
        var str = ""
        switch field {
        case .login:
            str = "Le login doit contenir au moin un \'@\'"
        case .password:
            str = "Le mot de passe doit contenir au moin 4 caractères"
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
