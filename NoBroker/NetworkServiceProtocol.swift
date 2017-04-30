//
//  APIServiceProtocol.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol {
    
    func getAPI(url:String, params:[String:Any], headers:[String:String]?, completion:@escaping (_ result:Any?, _ error:Error?) -> Void)
    func postAPI(url:String, params:[String:Any], headers:[String:String]?, completion:@escaping (_ result:Any?, _ error:Error?) -> Void)
    
}
