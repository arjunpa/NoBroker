//
//  PropertyListPager.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class PropertyListPager: NSObject {
    
    fileprivate var _page:Int = -1
    fileprivate var _isPaging:Bool = false
    fileprivate var _nbObject:NBGlobalInstanceProtocol
    fileprivate var serviceType:ServiceProtocol.Type
    fileprivate static let defaultParams:Dictionary<String,Any> = ["lat_lng":"12.9279232,77.6271078", "rent":"0,500000","travelTime":30]
    typealias COMPLETION = ([PropertyModel]?, Error?) -> ()
    var page:Page
    var completion:COMPLETION?
    init(nbObject:NBGlobalInstanceProtocol, serviceConstants:ServiceProtocol.Type = MockService.self) {
        _nbObject = nbObject
        serviceType = serviceConstants
        page = Page.init()
        super.init()
    }
    
    func pageNext(filters:Dictionary<String,Any>? = nil){
        if page.status == .PAGING || page.status == .LAST_PAGE{
            return
        }
        page.next()
        let defaultParams = PropertyListPager.defaultParams
        var params:Dictionary<String, Any> = defaultParams.mergedWith(otherDictionary: filters ?? [:])
        params["pageNo"] = page._no
        self._nbObject.networkService.getAPI(url: serviceType.baseURL, params: params, headers: nil) {[weak self] (result, error) in
            guard let weakSelf = self else{return}
            let strongSelf = weakSelf
            if let someError = error{
                strongSelf.page.processError(error: someError)
            }
            else{
                
                let wrapper = PropertyResultWrapper.mappedFrom(JSON: result)
                DispatchQueue.main.async(execute: {
                    strongSelf.completion?(wrapper?.data, error)
                    
                })
                
                strongSelf.page.setTotalCount(total: wrapper?.otherParams?.total_count)
                strongSelf.page.processCount(resultCount: wrapper?.data.count)
                
            }
        }
    }
    
    
    
}
