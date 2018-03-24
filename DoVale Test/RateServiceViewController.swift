//
//  RateServiceViewController.swift
//  DoVale Test
//
//  Created by Jimy Suenaga on 18/09/17.
//  Copyright © 2017 Audience Marketing. All rights reserved.
//

import UIKit

class RateServiceViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var serviceImageView: UIImageView!
    @IBOutlet var serviceName: UILabel!
    @IBOutlet var serviceRating: CosmosView!
    @IBOutlet var serviceComments: UITextView!
    
    var tmp_serviceImage:String = ""
    var tmp_serviceName:String = ""
    var tmp_serviceRating:Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceImageView.image = UIImage(named: tmp_serviceImage)
        serviceImageView.layer.cornerRadius = 40
        serviceImageView.clipsToBounds = true
        
        serviceName.text = tmp_serviceName
        serviceRating.rating = tmp_serviceRating
        serviceRating.settings.fillMode = .full
        
        serviceComments.text = "  Deixe aqui seu comentário"
        serviceComments.textColor = UIColor.lightGray
        
        serviceComments.delegate = self
        self.serviceComments.layer.borderWidth = 1.0;
        self.serviceComments.layer.borderColor = UIColor.gray.cgColor
        
        
        
        // Do any additional setup after loading the view.
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Deixe aqui seu comentário"
            textView.textColor = UIColor.lightGray
        }
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        else {
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
