//
//  ViewController.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 12/07/2020.
//

import UIKit
import Lottie

class MainVC: UIViewController, MyDataSendingDelegateProtocol {
    
    let tableView = UITableView()
    var parcelsArray = [ParcelModel]()
    let button = UIButton(type: .system)
    let animationView = AnimationView(name: "box")
    let label = UILabel()
    let defaults = UserDefaults.standard
    
    var trackingNumbers = [String]()
    let apiCaller = ApiCaller()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func foundedNewParcel(parcel: ParcelModel) {
        self.trackingNumbers.append(parcel.tracking_number!)
        addNewParcel(parcel: parcel)
        saveData()
    }
    
    func addNewParcel(parcel: ParcelModel) {
        self.parcelsArray.append(parcel)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavbar()
        setupUI()
    }
    
    func setupNavbar() {
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isTranslucent = true
        navigationBar?.barTintColor = .systemYellow
        self.title = "Moje przesyłki"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Dodaj", style: .done, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked() {
        let vc = AddNewParcelVC()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        if(UserDefaults.standard.bool(forKey: "HasLaunchedOnce") == false) {
            setupTableView()
            setupOnboardingScreen()
        } else {
            setupTableView()
        }
    }
    
    func setupOnboardingScreen() {
        tableView.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.play()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemYellow
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        label.text = "Witaj w aplikacji inpost!"
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5).isActive = true
        label.widthAnchor.constraint(equalToConstant: 350).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.topAnchor.constraint(greaterThanOrEqualTo: label.bottomAnchor, constant: 5).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemYellow
        button.setTitle(" Kliknij tutaj i zacznij korzystać z aplikacji! ", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.addTarget(self, action: #selector(finishOnboardingScreenClicked), for: .touchUpInside)
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 5).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 350).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func hideOnboardingScreen() {
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
            self.label.alpha = 0
            self.animationView.alpha = 0
            self.button.alpha = 0
            
        }, completion: { finished in
            self.label.isHidden = true
            self.animationView.isHidden = true
            self.button.isHidden = true
        })
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
            self.navigationController?.navigationBar.alpha = 0
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.navigationBar.alpha = 1
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
            self.tableView.alpha = 0
            self.tableView.isHidden = false
            self.tableView.alpha = 1
        })
        
    }
    
    @objc func finishOnboardingScreenClicked() {
        UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
        hideOnboardingScreen()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ParcelsCell.self, forCellReuseIdentifier: "ParcelsCell")
    }
    
    func saveData() {
        defaults.set(trackingNumbers, forKey: "SavedArray")
    }
    
    func loadData() {
        if let array = defaults.object(forKey: "SavedArray") {
            trackingNumbers = array as! [String]
            if trackingNumbers.count > 0 {
                fetchData()
            }
        }
    }
    
    func fetchData() {
        parcelsArray.removeAll()
        for i in 0...trackingNumbers.count - 1 {
            apiCaller.getData(trackingNumber: trackingNumbers[i]) {result in
                switch result {
                case .success(let parcel):
                    self.addNewParcel(parcel: parcel)
                case .failure( _):
                    self.addNewParcel(parcel: ParcelModel.createEmptyParcel(number: self.trackingNumbers[i]))
                }
            }
        }
    }
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parcelsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParcelsCell", for: indexPath) as! ParcelsCell
        cell.trackingNumberLabel.text = parcelsArray[indexPath.row].tracking_number
        if let status = parcelsArray[indexPath.row].status {
            cell.statusLabel.text = status.statusRefactor()
        } else {
            cell.statusLabel.text = "Błędny numer przesyłki"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if parcelsArray[indexPath.row].status != nil {
            let vc = DetailsVC()
            vc.parcel = parcelsArray[indexPath.row]
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            trackingNumbers.remove(at: indexPath.row)
            parcelsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
}
