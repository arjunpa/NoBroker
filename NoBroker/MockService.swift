//
//  MockService.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation

protocol ServiceProtocol{
    static var baseURL:String{get}
    static var imageBaseURL:String{get}
}

struct MockService:ServiceProtocol{
    static let baseURL: String = "http://www.nobroker.in/api/v1/property/filter/region/ChIJLfyY2E4UrjsRVq4AjI7zgRY/"
    static let imageBaseURL: String = "http://d3snwcirvb4r88.cloudfront.net/images/"
}
