//
//  TableViewCell.swift
//  TestGenesis
//
//  Created by Ваге Базикян on 13.10.2020.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = nil
        self.contentView.backgroundColor = .systemBackground
    }
        
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
