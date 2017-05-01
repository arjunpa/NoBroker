//
//  FilterItemHeaderCell.swift
//  NoBroker
//
//  Created by Arjun P A on 01/05/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class FilterItemHeaderCell: UICollectionReusableView {

    @IBOutlet weak var headerTitle:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(filterSection:FilterSection){
        self.headerTitle.text = filterSection.header
    }
    
}
