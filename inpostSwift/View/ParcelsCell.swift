//
//  CustomCell.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 12/07/2020.
//

import Foundation
import UIKit

class ParcelsCell : UITableViewCell {
    let trackingNumberTextLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.text = "NR PRZESYŁKI"
        return lbl
    }()
    
    let trackingNumberLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let statusTextLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.text = "STATUS"
        return lbl
    }()
    
    let statusLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let customContentView: UIView = {
        let lbl = UIView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(customContentView)
        customContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        customContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        customContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        customContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        customContentView.addSubview(trackingNumberTextLabel)
        customContentView.addSubview(trackingNumberLabel)
        customContentView.addSubview(statusTextLabel)
        customContentView.addSubview(statusLabel)
        
        trackingNumberTextLabel.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 0).isActive = true
        
        trackingNumberTextLabel.leftAnchor.constraint(equalTo: customContentView.leftAnchor, constant: 0).isActive = true
        
        trackingNumberTextLabel.rightAnchor.constraint(equalTo: customContentView.rightAnchor, constant: 0).isActive = true
        
        trackingNumberLabel.topAnchor.constraint(equalTo: trackingNumberTextLabel.bottomAnchor, constant: 0).isActive = true
        trackingNumberLabel.leftAnchor.constraint(equalTo: customContentView.leftAnchor, constant: 0).isActive = true
        trackingNumberLabel.rightAnchor.constraint(equalTo: customContentView.rightAnchor, constant: 0).isActive = true
        
        statusTextLabel.topAnchor.constraint(equalTo: trackingNumberLabel.bottomAnchor, constant: 0).isActive = true
        statusTextLabel.leftAnchor.constraint(equalTo: customContentView.leftAnchor, constant: 0).isActive = true
        statusTextLabel.rightAnchor.constraint(equalTo: customContentView.rightAnchor, constant: 0).isActive = true
        
        statusLabel.topAnchor.constraint(equalTo: statusTextLabel.bottomAnchor, constant: 0).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: customContentView.leftAnchor, constant: 0).isActive = true
        statusLabel.rightAnchor.constraint(equalTo: customContentView.rightAnchor, constant: 0).isActive = true
        statusLabel.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
