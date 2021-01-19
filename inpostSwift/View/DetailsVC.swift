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
        
        trackingDetailsArray = (parcel?.tracking_details)!
        setupUI()
    }
    
    let parcelView : UIView = {
        let view = UIView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = 15
        return view
    }()
    
    let lockersView : UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.spacing = 5
        return view
    }()
    
    func setupUI() {
        self.title = parcel?.tracking_number
        view.backgroundColor = .systemBackground
        safeArea = view.layoutMarginsGuide
        setupParcelView()
        setupLockersView()
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: lockersView.bottomAnchor, constant: 5).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 5).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailsCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupParcelView() {
        view.addSubview(parcelView)
        
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = "Nr przesyłki"
        
        let lbl2 = UILabel()
        lbl2.textColor = .black
        lbl2.font = UIFont.systemFont(ofSize: 15)
        lbl2.textAlignment = .center
        lbl2.numberOfLines = 1
        lbl2.text = parcel?.tracking_number
        
        let lbl3 = UILabel()
        lbl3.textColor = .black
        lbl3.font = UIFont.boldSystemFont(ofSize: 15)
        lbl3.textAlignment = .center
        lbl3.numberOfLines = 1
        lbl3.text = "Status"
        
        let lbl4 = UILabel()
        lbl4.textColor = .black
        lbl4.font = UIFont.systemFont(ofSize: 15)
        lbl4.textAlignment = .center
        lbl4.numberOfLines = 1
        lbl4.text = parcel?.status?.statusRefactor()
        
        let lbl5 = UILabel()
        lbl5.textColor = .black
        lbl5.font = UIFont.boldSystemFont(ofSize: 15)
        lbl5.textAlignment = .center
        lbl5.numberOfLines = 1
        lbl5.text = "Rozmiar"
        
        let lbl6 = UILabel()
        lbl6.textColor = .black
        lbl6.font = UIFont.systemFont(ofSize: 15)
        lbl6.textAlignment = .center
        lbl6.numberOfLines = 1
        lbl6.text = parcel?.custom_attributes?.size
        
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        parcelView.addSubview(stackView)
        
        stackView.addArrangedSubview(lbl)
        stackView.addArrangedSubview(lbl2)
        stackView.addArrangedSubview(lbl3)
        stackView.addArrangedSubview(lbl4)
        stackView.addArrangedSubview(lbl5)
        stackView.addArrangedSubview(lbl6)
        
        parcelView.translatesAutoresizingMaskIntoConstraints = false
        parcelView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        parcelView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: parcelView.topAnchor, constant: 15).isActive = true
        stackView.bottomAnchor.constraint(equalTo: parcelView.bottomAnchor, constant: -15).isActive = true
        stackView.leftAnchor.constraint(equalTo: parcelView.leftAnchor, constant: 15).isActive = true
        stackView.rightAnchor.constraint(equalTo: parcelView.rightAnchor, constant: -15).isActive = true
    }
    
    func setupLockersView() {
        view.addSubview(lockersView)
        lockersView.translatesAutoresizingMaskIntoConstraints = false
        lockersView.topAnchor.constraint(equalTo: parcelView.bottomAnchor, constant: 10).isActive = true
        lockersView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 5).isActive = true
        lockersView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -5).isActive = true
        
        
        let targetLockerLabel = UILabel()
        targetLockerLabel.textColor = .black
        targetLockerLabel.font = UIFont.boldSystemFont(ofSize: 15)
        targetLockerLabel.textAlignment = .center
        targetLockerLabel.numberOfLines = 0
        targetLockerLabel.text = "Paczkomat odbiorcy"
        
        let targetLockerID = UILabel()
        targetLockerID.textColor = .black
        targetLockerID.font = UIFont.systemFont(ofSize: 15)
        targetLockerID.textAlignment = .center
        targetLockerID.numberOfLines = 0
        targetLockerID.text = parcel?.custom_attributes?.target_machine_id
        
        let targetLockerAddres1 = UILabel()
        targetLockerAddres1.textColor = .black
        targetLockerAddres1.font = UIFont.systemFont(ofSize: 15)
        targetLockerAddres1.textAlignment = .center
        targetLockerAddres1.numberOfLines = 0
        targetLockerAddres1.text = parcel?.custom_attributes?.target_machine_detail?.address?.line1
        
        let targetLockerAddres2 = UILabel()
        targetLockerAddres2.textColor = .black
        targetLockerAddres2.font = UIFont.systemFont(ofSize: 15)
        targetLockerAddres2.textAlignment = .center
        targetLockerAddres2.numberOfLines = 0
        targetLockerAddres2.text = parcel?.custom_attributes?.target_machine_detail?.address?.line2
        
        let targetLockerDescription = UILabel()
        targetLockerDescription.textColor = .black
        targetLockerDescription.font = UIFont.systemFont(ofSize: 15)
        targetLockerDescription.textAlignment = .center
        targetLockerDescription.numberOfLines = 0
        targetLockerDescription.text = parcel?.custom_attributes?.target_machine_detail?.location_description
        
        
        let targetLockerView = UIView()
        targetLockerView.backgroundColor = .systemYellow
        targetLockerView.layer.cornerRadius = 15
        
        
        let targetLockerStackView = UIStackView()
        targetLockerStackView.alignment = .center
        targetLockerStackView.axis = .vertical
        targetLockerStackView.distribution = .equalSpacing
        targetLockerStackView.spacing = 5
        
        targetLockerStackView.addArrangedSubview(targetLockerLabel)
        targetLockerStackView.addArrangedSubview(targetLockerID)
        targetLockerStackView.addArrangedSubview(targetLockerAddres1)
        targetLockerStackView.addArrangedSubview(targetLockerAddres2)
        targetLockerStackView.addArrangedSubview(targetLockerDescription)
        
        targetLockerView.addSubview(targetLockerStackView)
        
        targetLockerStackView.translatesAutoresizingMaskIntoConstraints = false
        targetLockerStackView.topAnchor.constraint(equalTo: targetLockerView.topAnchor, constant: 10).isActive = true
        targetLockerStackView.bottomAnchor.constraint(equalTo: targetLockerView.bottomAnchor, constant: -10).isActive = true
        targetLockerStackView.leftAnchor.constraint(equalTo: targetLockerView.leftAnchor, constant: 10).isActive = true
        targetLockerStackView.rightAnchor.constraint(equalTo: targetLockerView.rightAnchor, constant: -10).isActive = true
        
        let dropOffLockerLabel = UILabel()
        dropOffLockerLabel.textColor = .black
        dropOffLockerLabel.font = UIFont.boldSystemFont(ofSize: 15)
        dropOffLockerLabel.textAlignment = .center
        dropOffLockerLabel.numberOfLines = 0
        dropOffLockerLabel.text = "Paczkomat nadawcy"
        
        let dropOffLockerID = UILabel()
        dropOffLockerID.textColor = .black
        dropOffLockerID.font = UIFont.systemFont(ofSize: 15)
        dropOffLockerID.textAlignment = .center
        dropOffLockerID.numberOfLines = 0
        dropOffLockerID.text = parcel?.custom_attributes?.dropoff_machine_id
        
        let dropOffLockerAddres1 = UILabel()
        dropOffLockerAddres1.textColor = .black
        dropOffLockerAddres1.font = UIFont.systemFont(ofSize: 15)
        dropOffLockerAddres1.textAlignment = .center
        dropOffLockerAddres1.numberOfLines = 0
        dropOffLockerAddres1.text = parcel?.custom_attributes?.dropoff_machine_detail?.address?.line1
        
        let dropOffLockerAddres2 = UILabel()
        dropOffLockerAddres2.textColor = .black
        dropOffLockerAddres2.font = UIFont.systemFont(ofSize: 15)
        dropOffLockerAddres2.textAlignment = .center
        dropOffLockerAddres2.numberOfLines = 0
        dropOffLockerAddres2.text = parcel?.custom_attributes?.dropoff_machine_detail?.address?.line2
        
        let dropOffLockerDescription = UILabel()
        dropOffLockerDescription.textColor = .black
        dropOffLockerDescription.font = UIFont.systemFont(ofSize: 15)
        dropOffLockerDescription.textAlignment = .center
        dropOffLockerDescription.numberOfLines = 0
        dropOffLockerDescription.text = parcel?.custom_attributes?.dropoff_machine_detail?.location_description
        
        let dropOffLockerView = UIView()
        dropOffLockerView.backgroundColor = .systemYellow
        dropOffLockerView.layer.cornerRadius = 15
        
        
        let dropOffLockerStackView = UIStackView()
        dropOffLockerStackView.alignment = .center
        dropOffLockerStackView.axis = .vertical
        dropOffLockerStackView.distribution = .equalSpacing
        dropOffLockerStackView.spacing = 5
        
        dropOffLockerStackView.addArrangedSubview(dropOffLockerLabel)
        dropOffLockerStackView.addArrangedSubview(dropOffLockerID)
        dropOffLockerStackView.addArrangedSubview(dropOffLockerAddres1)
        dropOffLockerStackView.addArrangedSubview(dropOffLockerAddres2)
        dropOffLockerStackView.addArrangedSubview(dropOffLockerDescription)
        
        
        dropOffLockerView.addSubview(dropOffLockerStackView)
        
        dropOffLockerStackView.translatesAutoresizingMaskIntoConstraints = false
        dropOffLockerStackView.topAnchor.constraint(equalTo: dropOffLockerView.topAnchor, constant: 10).isActive = true
        dropOffLockerStackView.bottomAnchor.constraint(equalTo: dropOffLockerView.bottomAnchor, constant: -10).isActive = true
        dropOffLockerStackView.leftAnchor.constraint(equalTo: dropOffLockerView.leftAnchor, constant: 10).isActive = true
        dropOffLockerStackView.rightAnchor.constraint(equalTo: dropOffLockerView.rightAnchor, constant: -10).isActive = true
        
        lockersView.addArrangedSubview(targetLockerView)
        lockersView.addArrangedSubview(dropOffLockerView)
        
        targetLockerView.heightAnchor.constraint(equalTo: dropOffLockerView.heightAnchor, constant: 0).isActive = true
    }
    
}

extension DetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (parcel?.tracking_details!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailsCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let date = dateFormatter.date(from:trackingDetailsArray[indexPath.row].datetime!)
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateChanged = dateFormatter.string(from: date!)
        cell.dateTimeLabel.text = dateChanged
        
        cell.statusLabel.text = trackingDetailsArray[indexPath.row].status!.statusRefactor()
        cell.originStatusLabel.text = trackingDetailsArray[indexPath.row].origin_status
        return cell
    }
    
}
