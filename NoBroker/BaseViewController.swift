//
//  PropertyListViewController.swift
//  NoBroker
//
//  Created by Arjun P A on 29/04/17.
//  Copyright © 2017 Arjun P A. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var globalInstance:NBGlobalInstanceProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        // Do any additional setup after loading the view.
    }
    
     convenience init(globalInstancePara:NBGlobalInstanceProtocol?){
        self.init(nibName:nil, bundle:nil, globalInstancePara:globalInstancePara)
    }
    
    init(nibName:String?, bundle:Bundle?, globalInstancePara:NBGlobalInstanceProtocol?){
        if globalInstancePara != nil{
            globalInstance = globalInstancePara!
        }
        else{
        
            globalInstance = Thread.main.threadDictionary.value(forKey: "globalInstance") as! NBGlobalInstanceProtocol
        }
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupData(){
        
    }
    
    func processError(error:Error){
        let alertController = UIAlertController.init(title: "Error", message: "An error occurred. Please make sure you're connected to the internet and try again", preferredStyle: .alert)
        let tryAgainAction = UIAlertAction.init(title: "Try Again", style: .default) { (action) in
            self.setupData()
        }
        alertController.addAction(tryAgainAction)
        self.present(alertController, animated: true, completion: nil)
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
