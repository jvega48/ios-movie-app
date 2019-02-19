//
//  ViewController.swift
//  Movie App
//
//  Created by Jose Vega on 2/16/19.
//  Copyright © 2019 Jose Vega. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var pgrs: UIActivityIndicatorView!
    @IBOutlet weak var apiData: UILabel!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var imagePlaceholder: UIImageView!
    @IBAction func imagePicker(_ sender: UITapGestureRecognizer) {
        searchField.resignFirstResponder()
        
        NSLog("Running the imagepciker", imagePlaceholder)
        let imagePickerContainer = UIImagePickerController()
        
        imagePickerContainer.sourceType = .photoLibrary
        
        imagePickerContainer.delegate = self
        
        present(imagePickerContainer, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pgrs.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        searchField.delegate = self
    }
    @IBAction func searchTrigger(_ sender: UIButton) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        pgrs.startAnimating()
        pgrs.isHidden = false;
        apiData.isHidden = true
        NSLog("Running the search button trigger")
        searchLabel.text = "Clicking"
        
        let API_URL = URL(string: "https://api.lyrics.ovh/v1/Drake/Fake%20Love")!
        NSLog("Checking the api call \(API_URL)")
        let task = session.dataTask(with: API_URL) {(data, responds, error) in
            print("In the session")
            let status = (responds as! HTTPURLResponse).statusCode
            print(status)
            guard let a = data else {return}
            do{

                let str = try JSONSerialization.jsonObject(with: a, options: [])
                NSLog("\(str)")
                self.apiData.text = "\(str)"
                self.pgrs.stopAnimating()
                self.pgrs.isHidden = true
                self.apiData.isHidden = false

            }catch{
                NSLog("Error on the api request")
            }
            
            
        }
        
        task.resume()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchLabel.text = searchField.text
        NSLog("Running the search type trigger")

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        NSLog("Running the imagepicker controller")
        guard let selectImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("no such image found fatal error accured \(info)")
        }
        
        NSLog("Running the search trigger after image picked", selectImage)
        imagePlaceholder.image = selectImage
        NSLog("Running the search trigger after setting the image", imagePlaceholder)
        dismiss(animated: true, completion: nil)
    }
}

