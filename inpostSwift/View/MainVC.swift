//
//  ViewController.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 12/07/2020.
//

import UIKit

class MainVC: UIViewController {
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var parcelsList = [ParcelModel]()

    var trackingNumbers = ["687100708024170011003255", "687100218024170137482623"]
    let apiCaller = ApiCaller()
    
    override func viewDidLoad() {
        for i in 0...trackingNumbers.count - 1 {
            apiCaller.getData(trackingNumber: trackingNumbers[i]) {(parcel: ParcelModel) in
                self.parcelsList.append(parcel)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .gray
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parcelsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.trackingNumberLabel.text = parcelsList[indexPath.row].tracking_number
        cell.statusLabel.text = parcelsList[indexPath.row].status!.statusRefactor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    
    
}
