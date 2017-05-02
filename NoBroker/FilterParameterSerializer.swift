//
//  FilterParameterSerializer.swift
//  NoBroker
//
//  Created by Arjun P A on 01/05/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit



class FilterParameterSerializer: NSObject, NSCopying {
    fileprivate var mapping:[IndexPath:Dictionary<String,Any>] = [:]
    
    func manageSelection(indexPath:IndexPath, section:FilterSection, item:FilterSectionItem){
        mapping[indexPath] = ["section":section, "item":item]
    }
    
    func manageDeselection(indexPath:IndexPath){
        if isIndexPathPresent(indexPath: indexPath){
            mapping.removeValue(forKey: indexPath)
        }
    }
    
    func allIndexPaths()->[IndexPath]{
        return Array(mapping.keys)
    }
    
    func reset(){
        mapping.removeAll()
    }
    
    func isIndexPathPresent(indexPath:IndexPath) -> Bool{
        if let _ = mapping[indexPath]{
            return true
        }
        return false
    }
    
    init(mappingPara:[IndexPath:Dictionary<String,Any>] = [:]) {
        self.mapping = mappingPara
        super.init()
    }
    
    func serialize() -> Dictionary<String, Any>?{
        var paraDict:[String:Any] = [:]
        for (_, value) in mapping{
            let section = value["section"] as! FilterSection
            let item = value["item"] as! FilterSectionItem
            if paraDict[section.paramName] == nil{
                paraDict[section.paramName] = item.paraName
            }
            else{
                let oldValue = paraDict[section.paramName]
                if let oldStringValue = oldValue as? String{
                    paraDict[section.paramName] = [oldStringValue, item.paraName].joined(separator: "/")
                }
            }
        }
        if paraDict.count == 0{
            return nil
        }
        return paraDict
    }
    
    public func copy(with zone: NSZone? = nil) -> Any{
        let copy = FilterParameterSerializer.init(mappingPara: mapping)
        return copy
    }
}
