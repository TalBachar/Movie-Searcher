//
//  SignUpViewController.swift
//  Movie Searcher
//
//  Created by Tal Bachar
//  Copyright © 2020 Tal Bachar. All rights reserved.
//

import UIKit

protocol SignUpViewControllerDelegate {
    func signUpTapped()
    
}

class SignUpViewController: UIViewController {
    
    var delegate: SignUpViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
    
        UserDefaults.standard.set(true, forKey: "signedUp")
        dismiss(animated: true) {
            self.delegate?.signUpTapped()
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
