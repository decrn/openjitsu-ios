//
//  LoginViewController.swift
//  Openjitsu
//
//  Created by Denis Carnier on 13/01/2019.
//  Copyright © 2019 Denis Carnier. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction func cancel(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Turn the status bar to light since we're using a dark background
        // Doesn't actually work though.
        // Read more here:
        // https://medium.com/@craiggrummitt/the-mysterious-case-of-the-status-bar-d9059a327c97
        // SOURCE: https://stackoverflow.com/a/40295883
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
}
