//
//  FilterPropertyViewController.swift
//  NoBroker
//
//  Created by Arjun P A on 01/05/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit


protocol FilterPropertyViewControllerDelegate:NSObjectProtocol {
    func didFinishWithFilter(filterController:FilterPropertyViewController, serializerPara:FilterParameterSerializer)
}

class FilterPropertyViewController: BaseViewController {
    
    var delegate:FilterPropertyViewControllerDelegate?
    var filters:[FilterSection] = []
    var serializer:FilterParameterSerializer = FilterParameterSerializer()
    var collection_view:UICollectionView = {
        let customLayout = IGListCollectionViewLayout.init(stickyHeaders: false, topContentInset: 0, stretchToEdge: true)
        let collection_view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: customLayout)
        collection_view.translatesAutoresizingMaskIntoConstraints = false
        collection_view.backgroundColor = UIColor.lightGray
        collection_view.allowsMultipleSelection = true
        return collection_view
    }()
    
    convenience init(globalInstancePara:NBGlobalInstanceProtocol?){
        self.init(nibName:nil, bundle:nil, globalInstancePara:globalInstancePara)
    }
    override  init(nibName:String?, bundle:Bundle?, globalInstancePara:NBGlobalInstanceProtocol?){
        super.init(nibName: nibName, bundle: bundle, globalInstancePara: globalInstancePara)
        
    }
    override func loadView() {
        view = UIView.init(frame: UIScreen.main.bounds)
        self.automaticallyAdjustsScrollViewInsets = false
        setupCollectionView()
        setupDoneBtn()
    }
    
    func registerCellsAndHeaders(){
        self.collection_view.register(UINib.init(nibName: "FilterItemCell", bundle: nil), forCellWithReuseIdentifier: "FilterItemCell")
        self.collection_view.register(UINib.init(nibName: "FilterItemHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FilterItemHeaderCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func setupCollectionView(){
        self.collection_view.dataSource = self
        self.collection_view.delegate = self
        
        self.view.addSubview(collection_view)
        self.collection_view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
       // self.collection_view.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0).isActive = true
        self.collection_view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.collection_view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupDoneBtn(){
        let doneButton = UIButton.init()
        self.view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("DONE", for: .normal)
        doneButton.backgroundColor = UIColor.red
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        doneButton.topAnchor.constraint(equalTo: self.collection_view.bottomAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        doneButton.addTarget(self, action: #selector(FilterPropertyViewController.doneBtnClicked(sender:)), for: .touchUpInside)
    }
    
    
    func doneBtnClicked(sender:UIButton){
        let serializedParams = serializer.serialize()
        print(serializedParams)
        self.delegate?.didFinishWithFilter(filterController: self, serializerPara: serializer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.collection_view.layoutIfNeeded()
        DispatchQueue.main.async { 
            for indexPath in self.serializer.allIndexPaths(){
                self.collection_view.selectItem(at: indexPath, animated: false, scrollPosition: .centeredVertically)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCellsAndHeaders()
        prepareData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareData(){
        //add apartment type
        let apartmentTypeSection = FilterSection.init(headerPara: "Apartment Type", param:"type")
        let apartmentKeyValue:Array<Dictionary<String, String>> = [["1 RK": "RK1"], ["1 BHK":"BHK1"], ["2 BHK": "BHK2"], ["3 BHK":"BHK3"], ["4 BHK":"BHK4"]]
        for (_, value) in apartmentKeyValue.enumerated(){
            let key_d = Array(value.keys).first!
            let value_d = Array(value.values).first!
            let sectionItem = FilterSectionItem.init(displayTitlePara: key_d, paraNamePara: value_d)
            apartmentTypeSection.addItem(item: sectionItem)
        }
        //add property type section
        let propertyTypeSection = FilterSection.init(headerPara: "Property Type", param: "buildingType")
        let propertyTypeKeyValue:Array<Dictionary<String, String>> = [["Apartment":"AP"], ["Independent House/Villa":"IH"], ["Independent Floor/Builder Floor":"IF"]]
        for (_, value) in propertyTypeKeyValue.enumerated(){
            let key_d = Array(value.keys).first!
            let value_d = Array(value.values).first!
            let sectionItem = FilterSectionItem.init(displayTitlePara: key_d, paraNamePara: value_d)
            propertyTypeSection.addItem(item: sectionItem)
        }
        
        //add Furnishing
        let furnishingType = FilterSection.init(headerPara: "Furnishing", param: "furnishing")
        let furnishingTypeKeyValue:Array<Dictionary<String, String>>  = [["Fully Furnished": "FULLY_FURNISHED"], ["Semi Furnished":"SEMI_FURNISHED"], ["Not Furnished":"NOT_FURNISHED"]]
        for (_, value) in furnishingTypeKeyValue.enumerated(){
            let key_d = Array(value.keys).first!
            let value_d = Array(value.values).first!
            let sectionItem = FilterSectionItem.init(displayTitlePara: key_d, paraNamePara: value_d)
            furnishingType.addItem(item: sectionItem)
        }
        
        filters = [apartmentTypeSection, propertyTypeSection, furnishingType]
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension FilterPropertyViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cellNotNil = self.collection_view.cellForItem(at: indexPath) as? FilterItemCell{
            cellNotNil.selectedBackground.isHidden = false
            serializer.manageSelection(indexPath: indexPath, section: filters[indexPath.section], item: filters[indexPath.section].items[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cellNotNil = self.collection_view.cellForItem(at: indexPath) as? FilterItemCell{
            cellNotNil.selectedBackground.isHidden = true
            serializer.manageDeselection(indexPath: indexPath)
        }
    }
}
extension FilterPropertyViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection_view.dequeueReusableCell(withReuseIdentifier: "FilterItemCell", for: indexPath) as! FilterItemCell
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let item = filters[indexPath.section].items[indexPath.item]
        cell.configure(filterItemParam: item)
        if serializer.isIndexPathPresent(indexPath: indexPath){
            cell.selectedBackground.isHidden = false
        }
        else{
            self.collection_view.deselectItem(at: indexPath, animated: false)
             cell.selectedBackground.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell = collection_view.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "FilterItemHeaderCell", for: indexPath) as! FilterItemHeaderCell
        let section = self.filters[indexPath.section]
        headerCell.configure(filterSection: section)
     
        return headerCell
    }
    
}

extension FilterPropertyViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = filters[indexPath.section].items[indexPath.item]
        let size = FilterItemCell.calculateSize(filterItemParam: item)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
