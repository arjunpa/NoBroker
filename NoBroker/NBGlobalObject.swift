//
//  NBGlobalObject.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

protocol NBGlobalInstanceProtocol{
    var networkService:NetworkServiceProtocol{
        get set
    }
}

struct NBGlobalAttributes{
    var networkService:NetworkServiceProtocol?
    
    init(networkService:NetworkServiceProtocol?) {
        self.networkService = networkService
    }
}
class NBGlobalObject:NBGlobalInstanceProtocol {
  
    internal var _networkService:NetworkServiceProtocol?
    internal var networkService: NetworkServiceProtocol{
        get{
            return _networkService!
        }
        
        set{
            _networkService = newValue
        }
    }
    
  
    
    init(attributes:NBGlobalAttributes?) {
        guard let attributesNotNil = attributes else {
            let networkServiceDefault = NBDefaultNetworkService.init()
            _networkService = networkServiceDefault
            return
        }
        
        if attributesNotNil.networkService == nil{
            let networkServiceDefault = NBDefaultNetworkService.init()
            _networkService = networkServiceDefault
        
        }
        else{
            _networkService = attributesNotNil.networkService
        }
    }
    
    
}
