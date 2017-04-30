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
        setupCollectionView()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func setupCollectionView(){
        self.view.addSubview(collection_view)
        self.collection_view.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0)
        self.collection_view.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0)
        self.collection_view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        self.collection_view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
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
            strongSelf.properties = propertiesNotNil
            
       }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
