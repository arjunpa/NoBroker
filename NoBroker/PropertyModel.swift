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

class PropertyPhoto:NSObject, Mappable{
    var thumbnailImageKey:String?
    var mediumImageKey:String?
    var originalImageKey:String?
    var largeImageKey:String?
    let transform = TransformOf<String,String>.init(fromJSON: { (keyd:String?) -> String? in
        guard let key = keyd else{return nil}
        let separated:[String] = key.components(separatedBy: "_")
        if separated.count < 3{
            return nil
        }
        return separated.first! + "/" + separated.joined(separator: "_")
        
    }) { (keyd:String?) -> String? in
        guard let key = keyd else{return nil}
        let separated:[String] = key.components(separatedBy: "/")
        if separated.count > 2{
            return separated[1]
        }
        return nil
    }
    required init?(map: Map) {
        
    }
    public override init() {
        super.init()
    }
    func mapping(map: Map) {
        thumbnailImageKey <- (map["imagesMap.thumbnail"],transform)
        mediumImageKey <- (map["imagesMap.medium"], transform)
        originalImageKey <- (map["imagesMap.original"], transform)
        largeImageKey <- (map["imagesMap.large"], transform)
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
    var photos:[PropertyPhoto] = []
    var propertySize:Int?
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
        photos <- map["photos"]
        propertySize <- map["propertySize"]
    }
}
