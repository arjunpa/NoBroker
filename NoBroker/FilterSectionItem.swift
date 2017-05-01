//
//  FilterSectionItem.swift
//  NoBroker
//
//  Created by Arjun P A on 01/05/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class FilterSectionItem: NSObject {

    var displayTitle:String
    var paraName:String
    init(displayTitlePara:String, paraNamePara:String) {
        displayTitle = displayTitlePara
        paraName = paraNamePara
        super.init()
    }
}
