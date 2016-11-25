//
//  MainCell.swift
//  FoodRound
//
//  Created by Chang sean on 2016/10/19.
//  Copyright © 2016年 Chang sean. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    var StoreImage:   UIImageView!
    var TitleLabel:   UILabel!
    var AddressLabel: UILabel!
    var TypeLabel:    UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let favVC = FavMainViewController()
        let tableBounds = favVC.tableView.bounds
        
        StoreImage.widthAnchor.constraint(equalToConstant: (tableBounds.height / 8) * 0.7).isActive = true
        StoreImage.heightAnchor.constraint(equalToConstant: (tableBounds.height / 8) * 0.7).isActive = true
        StoreImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: UIScreen.main.bounds.width * 0.03).isActive = true
        StoreImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        TitleLabel.leftAnchor.constraint(equalTo: StoreImage.rightAnchor, constant: UIScreen.main.bounds.width * 0.03).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: (tableBounds.height / 8) * 0.025).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: (tableBounds.height / 8) * 0.3).isActive = true
        
        AddressLabel.leftAnchor.constraint(equalTo: TitleLabel.leftAnchor).isActive = true
        AddressLabel.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: (tableBounds.height / 8) * 0.025).isActive = true
        AddressLabel.heightAnchor.constraint(equalToConstant: (tableBounds.height / 8) * 0.3).isActive = true
        
        TypeLabel.leftAnchor.constraint(equalTo: TitleLabel.leftAnchor).isActive = true
        TypeLabel.topAnchor.constraint(equalTo: AddressLabel.bottomAnchor, constant: (tableBounds.height / 8) * 0.025).isActive = true
        TypeLabel.heightAnchor.constraint(equalToConstant: (tableBounds.height / 8) * 0.3).isActive = true
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
