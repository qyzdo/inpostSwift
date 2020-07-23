//
//  DetailsVC.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 23/07/2020.
//

import UIKit

class DetailsVC: UIViewController {
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var parcel:ParcelModel?
    var trackingDetailsArray = [Tracking_details]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        trackingDetailsArray = (parcel?.tracking_details)!
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
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailsCell.self, forCellReuseIdentifier: "cell")
    }
}
    
    extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (parcel?.tracking_details!.count)!
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsCell
            cell.dateTimeLabel.text = trackingDetailsArray[indexPath.row].datetime
            cell.statusLabel.text = trackingDetailsArray[indexPath.row].status!.statusRefactor()
            cell.originStatusLabel.text = trackingDetailsArray[indexPath.row].origin_status
            return cell
        }
        
    }
