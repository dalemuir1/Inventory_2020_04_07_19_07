//
//  RollingStockDetailViewController.swift
//  Inventory
//
//  Created by Dale Muir on 10/5/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

//enum EditMode { case initialize, showDetail, add, update }

class RollingStockDetailViewController: UIViewController {
    
//    @IBOutlet weak var IdField: UITextField!
//    @IBOutlet weak var reportingMarkField: UITextField!
//    @IBOutlet weak var carNumberField: UITextField!
//    @IBOutlet weak var ownerClassField: UITextField!
//    @IBOutlet weak var AARClassField: UITextField!
//    @IBOutlet weak var BrandField: UITextField!
//    @IBOutlet weak var catalogNumberField: UITextField!
//    
//    @IBOutlet weak var numberPrefixField: UITextField!
//    @IBOutlet weak var numberPostfixField: UITextField!
//    
//    @IBOutlet weak var purchaseDateField: UITextField!
//    @IBOutlet weak var purchaseCoseField: UITextField!
//    @IBOutlet weak var purchaseFromField: UITextField!
//    
//    @IBOutlet weak var saveButton: UIButton!
//    @IBOutlet weak var cancelButton: UIButton!
//    
//    var itemBeforeUpdate: RollingStockMasterItem?
//    
//    
//    @IBAction func save(_ sender: AnyObject) {
//        
//        switch mode {
//        case .add:
//            addItem()
//        case .update:
//            updateItem()
//        default:
//            print("save should not be here")
//        }
//    }
//    
//    @IBAction func cancel(_ sender: AnyObject) {
//        // go back to the normal detail view
//        
//        if let vc: RollingStockMasterViewController = masterViewController {
//            vc.showDetail()
//        }
//        
//        
//        switch mode {
//        case .add:
//            if let vc: RollingStockMasterViewController = masterViewController {
//                vc.showDetail()
//            }
//        case .update:
//            configureView()
//        default:
//            print("save should not be here")
//        }
//        
//    }
//    
//    var buttonArray: [UIButton] = []
//    
//    var mode: EditMode =  EditMode.initialize
//    var masterViewController: RollingStockMasterViewController?
//    
//    var detailItem: RollingStockMasterItem?
//    //        {
//    //        didSet {
//    //            // Update the view.
//    //            self.configureView()
//    //        }
//    //    }
//    
//    func configureNumberField(textField: UITextField){
//        textField.autocorrectionType = .no
//        textField.spellCheckingType = .no
//        textField.keyboardType = UIKeyboardType.numberPad
//    }
//    
//    func configureTextField(textField: UITextField)  {
//        textField.autocorrectionType = .no
//        textField.spellCheckingType = .no
//        textField.keyboardType = .alphabet
//        textField.autocapitalizationType = .allCharacters
//    }
//    
//    
//    func configureView() {
//        // Update the user interface for the detail item.
//        switch  mode {
//        case .showDetail:
//            view.isHidden = false
//            if let detail: RollingStockMasterItem = self.detailItem {
//                //            if let label = self.detailDescriptionLabel {
//                //                label.text = detail.description
//                //            }
//                IdField.text = String( detail.id )
//                IdField.isEnabled = false
//                
//                reportingMarkField.text = detail.reportingMark
//                reportingMarkField.isEnabled = false
//                
//                if let n: Int = detail.roadNumber {
//                    carNumberField.text = String(n)
//                }
//                carNumberField.isEnabled = false
//                
//                ownerClassField.text = detail.ownerClass
//                ownerClassField.isEnabled = false
//                
//                AARClassField.text = detail.AARClass
//                AARClassField.isEnabled = false
//                
//                BrandField.text = detail.brand
//                BrandField.isEnabled = false
//                
//                catalogNumberField.text = detail.brandCatalogNumber
//                catalogNumberField.isEnabled = false
//                
//                ButtonUtil.configureButtonArray(buttonArray: buttonArray, isEnabled: false, isHidden: true)
//                
//            }
//        case .add:
//            view.isHidden = false
//            let id = RollingStockMasterFilter.sharedInstance.nextId()
//            IdField.text = String(id)
//            
//            configureNumberField(textField: IdField)
//            configureTextField(textField: reportingMarkField)
//            configureNumberField(textField: carNumberField)
//            configureTextField(textField: ownerClassField)
//            configureTextField(textField: AARClassField)
//            configureTextField(textField: BrandField)
//            configureTextField(textField: catalogNumberField)
//            
//            ButtonUtil.configureButtonArray(buttonArray: buttonArray, isEnabled: true, isHidden: false)
//            
//        case .update:
//            if let detail: RollingStockMasterItem = self.detailItem {
//                
//                itemBeforeUpdate = RollingStockMasterItem(otherItem: detail)
//                
//                //            if let label = self.detailDescriptionLabel {
//                //                label.text = detail.description
//                //            }
//                IdField.text = String( detail.id )
//                IdField.isEnabled = false
//                
//                reportingMarkField.text = detail.reportingMark
//                reportingMarkField.isEnabled = true
//                
//                if let n: Int = detail.roadNumber {
//                    carNumberField.text = String(n)
//                }
//                carNumberField.isEnabled = true
//                
//                ownerClassField.text = detail.ownerClass
//                ownerClassField.isEnabled = true
//                
//                AARClassField.text = detail.AARClass
//                AARClassField.isEnabled = true
//                
//                BrandField.text = detail.brand
//                BrandField.isEnabled = true
//                
//                catalogNumberField.text = detail.brandCatalogNumber
//                catalogNumberField.isEnabled = true
//                
//                ButtonUtil.configureButtonArray(buttonArray: buttonArray, isEnabled: true, isHidden: false)
//                
//                configureTextField(textField: reportingMarkField)
//                configureNumberField(textField: carNumberField)
//                configureTextField(textField: ownerClassField)
//                configureTextField(textField: AARClassField)
//                configureTextField(textField: BrandField)
//                configureTextField(textField: catalogNumberField)
//                
//            }
//            
//            
//            ButtonUtil.configureButtonArray(buttonArray: buttonArray, isEnabled: true, isHidden: false)
//            cancelButton.setTitle("Reset", for: .normal)
//            //cancelButton.setNeedsDisplay()
//            
//        default:
//            print("default")
//            //view.isHidden = true
//        }
//    }
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        buttonArray.append(saveButton)
//        buttonArray.append(cancelButton)
//        
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.configureView()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func addItem(){
//        
//        let item = populateItemFromUI()
//        
//        RollingStockMasterFilter.sharedInstance.addItem(item: item)
//        
//        // sleep(5)
//        let newid = item.id + 1
//        IdField.text = String(newid)
//        
//    }
//    
//    func populateItemFromUI() -> RollingStockMasterItem{
//        
//        let id: Int = Int( IdField.text! )!
//        let reportingMark = reportingMarkField.text
//
//        var roadNumber: Int? = nil
//        if let r: Int = Int( carNumberField.text!) {
//            roadNumber = r
//        }
//        let brand = BrandField.text
//        let brandCatalogNumber = catalogNumberField.text
//        let ownerClass = ownerClassField.text
//        let AARClass = AARClassField.text
//        
//        let item = RollingStockMasterItem(id: id,
//                                          reportingMark: reportingMark,
//                                          roadNumberPrefix: nil,
//                                          roadNumber: roadNumber,
//                                          roadNumberPostfix: nil,
//                                          brand: brand,
//                                          brandCatalogNumber: brandCatalogNumber,
//                                          ownerClass: ownerClass,
//                                          AARClass: AARClass,
//                                          color: nil,
//                                          modified: nil,
//                                          carName: nil,
//                                          state: nil,
//                                          created: nil,
//                                          purchaseDate: nil,
//                                          purchaseCost: nil,
//                                          purchasedFrom: nil,
//                                          descriptionx: nil,
//                                          wheelArrangement: nil,
//                                          length: nil,
//                                          category: nil,
//                                          box: nil,
//                                          storageContainer: nil,
//                                          buildStatus: nil,
//                                          verified: nil,
//                                          tagged: nil,
//                                          disposition: nil,
//                                          paint: nil,
//                                          wheelType: nil,
//                                          frontCoupler: nil,
//                                          rearCoupler: nil
//            
//        )
//        
//        return item
//        
//    }
//    
//    func updateItem() {
//        
//        let item = populateItemFromUI()
//        
//        RollingStockMasterFilter.sharedInstance.updateItem(item: item)
//    }
    
}
