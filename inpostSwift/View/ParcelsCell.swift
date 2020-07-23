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
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.text = "NR PRZESYŁKI"
        return lbl
    }()
    
    let trackingNumberLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    let statusTextLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.text = "STATUS"
        return lbl
    }()
    
    let statusLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(trackingNumberTextLabel)
        addSubview(trackingNumberLabel)
        addSubview(statusTextLabel)
        addSubview(statusLabel)
        
        trackingNumberTextLabel.anchor(top: topAnchor, left: leftAnchor, bottom: trackingNumberLabel.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        trackingNumberLabel.anchor(top: trackingNumberTextLabel.bottomAnchor, left: leftAnchor, bottom: statusTextLabel.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        statusTextLabel.anchor(top: trackingNumberLabel.bottomAnchor, left: leftAnchor, bottom: statusLabel.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        statusLabel.anchor(top: statusTextLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
