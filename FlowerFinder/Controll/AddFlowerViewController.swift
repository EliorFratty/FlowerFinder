//
//  AddFlowerViewController.swift
//  FlowerFinder
//
//  Created by User on 07/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import CoreML
import Vision
import SwiftyJSON
import Alamofire
import SDWebImage
import ColorThiefSwift

class AddFlowerViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
        
    }()
    
    private lazy var cancelButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Return", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.isHidden = true
        
        button.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var returnButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Return", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(returnButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var addToFlowerListButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.isHidden = true
        
        button.addTarget(self, action: #selector(savetButtonTapped), for: .touchUpInside)
        return button
    }()

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
        
    }()
    let infoLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 30)

        return lb
        
    }()
    
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    var pickedImage : UIImage?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        
        imagePicker.delegate = self
        
        makeNavBar()
        view.addSubview(imageView)
        view.addSubview(scrollView)
        view.addSubview(addToFlowerListButton)
        view.addSubview(cancelButton)
        view.addSubview(returnButton)

        setupConstraintForImageView()
        setupConstraintForScrollView()
        
        setupaddToFlowerListButtonAndcancelButton()
        
    }
    
    func UIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func setupConstraintForImageView() {
        imageView.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 10).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16) .isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32) .isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    // x y width height
    func setupConstraintForScrollView() {
        scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16) .isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16) .isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(infoLabel)
        
        infoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        infoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
        
    }
    
    func setupaddToFlowerListButtonAndcancelButton() {
        cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5) .isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100) .isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addToFlowerListButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        addToFlowerListButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5) .isActive = true
        addToFlowerListButton.widthAnchor.constraint(equalToConstant: 100) .isActive = true
        addToFlowerListButton .heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        returnButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
        returnButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 5) .isActive = true
        returnButton.widthAnchor.constraint(equalToConstant: 100) .isActive = true
        returnButton .heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func returnButtonTapped() {
        self.cancelButton.isHidden = true
        self.addToFlowerListButton.isHidden = true
        self.returnButton.isHidden = false

        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func savetButtonTapped() {
        
        saveFlowerInCoreData()
        
        self.cancelButton.isHidden = true
        self.addToFlowerListButton.isHidden = true
        self.returnButton.isHidden = false
    }
    
    private var name = ""
    private var imageUrl = ""
    private var details = ""

    func saveFlowerInCoreData() {
        let flower = Flower(context: PersistenceManager.shared.context)
        
        flower.name = name
        flower.imageUrl = imageUrl
        flower.details = details
        flower.date = NSDate() as Date
        flower.location = "Netanya, Israel"
        
        PersistenceManager.shared.saveContext()
        
        name = ""
        imageUrl = ""
        details = ""
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[.originalImage] as? UIImage {
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert image to CIImage.")
            }
            pickedImage = userPickedImage
            detect(flowerImage: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(flowerImage: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else {
            fatalError("Can't load model")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let result = request.results?.first as? VNClassificationObservation else {
                fatalError("Could not complete classfication")
            }

            let resultConfidence = result.confidence
            
            print(result.identifier.capitalized)
            print(resultConfidence)

            if resultConfidence > 0.6 {
            
                self.navigationItem.title = result.identifier.capitalized
            
                self.requestInfo(flowerName: result.identifier)
                self.name = result.identifier
                
                
            } else {
                self.navigationItem.title = "No Result \(resultConfidence)%"
                
                self.requestInfo(flowerName: "non")
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: flowerImage)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    func requestInfo(flowerName: String) {
        let parameters : [String:String] = ["format" : "json",
                                            "action" : "query",
                                            "prop" : "extracts|pageimages",
                                            "exintro" : "",
                                            "explaintext" : "",
                                            "titles" : flowerName,
                                            "redirects" : "1",
                                            "pithumbsize" : "500",
                                            "indexpageids" : ""]
        
        
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { [self] (response) in
            if response.result.isSuccess {
                
                let flowerJSON : JSON = JSON(response.result.value!)
                
                let pageid = flowerJSON["query"]["pageids"][0].stringValue
                
                let flowerDescription = flowerJSON["query"]["pages"][pageid]["extract"].stringValue
                let flowerImageURL = flowerJSON["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                
                self.infoLabel.text = flowerDescription
                self.details = flowerDescription
                self.imageUrl = flowerImageURL
                
                self.imageView.sd_setImage(with: URL(string: flowerImageURL), completed: { (image, error,  cache, url) in
                    
                    if let currentImage = self.imageView.image {
                        
                        guard let dominantColor = ColorThief.getColor(from: currentImage) else {
                            fatalError("Can't get dominant color")
                        }
                        
                        DispatchQueue.main.async {
                            self.navigationController?.navigationBar.isTranslucent = true
                            self.navigationController?.navigationBar.barTintColor = dominantColor.makeUIColor()
                            
                        }
                    } else {
                        self.imageView.image = self.pickedImage
                        self.infoLabel.text = "Could not get information on flower from Wikipedia."
                    }
                })
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.infoLabel.text = "Connection Issues"
                
            }
        }
        
        self.cancelButton.isHidden = false
        self.addToFlowerListButton.isHidden = false
        self.returnButton.isHidden = true
    }
    
    func makeNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(photoLibaryTapped))
        navigationController?.navigationBar.barTintColor  = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(cameraTapped))
        navigationItem.title = "Find Flower"
    }
    
    
    @objc func cameraTapped() {
        imagePicker.sourceType = .camera
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @objc func photoLibaryTapped() {
        imagePicker.sourceType = .photoLibrary
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

