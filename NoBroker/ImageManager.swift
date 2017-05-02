//
//  ImageManager.swift
//  NoBroker
//
//  Created by Arjun P A on 30/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire


protocol ImageManagerProtocol{
    var _service:ServiceProtocol.Type?{get set}
    func setImage(target:inout UIImageView,url:String, useAbsoluteURL:Bool)
    func  prefetchImages(urlRequests:[URLRequest])
    func prefetch(images:[String], useAbsoluteURL:Bool)
    func formatURL(url:String, useAbsoluteURL:Bool) -> URL?
}

class ImageManager: NSObject, ImageManagerProtocol{


    internal var _service:ServiceProtocol.Type?
    init(mockService:ServiceProtocol.Type?) {
      //  Request.addAcceptableImageContentTypes(["image/jpg"])
        DataRequest.addAcceptableImageContentTypes(["image/jpg"])
        _service = mockService
    }
    
    func formatURL(url:String, useAbsoluteURL:Bool) -> URL?{
        var urlStr = url
        if !useAbsoluteURL{
            urlStr = (_service?.imageBaseURL ?? "") + url
        }
        guard let imageURL = URL.init(string: urlStr) else {return nil}
        return imageURL
        
    }
    
    func setImage(target:inout UIImageView,url:String, useAbsoluteURL:Bool = false){
        var urlStr = url
//        if !useAbsoluteURL{
//            urlStr = (_service?.imageBaseURL ?? "") + url
//        }
        guard let imageURL = formatURL(url: urlStr, useAbsoluteURL: useAbsoluteURL) else{return}
//        if let targetNotNil = target{
//          
//            targetNotNil.af_setImage(withURL: imageURL)
//        }
//        else{
//            //target is nil. Prefetch the image and leave for now
//            UIImageView.af_sharedImageDownloader.download([URLRequest.init(url: imageURL)])
//        }
        target.af_setImage(withURL: imageURL)
    }
    
    func prefetchImages(urlRequests:[URLRequest]){
        UIImageView.af_sharedImageDownloader.download(urlRequests)
    }
    
    func prefetch(images:[String], useAbsoluteURL:Bool = false){
        let filteredURLRequests = images.map { (urlStr) -> URLRequest in
            guard let imageURL = formatURL(url: urlStr, useAbsoluteURL: useAbsoluteURL) else{fatalError("not a valid url")}
            return URLRequest.init(url: imageURL)
        }
        prefetchImages(urlRequests: filteredURLRequests)
    }
}
