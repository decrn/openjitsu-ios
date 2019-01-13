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

        // Do any additional setup after loading the view.
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
