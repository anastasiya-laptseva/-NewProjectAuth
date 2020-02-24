//
//  CodeTableViewCell.swift
//  NewProjectAuth
//
//  Created by Anastasiya Laptseva on 2/18/20.
//  Copyright © 2020 Anastasiya Laptseva. All rights reserved.
//

import UIKit

class CodeTableViewCell: UITableViewCell {

    static let id = "CodeTableView Cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
//        backgroundColor = .red
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
