//
//  ViewController.swift
//  Movie App
//
//  Created by Jose Vega on 2/16/19.
//  Copyright © 2019 Jose Vega. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchLabelText: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBAction func searchTrigger(_ sender: UIButton) {
        searchLabelText.text = "Clicking"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // hides the keyboard after the user has return
        searchTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchLabelText.text = searchTextField.text
    }
}

