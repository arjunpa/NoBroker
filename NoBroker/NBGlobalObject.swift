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
    var mockService:ServiceProtocol.Type{
        get set
    }
    
    var imageManager:ImageManagerProtocol{
        get set
    }
    
}

struct NBGlobalAttributes{
    var networkService:NetworkServiceProtocol?
    var mockService:ServiceProtocol.Type?
    var imageManager:ImageManagerProtocol?
    init?(networkService:NetworkServiceProtocol?, service:ServiceProtocol.Type?, imageManagerPara:ImageManager?) {
        if networkService == nil && service == nil{return nil}
        self.networkService = networkService
        self.mockService = service
        self.imageManager = imageManagerPara
    }
}
class NBGlobalObject:NBGlobalInstanceProtocol {
    internal var _imageManager: ImageManagerProtocol?
    var imageManager: ImageManagerProtocol{
        get{
            return _imageManager!
        }
        set{
            _imageManager = newValue
        }
    }
  
    fileprivate var _networkService:NetworkServiceProtocol?
    internal var _mockService:ServiceProtocol.Type?
    internal var networkService: NetworkServiceProtocol{
        get{
            return _networkService!
        }
        
        set{
            _networkService = newValue
        }
    }
    
    internal var mockService: ServiceProtocol.Type{
        get{
            return _mockService!
        }
        set{
            _mockService = newValue
        }
    }
  
    
    init(attributes:NBGlobalAttributes?) {
        guard let attributesNotNil = attributes else {
            let networkServiceDefault = NBDefaultNetworkService.init()
            _networkService = networkServiceDefault
            _mockService = MockService.self
            _imageManager = ImageManager.init(mockService: _mockService)
            return
        }
        
        if attributesNotNil.networkService == nil{
            let networkServiceDefault = NBDefaultNetworkService.init()
            _networkService = networkServiceDefault
        
        }
        else{
            _networkService = attributesNotNil.networkService
        }
        
        if attributesNotNil.mockService == nil{
            _mockService = MockService.self
        }
        else{
            _mockService = attributesNotNil.mockService
        }
        
        if attributesNotNil.imageManager == nil{
            _imageManager = ImageManager.init(mockService: _mockService)
        }
        else{
            _imageManager = attributesNotNil.imageManager
        }
    }
    
    
}
