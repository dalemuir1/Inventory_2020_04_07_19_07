//
//  BrandDataSource.swift
//  PickerTextFieldExample
//
//  Created by Dale Muir on 6/14/18.
//  Copyright © 2018 Peter Witham. All rights reserved.
//

import UIKit

class BrandDataSource: NSObject {
    
    static let sharedInstance: BrandDataSource = {
        let instance = BrandDataSource()
        
        // setup code
        if instance.isDirty {
            instance.getBrandItems()
            instance.isDirty = false
        }
        return instance
    }()
    
    var brandItems:[String] = []
    var isDirty = true
    
    func getBrandItems() {
        
        let sessionHelper = SessionHelper()
        
        
        let requestString = requestStringBaseURLConstant + "getBrands.php"
        if let url = URL(string: requestString) {
            let req = URLRequest(url: url)
            // print(req)
            
            let dataTask = sessionHelper.session.dataTask(with: req, completionHandler: {
                (data, response, error) in
                if data != nil {
                    if let jsonString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                        print(jsonString)
                        
                    }
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                            print("JSON Result\n\(jsonObject)")
                            
                            //var myBoard: NSArray = parsedJSON["boards"] as! NSArray
                            
                            if let rollingStockArray: NSArray = jsonObject["rollingStock"] as? NSArray {
                                
                                //                                NSOperationQueue.mainQueue().addOperationWithBlock() {
                                //                                    tableViewToBlock.reloadSections(NSIndexSet(index: 0 ), withRowAnimation: .Automatic)
                                //                                }
                                
                                self.brandItems = []
                                
                                for i in 0 ..< rollingStockArray.count{
                                    if let itemDict:NSDictionary = rollingStockArray[i] as? NSDictionary{
                                        var brand: String?
                                        brand = itemDict["brand"] as? String
                                        self.brandItems.append(brand!)
                                        
                                        
                                    }
                                    //print(rollingStockMasterItems)
                                    
                                }
                                //print(self.rollingStockMasterItems)
                                print("brandItems count: \(self.brandItems.count)")
                                print("brandItems: \(self.brandItems)")
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
    
}


