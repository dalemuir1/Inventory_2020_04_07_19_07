//
//  RollingStockSearchViewController.swift
//  Inventory
//
//  Created by dalemuir on 10/11/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

class RollingStockSearchViewController: UIViewController {
    
    @IBOutlet weak var IdField: UITextField!
    @IBOutlet weak var reportingMarkField: UITextField!
    @IBOutlet weak var carNumberField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchAction(_ sender: AnyObject) {
        search()
    }
    
    var masterViewController: RollingStockMasterViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNumberField(textField: IdField)
        configureTextField(textField: reportingMarkField)
        configureNumberField(textField: carNumberField)
        
        ButtonUtil.configureButton(button: searchButton, isEnabled: true, isHidden: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureNumberField(textField: UITextField){
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = UIKeyboardType.numberPad
    }
    
    func configureTextField(textField: UITextField)  {
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .alphabet
        textField.autocapitalizationType = .allCharacters
    }
    
    func search() {
        print ("search")
        let filter = RollingStockMasterFilter.sharedInstance
        
        var foundIdx: Int? = nil
        
        if let id = Int( IdField.text!) {
            if let i: Int = filter.search(id: id) {
                foundIdx = i
            }
        } else {
            let reportingMark: String = reportingMarkField.text!.trim().uppercased()
            
            let roadNumber: Int? = Int(carNumberField.text!)
            
            if roadNumber != nil {
                if let i: Int = filter.search(reportingMark: reportingMark, roadNumber: roadNumber!){
                    foundIdx = i
                }
            } else {
                if let i: Int = filter.search(reportingMark: reportingMark){
                    foundIdx = i
                }
            }
            
        }
        
        if foundIdx == nil {
            let alert = UIAlertController(title: "Not found", message: "No matching item found", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                //title: "Not found", message: "No matching item found", delegate: self, cancelButtonTitle: "Cancel")
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
            let indexPath = NSIndexPath(row: foundIdx!, section: 0)
            masterViewController?.tableView.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: .middle)
            RollingStockMasterFilter.sharedInstance.selectedItemIndex = foundIdx!
//            if let nc: UINavigationController = navigationController{
//                //nc.topViewController?.collapseSecondaryViewController(self, for: splitViewController!)
//                print(nc.navigationBar.backItem?.backBarButtonItem)
//            }
            
        }
    }
    
}
