//
//  PropertlyListViewController.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class PropertlyListViewController: BaseViewController {

    var pager:PropertyListPager!
    var properties:[PropertyModel] = []
    var collection_view:UICollectionView = {
        let collection_view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection_view.translatesAutoresizingMaskIntoConstraints = false
        collection_view.backgroundColor = UIColor.lightGray
        return collection_view
    }()
    
     convenience init(globalInstancePara:NBGlobalInstanceProtocol?){
        self.init(nibName:nil, bundle:nil, globalInstancePara:globalInstancePara)
    }
    override  init(nibName:String?, bundle:Bundle?, globalInstancePara:NBGlobalInstanceProtocol?){
        super.init(nibName: nibName, bundle: bundle, globalInstancePara: globalInstancePara)
        pager = PropertyListPager.init(nbObject: self.globalInstance)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView.init(frame: UIScreen.main.bounds)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func registerNibs(){
        let nib = UINib.init(nibName: "PropertyListCell", bundle: nil)
        self.collection_view.register(nib, forCellWithReuseIdentifier: "PropertyListCell")
    }
    
    func setupCollectionView(){
        self.collection_view.dataSource = self
        self.collection_view.delegate = self
        self.view.addSubview(collection_view)
        self.collection_view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.collection_view.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0).isActive = true
        self.collection_view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.collection_view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
    
    override func setupData(){
        self.pager.pageNext()
        
        self.pager.completion = {[weak self] propertiesPara, error in
            guard let weakSelf = self else {return}
            let strongSelf = weakSelf
            if let _ = error{
                return
            }
            guard let propertiesNotNil = propertiesPara else{return}
            strongSelf.properties = strongSelf.properties + propertiesNotNil
            self?.collection_view.reloadData()
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        registerNibs()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension PropertlyListViewController:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let propertyListCell = collection_view.dequeueReusableCell(withReuseIdentifier: "PropertyListCell", for: indexPath) as! PropertyListCell
        propertyListCell.setNeedsUpdateConstraints()
        propertyListCell.updateConstraintsIfNeeded()
        propertyListCell.setNeedsLayout()
        propertyListCell.layoutIfNeeded()
        propertyListCell.configure(dataPara: properties[indexPath.item])
        return propertyListCell
    }
}

extension PropertlyListViewController:UICollectionViewDelegate{
    
}

extension PropertlyListViewController:UIScrollViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let distance = scrollView.contentSize.height - (targetContentOffset.pointee.y + scrollView.bounds.height)
        if distance < 200 {
          self.pager.pageNext()
        }
    }

}

extension PropertlyListViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let propertyItem = properties[indexPath.item]
        let size = PropertyListCell.sizeThatFits(data: propertyItem, targetWidthd: UIScreen.main.bounds.width)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
}
