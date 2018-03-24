//
//  SigninViewController.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 12/11/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit
import FirebaseAuth

class SigninViewController: UIViewController {

    @IBOutlet weak var email_outlet: UITextField!
    @IBOutlet weak var password_outlet: UITextField!
    
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signin(_ sender: Any) {
        if let get_email = self.email_outlet.text{
            if let get_password = self.password_outlet.text{
                activityIndicator.center = self.view.center
                activityIndicator.hidesWhenStopped = true
                activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
                view.addSubview(activityIndicator)
                
                activityIndicator.startAnimating()
                
                let auth = Auth.auth()
                auth.signIn(withEmail: get_email, password: get_password, completion: { (user, error) in
                    if error == nil {
                        print("sucesso login")
                        self.activityIndicator.stopAnimating()
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }else {
                        print("erro login")
                        let get_error = error! as NSError
                        if let error_code = get_error.userInfo["error_name"] {
                            let error_text = error_code as! String
                            var error_message = ""
                            
                            print(error_text)
                            switch error_text {
                            case "ERROR_INVALID_EMAIL" :
                                error_message = "E-mail inválido, digite um e-mail válido"
                                break
                            case "ERROR_WRONG_PASSWORD" :
                                error_message = "Senha incorreta! Tente novamente"
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
