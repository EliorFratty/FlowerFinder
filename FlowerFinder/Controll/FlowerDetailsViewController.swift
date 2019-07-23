//
//  FlowerDetailsViewController.swift
//  FlowerFinder
//
//  Created by User on 07/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class FlowerDetailsViewController: UIViewController {

    private var flower: Flower
    
    init(_ flower: Flower) {
        self.flower = flower
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var flowerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.loadImageUsingCatchWithUrlString(URLString: flower.imageUrl ?? "X")
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let flowerDetailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private let flowerNameLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 30.0)
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    private let flowerGenreLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 20.0)
        lb.text = "Details: "
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    private let genreSepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let flowerRatingLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 20.0)
        lb.text = "Location: "
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    private let ratingSepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let flowerReleaseYearLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = UIFont(name: "Arial", size: 20.0)
        lb.text = "Date: "
        
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        view.addSubview(flowerImage)
        view.addSubview(flowerNameLabel)
        view.addSubview(flowerDetailsContainerView)
        
        flowerImageAnchor()
        flowerNameLabelAnchor()
        flowerDetailsContainerViewAnchor()
        self.title = "Details"
        
        
    }
    
    func flowerImageAnchor() {
        flowerImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12) .isActive = true
        flowerImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12).isActive = true
        flowerImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        flowerImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func flowerNameLabelAnchor() {
        flowerNameLabel.text = flower.name
        
        flowerNameLabel.leftAnchor.constraint(equalTo: flowerImage.rightAnchor, constant: 5) .isActive = true
        flowerNameLabel.topAnchor.constraint(equalTo: flowerImage.topAnchor).isActive = true
        flowerNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5) .isActive = true
        flowerNameLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func flowerDetailsContainerViewAnchor(){
        flowerDetailsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        flowerDetailsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        flowerDetailsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        flowerDetailsContainerView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        flowerDetailsContainerView.addSubview(flowerGenreLabel)
        flowerDetailsContainerView.addSubview(flowerRatingLabel)
        flowerDetailsContainerView.addSubview(ratingSepratorView)
        flowerDetailsContainerView.addSubview(flowerReleaseYearLabel)
        flowerDetailsContainerView.addSubview(genreSepratorView)
        
        flowerGenreLabel.leftAnchor.constraint(equalTo: flowerDetailsContainerView.leftAnchor, constant: 12).isActive = true
        flowerGenreLabel.topAnchor.constraint(equalTo: flowerDetailsContainerView.topAnchor).isActive = true
        flowerGenreLabel.widthAnchor.constraint(equalTo: flowerDetailsContainerView.widthAnchor, constant: -24).isActive = true
        flowerGenreLabel.heightAnchor.constraint(equalTo: flowerDetailsContainerView.heightAnchor, multiplier: 5/7).isActive = true
        
        genreSepratorView.leftAnchor.constraint(equalTo: flowerDetailsContainerView.leftAnchor).isActive = true
        genreSepratorView.topAnchor.constraint(equalTo: flowerGenreLabel.bottomAnchor).isActive = true
        genreSepratorView.widthAnchor.constraint(equalTo: flowerDetailsContainerView.widthAnchor).isActive = true
        genreSepratorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        flowerRatingLabel.leftAnchor.constraint(equalTo: flowerDetailsContainerView.leftAnchor, constant: 12).isActive = true
        flowerRatingLabel.topAnchor.constraint(equalTo: genreSepratorView.topAnchor).isActive = true
        flowerRatingLabel.widthAnchor.constraint(equalTo: flowerDetailsContainerView.widthAnchor, constant: -24).isActive = true
        flowerRatingLabel.heightAnchor.constraint(equalTo: flowerDetailsContainerView.heightAnchor, multiplier: 1/7).isActive = true
        
        ratingSepratorView.leftAnchor.constraint(equalTo: flowerDetailsContainerView.leftAnchor).isActive = true
        ratingSepratorView.topAnchor.constraint(equalTo: flowerRatingLabel.bottomAnchor).isActive = true
        ratingSepratorView.widthAnchor.constraint(equalTo: flowerDetailsContainerView.widthAnchor).isActive = true
        ratingSepratorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        flowerReleaseYearLabel.leftAnchor.constraint(equalTo: flowerDetailsContainerView.leftAnchor, constant: 12).isActive = true
        flowerReleaseYearLabel.topAnchor.constraint(equalTo: ratingSepratorView.topAnchor).isActive = true
        flowerReleaseYearLabel.widthAnchor.constraint(equalTo: flowerDetailsContainerView.widthAnchor, constant: -24).isActive = true
        flowerReleaseYearLabel.heightAnchor.constraint(equalTo: flowerDetailsContainerView.heightAnchor, multiplier: 1/7).isActive = true
        
        flowerNameLabel.text! += flower.name!
        flowerGenreLabel.text! += flower.details!
        flowerReleaseYearLabel.text! += flower.date!.description
        flowerRatingLabel.text! += flower.location!

    }

}
