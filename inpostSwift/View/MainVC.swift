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
    var parcelsArray = [ParcelModel]()
    
    var trackingNumbers = ["687100708024170011003255", "687100218024170137482623", "600441497024170126732236", "642202397024170117575245", "663410197024170119003197", "682300297024170014391380"]
    let apiCaller = ApiCaller()
    
    override func viewDidLoad() {
        for i in 0...trackingNumbers.count - 1 {
            apiCaller.getData(trackingNumber: trackingNumbers[i]) {(parcel: ParcelModel) in
                self.parcelsArray.append(parcel)
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
        tableView.leftAnchor.constraint(equalTo: safeArea.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: safeArea.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ParcelsCell.self, forCellReuseIdentifier: "ParcelsCell")
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parcelsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParcelsCell", for: indexPath) as! ParcelsCell
        cell.trackingNumberLabel.text = parcelsArray[indexPath.row].tracking_number
        cell.statusLabel.text = parcelsArray[indexPath.row].status!.statusRefactor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsVC()
        vc.parcel = parcelsArray[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
