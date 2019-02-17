//
//  ViewController.swift
//  Movie App
//
//  Created by Jose Vega on 2/16/19.
//  Copyright © 2019 Jose Vega. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchField.delegate = self
    }
    @IBAction func searchTrigger(_ sender: UIButton) {
        searchLabel.text = "Clicking"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchLabel.text = searchField.text
    }
}

