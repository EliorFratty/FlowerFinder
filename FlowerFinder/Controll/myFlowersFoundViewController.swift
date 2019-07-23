//
//  myFlowersFoundViewController.swift
//  FlowerFinder
//
//  Created by User on 07/05/2019.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit
import CoreData

class myFlowersFoundViewController: UIViewController {
    
    private let persistenceManager: PersistenceManager
    
    private var flowers = [Flower]()
    private let cellID = "FlowerCell"
    private var searchedFlower = [Flower]()
    private var searching = false
    
    init(persistenceManager: PersistenceManager) {
        self.persistenceManager = persistenceManager
        super.init(nibName: nil, bundle: nil)
    }
    
    private let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        
        return sb
    }()
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.register(FlowerCell.self, forCellReuseIdentifier: cellID)
        tb.backgroundColor = .white
        tb.keyboardDismissMode = .onDrag
        
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(searchBar)

        NavigationBarAnchor()
        SearchBarAnchor()
        TableViewAnchor()
        
        flowers.sort { (f1, f2) -> Bool in
            if let date1 = f1.date, let date2 = f2.date {
                return date1 < date2
            } else {
                return false
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        flowers = persistenceManager.fetch(Flower.self)
        tableView.reloadData()
    }
    
    func NavigationBarAnchor() {
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        navigationController?.navigationBar.barStyle = .blackTranslucent
        self.title = "My Flowers"
        
        let addFlowerButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:  #selector(addFlowerTapped) )
        navigationItem.rightBarButtonItem = addFlowerButton
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentQRScanningScreen))
//        navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc func addFlowerTapped() {
        let addFlowerViewController = AddFlowerViewController()
       navigationController?.pushViewController(addFlowerViewController, animated: true)

    }
    
    func SearchBarAnchor() {
        
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive =  true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func TableViewAnchor() {
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Table view data source

extension myFlowersFoundViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedFlower.count
        } else {
            return flowers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! FlowerCell
        
        let flower: Flower
        
        if searching {
            flower = searchedFlower[indexPath.row]
        } else {
            flower = flowers[indexPath.row]
        }
        
        cell.flower = flower
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let flowerClicked: Flower
        
        if searching {
            flowerClicked = searchedFlower[indexPath.row]
            
        } else {
            flowerClicked = flowers[indexPath.row]
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        let flowerDetails = FlowerDetailsViewController(flowerClicked)
        
        navigationController?.pushViewController(flowerDetails, animated: true)
    }
}

// MARK: - Search Bar Functions

extension myFlowersFoundViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedFlower = flowers.filter({$0.name!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
