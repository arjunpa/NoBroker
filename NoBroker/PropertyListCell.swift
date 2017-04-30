//
//  CollectionViewCell.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class BaseCollectionCell:UICollectionViewCell{
    fileprivate var _data:Any?
    fileprivate var hasLayouted:Bool = false
    var data:Any?{
        get{
            return _data
        }
        set{
            _data = newValue
        }
    }
    override init(frame:CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override func updateConstraints() {
        if !hasLayouted{
            createConstraints()
            hasLayouted = !hasLayouted
        }
        super.updateConstraints()
    }
    func createConstraints(){
        fatalError("createConstraints() not implemented")
    }
}

class PropertyListCell: BaseCollectionCell {
    
//    var topLayer:UIView = {
//        let topLayered = UIView.init()
//        topLayered.translatesAutoresizingMaskIntoConstraints = false
//        return topLayered
//    }()
//    
//    var propertyTitle:UILabel = {
//        let title = UILabel.init()
//        title.translatesAutoresizingMaskIntoConstraints = false
//        title.font = UIFont.systemFont(ofSize: 14)
//        title.numberOfLines = 1
//        return title
//    }()
    
    override func createConstraints() {
           createTopLayer()
        
    }
    
    func createTopLayer(){
//        self.topLayer.addSubview(topLayer)
//        self.topLayer.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
//        self.topLayer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
//        self.topLayer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: 0).isActive = true
//        self.topLayer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
//        
//        let titleLayer:UIView = UIView.init()
//        titleLayer.translatesAutoresizingMaskIntoConstraints = false
//        self.topLayer.addSubview(titleLayer)
//        titleLayer.leadingAnchor.constraint(equalTo: titleLayer.superview!.leadingAnchor, constant: 0).isActive = true
//        titleLayer.topAnchor.constraint(equalTo: titleLayer.superview!.topAnchor, constant: 0).isActive = true
//        titleLayer.bottomAnchor.constraint(equalTo: titleLayer.superview!.bottomAnchor, constant: 0).isActive = true
//        
//        let likeWrapView = UIView.init()
//        likeWrapView.translatesAutoresizingMaskIntoConstraints = false
//        self.topLayer.addSubview(likeWrapView)
//        likeWrapView.topAnchor.constraint(equalTo: self.topLayer.topAnchor, constant: 0).isActive = true
//        likeWrapView.bottomAnchor.constraint(equalTo: self.topLayer.bottomAnchor, constant: 0).isActive = true
//        likeWrapView.leadingAnchor.constraint(equalTo: titleLayer.trailingAnchor, constant: 0).isActive = true
//        likeWrapView.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        
//        
//        let phoneWrapView = UIView.init()
//        phoneWrapView.translatesAutoresizingMaskIntoConstraints = false
//        self.topLayer.addSubview(phoneWrapView)
//        phoneWrapView.topAnchor.constraint(equalTo: self.topLayer.topAnchor, constant: 0).isActive = true
//        phoneWrapView.bottomAnchor.constraint(equalTo: self.topLayer.bottomAnchor, constant: 0).isActive = true
//        phoneWrapView.trailingAnchor.constraint(equalTo: self.topLayer.trailingAnchor, constant: 0).isActive = true
//        phoneWrapView.leadingAnchor.constraint(equalTo: likeWrapView.trailingAnchor, constant: 0).isActive = false
//        phoneWrapView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
}
