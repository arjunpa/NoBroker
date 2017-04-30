//
//  PropertyModel.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import Foundation
import ObjectMapper

public enum Furnishing:String{
    case FULLY_FURNISHED = "FULLY_FURNISHED"
    case SEMI_FURNISHED = "SEMI_FURNISHED"
    case NOT_FURNISHED = "NOT_FURNISHED"
    
}

class OtherParams:NSObject,Mappable{
    var total_count:Int = 0
    var count:Int = 0
    public override init() {
        super.init()
    }
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total_count <- map["total_count"]
        count <- map["count"]
    }
    
}

class PropertyResultWrapper:NSObject, Mappable{
    
    var data:[PropertyModel] = []
    var otherParams:OtherParams?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        data <- map["data"]
        otherParams <- map["otherParams"]
    }
    class func mappedFrom(JSON:Any?) -> PropertyResultWrapper?{
    
        guard let jsonNotNull = JSON else{return nil}
        return Mapper<PropertyResultWrapper>().map(JSONObject: jsonNotNull)
    }
}

class PropertyModel:NSObject,Mappable{

    var propertyDescription:String?
    var propertyTitle:String?
    var rent:Int?
    var noOfBathrooms:Int?
    var street:String?
    var locality:String?
    var furnishing:Furnishing?
    public override init() {
        super.init()
    }
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        propertyDescription <- map["description"]
        rent <- map["rent"]
        propertyTitle <- map["propertyTitle"]
        noOfBathrooms <- map["bathroom"]
        street <- map["street"]
        locality <- map["locality"]
        furnishing <- (map["furnishing"], EnumTransform<Furnishing>())
    }
}
