//
//  ViewController.swift
//  Movie App
//
//  Created by Jose Vega on 2/16/19.
//  Copyright © 2019 Jose Vega. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    struct ResponseData: Codable {
//        let data: [MoviesItem]
//    }
//
//    struct MoviesItem: Codable {
//        let page_: Int
//        let totalResults: Int
//        let totalRages: Int
//        let results_total: [Results]
//
//        enum CodingKeys: String, CodingKey {
//            case page_: "page"
//            case totalResults: "total_results"
//            case totalRanges: "total_pages"
//            case results_total:"results"
//        }
//    }
//
//    struct Results: Codable {
//
//    }
    
    @IBOutlet weak var pgrs: UIActivityIndicatorView!
    @IBOutlet weak var apiData: UILabel!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var artistSearch: UITextField!
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
        // Do any additional setup after loading the view, typically from a nib.
        apiData.isHidden = true
        pgrs.isHidden = true
        searchField.delegate = self
        artistSearch.delegate = self
    }
    @IBAction func searchTrigger(_ sender: UIButton) {
        NSLog("Running the search trigger")
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        pgrs.startAnimating()
        pgrs.isHidden = false;
        apiData.isHidden = true
        NSLog("Running the search button trigger")
        let API_URL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=???8&language=en-US&query=Star%20Wars&page=1&include_adult=false")!
        var request = URLRequest(url: API_URL)
        NSLog("Checking the api call \(API_URL)")
        let task = session.dataTask(with: request) {(data, responds, error) in
            print("In the session")
            let status = (responds as! HTTPURLResponse).statusCode
            print(status)
            
            if let response = responds {
                print(responds)
            
                if let data = data, let body = String(data: data, encoding: .utf8){
                    DispatchQueue.main.async{
                        self.apiData.text = "\(body)"
                        self.pgrs.stopAnimating()
                        self.pgrs.isHidden = true
                        self.apiData.isHidden = false
                    }

                }
                
            } else {
                NSLog("Error on the api request")

            }
        }
        
        task.resume()
    }
    
    @IBAction func clearSearch(_ sender: UIButton) {
        apiData.text = " "
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.resignFirstResponder()
        artistSearch.resignFirstResponder()
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

