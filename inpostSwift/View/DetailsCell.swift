//
//  DetailsCell.swift
//  inpostSwift
//
//  Created by Oskar Figiel on 23/07/2020.
//

import Foundation
import UIKit

class DetailsCell : UITableViewCell {
    
    let statusLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let originStatusLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.text = "STATUS"
        return lbl
    }()

    
    let dateTimeLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.text = "NR PRZESYŁKI"
        return lbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(dateTimeLabel)
        addSubview(originStatusLabel)
        addSubview(statusLabel)

        statusLabel.anchor(top: topAnchor, left: leftAnchor, bottom: originStatusLabel.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        originStatusLabel.anchor(top: statusLabel.bottomAnchor, left: leftAnchor, bottom: dateTimeLabel.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        dateTimeLabel.anchor(top: originStatusLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
