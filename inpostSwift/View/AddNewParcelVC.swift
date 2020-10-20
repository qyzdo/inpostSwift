//
//  AddNewParcelVC.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 20/10/2020.
//

import UIKit

class AddNewParcelVC: UIViewController {
    let apiCaller = ApiCaller()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(setNumberLabel)
        stackView.addArrangedSubview(numberTextField)
        stackView.addArrangedSubview(addButton)
        numberTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, constant: -50).isActive = true
        numberTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        numberTextField.becomeFirstResponder()
    }

    let numberTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Numer przesyłki"
        textField.backgroundColor = .systemGray5
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.keyboardType = .decimalPad
        
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always

        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.rightViewMode = .always
        
        return textField
    }()
    
    let setNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Wprowadź numer przesyłki"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        return stackView
    }()
    
    let addButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.setTitle("Dodaj paczkę", for: .normal)
        button.addTarget(self, action: #selector(addNewParcel), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc func addNewParcel() {
        if let trackingNumber = numberTextField.text {
            apiCaller.getData(trackingNumber: trackingNumber) { result in
                switch result {
                case .success(let parcel):
                    print(parcel)
                case .failure(let error):
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Błąd dodawania przesyłki", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
