//
//  RollingStockMasterFilter.swift
//  Inventory
//
//  Created by Dale Muir on 10/3/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

class RollingStockMasterFilter: NSObject {
    
    static let sharedInstance: RollingStockMasterFilter = {
        let instance = RollingStockMasterFilter()
        
        // setup code
        
        return instance
    }()
    
    var rollingStockMasterItems:[RollingStockMasterItem] = []
    
    var tableViewToBlock: UITableView?
    
    var selectedItemIndex: Int = 0
    var selectedItemId: Int?
    
    func getRollingStockMasterItems() {
        
        //var rollingStockMasterItems:[RollingStockMasterItem] = []
        //var session: NSURLSession!
        //var rollingStockJSON = [[NSObject:AnyObject]]()
        
        let sessionHelper = SessionHelper()
        
        
        let requestString = requestStringBaseURLConstant + "getRollingStock.php"
        if let url = URL(string: requestString) {
            let req = URLRequest(url: url)
            // print(req)
            
            let dataTask = sessionHelper.session.dataTask(with: req, completionHandler: {
                (data, response, error) in
                if data != nil {
                    //                    if let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding){
                    //                        print(jsonString)
                    //
                    //                    }
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                            //print("JSON Result\n\(jsonObject)")
                            
                            //var myBoard: NSArray = parsedJSON["boards"] as! NSArray
                            
                            if let rollingStockArray: NSArray = jsonObject["rollingStock"] as? NSArray {
                                
                                //                                NSOperationQueue.mainQueue().addOperationWithBlock() {
                                //                                    tableViewToBlock.reloadSections(NSIndexSet(index: 0 ), withRowAnimation: .Automatic)
                                //                                }
                                
                                self.rollingStockMasterItems = []
                                
                                for i in 0 ..< rollingStockArray.count{
                                    if let itemDict:NSDictionary = rollingStockArray[i] as? NSDictionary{
                                        var id:Int?
                                        var reportingMark: String?
                                        var roadNumber:Int?
                                        
                                        let idString = itemDict["ID"] as? String
                                        if idString != nil {
                                            id = Int.init(idString!)
                                        }
                                        
                                        reportingMark = itemDict["reportingMark"] as? String
                                        let roadNumberPrefix = itemDict["roadNumberPrefix"] as? String

                                        let roadNumberString = itemDict["roadNumber"] as? String
                                        if roadNumberString != nil {
                                            roadNumber = Int.init(roadNumberString!)
                                        }
                                        let roadNumberSuffix = itemDict["roadNumberSuffix"] as? String
                                        
                                        let brand = itemDict["brand"] as? String
                                        let brandCatalogNumber = itemDict["brandCatalogNumber"] as? String
                                        let ownerClass = itemDict["ownerClass"] as? String
                                        let AARClass = itemDict["AARClass"] as? String
                                        let color = itemDict["color"] as? String
                                        let modified = itemDict["modified"] as? String
                                        let carName = itemDict["carName"] as? String
                                        let state = itemDict["state"] as? String
                                        let created = itemDict["created"] as? String
                                        let purchaseDate = itemDict["purchaseDate"] as? String
                                        let purchaseCostString = itemDict["purchaseCost"] as? String
                                        
                                        var purchaseCost: Double?
                                        if purchaseCostString != nil {
                                            purchaseCost = Double.init(purchaseCostString!)
                                        }

                                        
                                        let purchasedFrom = itemDict["purchasedFrom"] as? String
                                        let description = itemDict["description"] as? String
                                        let wheelArrangement = itemDict["wheelArrangement"] as? String
                                        let length = itemDict["length"] as? String
                                        let category = itemDict["category"] as? String
                                        let box = itemDict["box"] as? String
                                        
                                        var storageContainer: Int?
                                        let storageContainerString = itemDict["storageContainer"] as? String
                                        if storageContainerString != nil{
                                            storageContainer = Int.init(storageContainerString!)
                                        }
                                        
                                        let buildStatus = itemDict["buildStatus"] as? String
                                        let verified = itemDict["verified"] as? String
                                        let tagged = itemDict["tagged"] as? String
                                        let disposition = itemDict["disposition"] as? String
                                        let paint = itemDict["paint"] as? String
                                        let wheelType = itemDict["wheelType"] as? String
                                        let frontCoupler = itemDict["frontCoupler"] as? String
                                        let rearCoupler = itemDict["rearCoupler"] as? String
                                        
                                        
                                        if id != nil {
                                            let rsItem = RollingStockMasterItem (id: id!, reportingMark: reportingMark, roadNumberPrefix: roadNumberPrefix, roadNumber: roadNumber,roadNumberSuffix: roadNumberSuffix, brand: brand, brandCatalogNumber: brandCatalogNumber, ownerClass: ownerClass, AARClass: AARClass, color:color, modified: modified, carName: carName, state: state, created: created, purchaseDate: purchaseDate, purchaseCost: purchaseCost, purchasedFrom: purchasedFrom, descriptionx: description, wheelArrangement: wheelArrangement, length: length, category: category, box: box, storageContainer: storageContainer, buildStatus: buildStatus, verified: verified, tagged: tagged, disposition: disposition , paint: paint, wheelType: wheelType, frontCoupler: frontCoupler, rearCoupler: rearCoupler                                                                      )
                                            
                                            
                                            
                                            self.rollingStockMasterItems.append(rsItem)
                                            
                                            //print( rsItem)
                                        }
                                        
                                        
                                    }
                                    //print(rollingStockMasterItems)
                                    
                                }
                                //print(self.rollingStockMasterItems)
                                print("rollingStockMasterItems count: \(self.rollingStockMasterItems.count)")
                                if let tv: UITableView = self.tableViewToBlock {
                                    
                                    var foundIndex: Int? = nil
                                    OperationQueue.main.addOperation() {
                                        if let localSelectedItemId = self.selectedItemId {
                                            if let localIndex = self.search(id: localSelectedItemId){
                                                self.selectedItemIndex = localIndex
                                                foundIndex = localIndex
                                            }else{
                                                self.selectedItemIndex = 0
                                            }
                                        }
                                        tv.reloadSections(IndexSet(integer: 0 ), with: .automatic)
                                        if((foundIndex) != nil) && self.tableViewToBlock != nil{
                                            let indexPath = NSIndexPath(row: foundIndex!, section: 0)
                                            self.tableViewToBlock?.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: .middle)
                                            RollingStockMasterFilter.sharedInstance.selectedItemIndex = foundIndex!
                                        }

                                    }
                                }
                            }
                        }
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }else{
                    print("error fetching")
                }
            })
            dataTask.resume()
        }
        
    }
    
    func nextId() -> Int {
        var id: Int = 0
        
        for item in rollingStockMasterItems {
            if item.id > id {
                id = item.id
            }
        }
        
        id += 1
        
        return id
    }
    
    func addItem(item: RollingStockMasterItem) {
        let requestString = requestStringBaseURLConstant + "addRollingStock.php"
        processAddUpdateDelete(item: item, requestStringBase: requestString)
    }
    
    func updateItem(item: RollingStockMasterItem) {
        let requestString = requestStringBaseURLConstant + "updateRollingStock.php"
        processAddUpdateDelete(item: item, requestStringBase: requestString)
    }
    func deleteItem(item: RollingStockMasterItem) {
        let requestString = requestStringBaseURLConstant + "deleteRollingStock.php"
        processAddUpdateDelete(item: item, requestStringBase: requestString)
    }
    
    func processAddUpdateDelete(item: RollingStockMasterItem, requestStringBase: String) {
                
        let sessionHelper = SessionHelper()
        
        
        var requestString = requestStringBase
        let params = item.addItemURLParameters()
        requestString.append(params)
        
        print(requestString)
        
        if let url = URL(string: requestString) {
            let req = URLRequest(url: url)
            // print(req)
            
            let dataTask = sessionHelper.session.dataTask(with: req, completionHandler: {
                (data, response, error) in
                if true {
                    //                    if let jsonString = NSString(data: data!, encoding: NSUTF8StringEncoding){
                    //                        print(jsonString)
                    //
                    //                    }
                    do {
                        OperationQueue.main.addOperation() {
                            self.getRollingStockMasterItems()
                            
                        }
                    }
                }else{
                    print("error fetching")
                }
            })
            dataTask.resume()
        }
        return
    }
    
    func deleteItemAt(row: Int) {
        let item = rollingStockMasterItems[row]
        rollingStockMasterItems.remove(at: row)
        print("deleted item \(item)")
        deleteItem(item: item)
    }
    
    func search(id: Int)-> Int? {
        
        var i: Int = 0
        for item in rollingStockMasterItems {
            if id == item.id {
                return i
            } else {
                i += 1
            }
        }
        return nil
        
    }

    func search(reportingMark: String)-> Int? {
        
        var i: Int = 0
        for item in rollingStockMasterItems {
            if reportingMark == item.reportingMark {
                return i
            } else {
                i += 1
            }
        }
        return nil
    }

    func search(reportingMark: String, roadNumber: Int)-> Int? {
        
        var i: Int = 0
        for item in rollingStockMasterItems {
            if reportingMark == item.reportingMark && roadNumber == item.roadNumber{
                return i
            } else {
                i += 1
            }
        }
        return nil
    }

}
