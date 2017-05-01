//
//  FilterSection.swift
//  NoBroker
//
//  Created by Arjun P A on 01/05/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class FilterSection: NSObject {

    var header:String
    var paramName:String
    var items:[FilterSectionItem] = []
    
    init(headerPara:String, param:String) {
        header = headerPara
        self.paramName = param
        super.init()
    }
    
    func addItem(item:FilterSectionItem){
        self.items.append(item)
    }
    
}


