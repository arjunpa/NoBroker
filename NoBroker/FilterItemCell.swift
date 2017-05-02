//
//  FilterItemCellCollectionViewCell.swift
//  NoBroker
//
//  Created by Arjun P A on 01/05/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class FilterItemCell: UICollectionViewCell {
    
    @IBOutlet weak var title:UILabel!
    var filterItem:FilterSectionItem!
    fileprivate var hasLayouted: Bool = false
    static let displayFont:UIFont =  UIFont.systemFont(ofSize: 12)
    var selectedBackground:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        title.font = FilterItemCell.displayFont
        
        // Initialization code
    }
    override var isSelected:Bool {
        willSet {
          //  self.selectedBackgroundView?.isHidden = false
        }
    }
    
    func manageSelectedState(collectionView:UICollectionView, indexPath:IndexPath){
        
    }
    
    override func updateConstraints() {
        if !hasLayouted{
            self.selectedBackground = UIView.init()
            selectedBackground.alpha = 0.5
            self.selectedBackground.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(self.selectedBackground)
            selectedBackground.backgroundColor = UIColor.red
            selectedBackground.topAnchor.constraint(equalTo: selectedBackground.superview!.topAnchor).isActive = true
            selectedBackground.leadingAnchor.constraint(equalTo: selectedBackground.superview!.leadingAnchor).isActive = true
            selectedBackground.trailingAnchor.constraint(equalTo: selectedBackground.superview!.trailingAnchor).isActive = true
            selectedBackground.bottomAnchor.constraint(equalTo: selectedBackground.superview!.bottomAnchor).isActive = true
            selectedBackground.isHidden = true
            self.contentView.bringSubview(toFront: selectedBackground)
            hasLayouted = true
        }
        super.updateConstraints()
    }
    
    func configure(filterItemParam:FilterSectionItem){
        self.filterItem = filterItemParam
        self.title.text = filterItemParam.displayTitle
    }
    

    
    class func calculateSize(filterItemParam:FilterSectionItem) -> CGSize{
        var sizeOfDisplayString = filterItemParam.displayTitle.size(fits: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: 1 * FilterItemCell.displayFont.lineHeight), font: FilterItemCell.displayFont)
        
        sizeOfDisplayString.height = ceil(sizeOfDisplayString.height)
        sizeOfDisplayString.width = ceil(sizeOfDisplayString.width)
        return CGSize.init(width: sizeOfDisplayString.width + 8 + 8, height: sizeOfDisplayString.height + 8 + 8)
    }
    
    
    
}
