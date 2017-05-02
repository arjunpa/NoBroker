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
    var globalInstance:NBGlobalInstanceProtocol!
    var _imageManager:ImageManagerProtocol?
    var imageManager:ImageManagerProtocol{
        get{
            if _imageManager == nil{
                
                _imageManager = ImageManager.init(mockService: globalInstance.mockService)
            }
            return _imageManager!
        }
        set{
            _imageManager = newValue
        }
    }
    var data:Any?{
        get{
            return _data
        }
        set{
            _data = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeNBObject()
    }
    
    func initializeNBObject(){
         globalInstance = Thread.main.threadDictionary.value(forKey: "globalInstance") as! NBGlobalInstanceProtocol
    }
    
    func setImageManager(manager:ImageManagerProtocol){
        _imageManager = manager
    }
    
    override init(frame:CGRect){
        super.init(frame: frame)
        initializeNBObject()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func configure(dataPara:Any?){
        data = dataPara
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
    
    @IBOutlet weak var propertyTitle:UILabel!
    @IBOutlet weak var propertyStreet:UILabel!
    @IBOutlet weak var rentAmount:UILabel!
    @IBOutlet weak var furnishing:UILabel!
    @IBOutlet weak var noOfBathrooms:UILabel!
    @IBOutlet weak var squareFeet:UILabel!
    @IBOutlet weak var squareFeetPlaceholder:UILabel!
    @IBOutlet weak var topLayer:UIView!
    @IBOutlet weak var bottomLayer:UIView!
    @IBOutlet weak var propertyImageView:UIImageView!
    @IBOutlet weak var phoneWrapViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var likeWrapViewWidthConstraint:NSLayoutConstraint!
    @IBOutlet weak var topLayerHeightConstraint:NSLayoutConstraint!
    static let phoneWrapViewWidth:CGFloat = 40
    static let likeWrapViewWidth:CGFloat = 40
    static let propertyTitleInsets = UIEdgeInsetsMake(8, 8, 0, 8)
    static let propertyStreetInsets = UIEdgeInsetsMake(8, 8, 8, 8)
    static let cardInsets = UIEdgeInsetsMake(5, 5, 5, 5)
    static let furnishingSuperViewInsets = UIEdgeInsetsMake(8, 4, 8, 4)
    
    struct Fonts{
        static let propertyTitleFont:UIFont = UIFont.boldSystemFont(ofSize: 14)
        static let streetFont = UIFont.systemFont(ofSize: 12)
    }
    
    var propertyItem:PropertyModel!
    override var data: Any?{
        get{
            return propertyItem
        }
        set{
            if let ofTypePropertyModel = newValue as? PropertyModel{
                propertyItem = ofTypePropertyModel
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.furnishing.adjustsFontSizeToFitWidth = true
        self.noOfBathrooms.adjustsFontSizeToFitWidth = true
        self.propertyStreet.textColor = UIColor.lightGray
        self.setupConstraintConstants()
        
        setupFonts()
        
    }
    
    func setupConstraintConstants(){
        phoneWrapViewWidthConstraint.constant = PropertyListCell.phoneWrapViewWidth
        likeWrapViewWidthConstraint.constant = PropertyListCell.likeWrapViewWidth
        self.propertyTitle.superview!.constraint(withIdentifier: "separation")?.constant = PropertyListCell.propertyTitleInsets.bottom
        self.propertyTitle.superview!.constraint(withIdentifier: "titleLeading")!.constant = PropertyListCell.propertyTitleInsets.left
        self.propertyTitle.superview!.constraint(withIdentifier: "titleTrailing")!.constant = PropertyListCell.propertyTitleInsets.right
        self.propertyTitle.superview!.constraint(withIdentifier: "titleTop")!.constant = PropertyListCell.propertyTitleInsets.top
        self.propertyStreet.superview!.constraint(withIdentifier: "streetLeading")!.constant = PropertyListCell.propertyStreetInsets.left
        self.propertyStreet.superview!.constraint(withIdentifier: "streetTrailing")!.constant = PropertyListCell.propertyStreetInsets.right
        self.propertyStreet.superview!.constraint(withIdentifier: "streetBottom")!.constant = PropertyListCell.propertyStreetInsets.bottom
        
        self.furnishing.superview!.superview!.constraint(withIdentifier: "superViewLeading")!.constant = PropertyListCell.furnishingSuperViewInsets.left
        self.furnishing.superview!.superview!.constraint(withIdentifier: "superViewTrailing")!.constant = PropertyListCell.furnishingSuperViewInsets.right
        self.furnishing.superview!.superview!.constraint(withIdentifier: "superViewTop")!.constant = PropertyListCell.furnishingSuperViewInsets.top
        self.furnishing.superview!.superview!.constraint(withIdentifier: "superViewBottom")!.constant = PropertyListCell.furnishingSuperViewInsets.bottom
    }
    
    func setupFonts(){
        self.propertyTitle.font = Fonts.propertyTitleFont
        self.propertyStreet.font = Fonts.streetFont
    }
    
    override func configure(dataPara: Any?) {
        super.configure(dataPara: dataPara)
        self.propertyTitle.text = self.propertyItem.propertyTitle
        self.propertyStreet.text = "at " + (self.propertyItem.street ?? "")
        topLayerHeightConstraint.constant = PropertyListCell.getTopLayerHeight(data: propertyItem, targetWidth: UIScreen.main.bounds.width - PropertyListCell.cardInsets.left - PropertyListCell.cardInsets.right)
        propertyImageView.constraint(withIdentifier: "heightConstraint")?.constant = PropertyListCell.getImageHeight(data: propertyItem, targetWidth: UIScreen.main.bounds.width - PropertyListCell.cardInsets.left - PropertyListCell.cardInsets.right)
        bottomLayer.constraint(withIdentifier: "heightConstraint")!.constant = PropertyListCell.getBottomLayerHeight(data: propertyItem, targetWidth: UIScreen.main.bounds.width - PropertyListCell.cardInsets.left - PropertyListCell.cardInsets.right)
        if let rentmt = self.propertyItem.rent{
            let numberFormatter = NumberFormatter()
            numberFormatter.allowsFloats = false
            numberFormatter.numberStyle = .currency
            numberFormatter.currencySymbol = "₹"
            numberFormatter.maximumFractionDigits = 0
            self.rentAmount.text = numberFormatter.string(from: NSNumber.init(value: rentmt))
        }
        else{
            self.rentAmount.text = ""
        }
        
        self.noOfBathrooms.text = String(propertyItem.noOfBathrooms ?? 0) + " " + "Bathrooms"
        self.furnishing.text = self.propertyItem.furnishing?.rawValue ?? ""
        self.squareFeet.text = ""
        
        if let propertySize = propertyItem.propertySize{
            self.squareFeet.text = String(propertySize) + " Sq.Ft"
        }
        self.squareFeetPlaceholder.text = "Built up Area"
        
        if let furnishingType = self.propertyItem.furnishing{
            switch furnishingType {
            case .FULLY_FURNISHED:
                self.furnishing.text = "Fully Furnished"
                break
            case .SEMI_FURNISHED:
                self.furnishing.text = "Semi Furnished"
                break
            case .NOT_FURNISHED:
                self.furnishing.text = "Not Furnished"
                
            }
        }
        else{
            self.furnishing.text = ""
        }
        
        if let photo = self.propertyItem.photos.first, self.propertyItem.photos.first!.mediumImageKey != nil{
         
        
            self.propertyImageView.image = nil
//            if let imageURL = imageManager.formatURL(url: photo.originalImageKey!, useAbsoluteURL: false){
//                propertyImageView.af_setImage(withURL: imageURL)
//
//            }
            imageManager.setImage(target: &propertyImageView!, url: photo.mediumImageKey!, useAbsoluteURL: false)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func createConstraints() {

        //override any default constraits or add any newConstraints
    }
    
    class func sizeThatFits(data:PropertyModel, targetWidthd:CGFloat = UIScreen.main.bounds.width) -> CGSize{
        let targetWidth:CGFloat = targetWidthd - cardInsets.left - cardInsets.right
        let topLayerHeight = PropertyListCell.getTopLayerHeight(data: data, targetWidth: targetWidth)
        let imageHeight = PropertyListCell.getImageHeight(data: data, targetWidth: targetWidth)
        let bottomHeight = PropertyListCell.getBottomLayerHeight(data: data, targetWidth: targetWidth)
        return CGSize.init(width: targetWidth, height: topLayerHeight + imageHeight + bottomHeight)
    }
    
    private class func getImageHeight(data:PropertyModel, targetWidth:CGFloat = UIScreen.main.bounds.width) -> CGFloat{
        //fix 4:3 for now
        let widthDimension = targetWidth
        let heightDimension = widthDimension * 3/4
        return ceil(heightDimension)
    }
    
    private class func getBottomLayerHeight(data:PropertyModel, targetWidth:CGFloat = UIScreen.main.bounds.width) -> CGFloat{
        // you don't have to pass the correct widh param here because number of lines is fixed. But for still passing nevertheless
        let widthOfOneTab = floor(targetWidth/3) - cardInsets.left - cardInsets.right
        let heightOfFurnishing = (data.furnishing?.rawValue ?? "").height(fits: widthOfOneTab - PropertyListCell.furnishingSuperViewInsets.left - PropertyListCell.furnishingSuperViewInsets.right, font: UIFont.systemFont(ofSize: 10), maximumNumberOfLines: 1)
        let heightOfNoOfBathrooms = (String(data.noOfBathrooms ?? 0) + " " + "Bathrooms").height(fits: widthOfOneTab - PropertyListCell.furnishingSuperViewInsets.left - PropertyListCell.furnishingSuperViewInsets.right, font: UIFont.systemFont(ofSize: 10), maximumNumberOfLines: 1)
        let totalHeight = ceil(heightOfFurnishing) + ceil(heightOfNoOfBathrooms) + PropertyListCell.furnishingSuperViewInsets.top + PropertyListCell.furnishingSuperViewInsets.bottom + 11
        //11 is the sum of top, separation and bottom padding for furnishing and bathroom labels
        return totalHeight
    }
    
    private class func getTopLayerHeight(data:PropertyModel, targetWidth:CGFloat = UIScreen.main.bounds.width) -> CGFloat{
        let heightOfTitle = data.propertyTitle?.height(fits: targetWidth - PropertyListCell.likeWrapViewWidth - PropertyListCell.phoneWrapViewWidth - propertyTitleInsets.left - propertyTitleInsets.right, font: Fonts.propertyTitleFont, maximumNumberOfLines: 1) ?? 0
        let heightOfStreet = data.street?.height(fits: targetWidth - PropertyListCell.likeWrapViewWidth - PropertyListCell.phoneWrapViewWidth - propertyStreetInsets.left - propertyStreetInsets.right, font: Fonts.streetFont, maximumNumberOfLines: 2) ?? 0
        let totalHeight = ceil(heightOfTitle) + ceil(heightOfStreet) + propertyTitleInsets.top + propertyTitleInsets.bottom + propertyStreetInsets.bottom + cardInsets.top + cardInsets.bottom
        return totalHeight
    }
    

    
}
