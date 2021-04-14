//
//  ViewController.swift
//  LogoViewer-IOS
//
//  Created by Mehdi Benrefad on 14/04/2021.
//  Copyright © 2021 Mehdi Benrefad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonSearch: UITextField!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //pour enlever le clavier de l'ecran quand on tappe ailleurs
    @IBAction func TapGetsureRecognizer(_ sender: Any) {
        textField.resignFirstResponder()
        
    }
    
    //pour enlever le claver de l'ecran via continue
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //cette fonction est appelee lors du clic sur le boutton search
    @IBAction func searchAction() {
        searchLogo()
    }
    
    func searchLogo() {
            guard let domain = textField.text else { return }

            
            LogoService.shared.getLogo(domain: domain) { (success, data) in
                if success, let data = data {
                    self.updateImage(with: data)
                } else {
                    self.presentAlert()
                }
            }
        }

        
        
    
        //fonction qui affiche le logo
        private func updateImage(with data: Data) {
            self.imageView.image = UIImage(data: data)
        }

        //fonction qui affiche une alerte
        private func presentAlert() {
            let alertVC = UIAlertController(title: "Error", message: "Could not find a logo.", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }

    }


