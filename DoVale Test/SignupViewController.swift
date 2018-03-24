//
//  SignupViewController.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 31/10/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email_outlet: UITextField!
    @IBOutlet weak var name_outlet: UITextField!
    @IBOutlet weak var last_name_outlet: UITextField!
    @IBOutlet weak var password_outlet: UITextField!
    @IBOutlet weak var pw_confirmation_outlet: UITextField!
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.email_outlet.delegate = self
        self.name_outlet.delegate = self
        self.last_name_outlet.delegate = self
        self.password_outlet.delegate = self
        self.pw_confirmation_outlet.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // hide keyboard on return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    @IBAction func signup(_ sender: Any) {
        if let get_email = self.email_outlet.text{
            if let get_password = self.password_outlet.text{
                if let get_pw_confirmation = self.pw_confirmation_outlet.text{
                    
                    if get_password == get_pw_confirmation {
                        activityIndicator.center = self.view.center
                        activityIndicator.hidesWhenStopped = true
                        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                        view.addSubview(activityIndicator)
                        
                        activityIndicator.startAnimating()

                        let auth = Auth.auth()
                        auth.createUser(withEmail: get_email, password: get_password, completion: { (user,error) in
                            
                            if error == nil {
                                print("sucesso cadastro")
                                self.performSegue(withIdentifier: "signupsegue", sender: nil)
                                self.activityIndicator.stopAnimating()
                            }else{
                                print("erro cadastro")
                                let get_error = error! as NSError
                                if let error_code = get_error.userInfo["error_name"] {
                                    let error_text = error_code as! String
                                    var error_message = ""
                                    
                                    switch error_text {
                                    case "ERROR_INVALID_EMAIL" :
                                        error_message = "E-mail inválido, digite um e-mail válido"
                                        break
                                    case "ERROR_WEAK_PASSWORD" :
                                        error_message = "Senha precisa ter no mínimo 6 caracteres, com letras e números"
                                        break
                                    case "ERROR_EMAIL_ALREADY_IN_USE" :
                                        error_message = "E-mail já está em uso"
                                        break
                                    default :
                                        error_message = "Dados digitados incorretos"
                                    }
                                    
                                    let alert = Alert(title:"Dados inválidos", message: error_message)
                                    self.present(alert.get_alert(), animated: true, completion: nil)
                                    self.activityIndicator.stopAnimating()
                                }
                            }
                        })
                    }else{
                        let alert = Alert(title:"Dados inválidos", message: "Senhas não são conferem, digite novamente")
                        present(alert.get_alert(), animated: true, completion: nil)                    }
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
