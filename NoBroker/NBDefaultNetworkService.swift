//
//  NBDefaultAPIService.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import Alamofire
class NBDefaultNetworkService: NetworkServiceProtocol {
    internal func getAPI(url: String, params: [String : Any], headers: [String : String]?, completion: @escaping (Any?, Error?) -> Void) {
        
        self.apiCall(url: url, method: HTTPMethod.get, params: params, headers: headers, completion: completion)
    }
    
    func postAPI(url:String, params:[String:Any], headers:[String:String]?, completion:@escaping (_ result:Any?, _ error:Error?) -> Void){
         self.apiCall(url: url, method: HTTPMethod.post, params: params, headers: headers, completion: completion)
    }
    
    internal func apiCall(url: String, method:HTTPMethod, params: [String : Any], headers: [String : String]?, completion: @escaping (Any?, Error?) -> Void) {
    
        Alamofire
            .request(url, method: HTTPMethod.get, parameters: params, encoding:URLEncoding.default, headers: headers)
            .responseJSON { (dataResponse:DataResponse<Any>) in
                
                completion(dataResponse.result.value, dataResponse.result.error)
        }
    
    }

}
