//
//  Page.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

public enum PagingStatus:Int{
    case NOT_INITIALIZED = 0
    case PAGING = 1
    case NOT_PAGING = 2
    case LAST_PAGE = 3
}
struct Page{
    var status:PagingStatus = PagingStatus.NOT_INITIALIZED
    var _no:Int
    var currentCount:Int = 0
    var totalCount:Int = 0
    init() {
        _no = -1
    }
    
    mutating func processError(error:Error){
        status = PagingStatus.NOT_PAGING
    }
    mutating func processCount(resultCount:Int?){
        guard let resultantCount = resultCount else{processError(error: NSError()); return}
        if status == PagingStatus.LAST_PAGE{
            return
        }
        currentCount += resultantCount
        if currentCount >= totalCount{
            status = PagingStatus.LAST_PAGE
            return
        }
        status = PagingStatus.NOT_PAGING
        
    }
    
    mutating func setTotalCount(total:Int?){
        guard let actualCount = total else{processError(error: NSError()); return}
        totalCount = actualCount
    }
    
    mutating func next(){
        if status == PagingStatus.PAGING || status == PagingStatus.LAST_PAGE{
            return
        }
        status = PagingStatus.PAGING
        _no += 1
    }
    
}
