

import UIKit

class ReportingMarkDataSource: NSObject {
    
    static let sharedInstance: ReportingMarkDataSource = {
        let instance = ReportingMarkDataSource()
        
        // setup code
        if instance.isDirty {
            instance.getReportingMarkItems()
        }
        return instance
    }()
    
    var reportingMarkItems:[String] = []
    var isDirty = true
    
    func getReportingMarkItems() {
        
        let sessionHelper = SessionHelper()
        
        
        let requestString = requestStringBaseURLConstant + "getReportingMarks.php"
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
                                
                                self.reportingMarkItems = []
                                
                                for i in 0 ..< rollingStockArray.count{
                                    if let itemDict:NSDictionary = rollingStockArray[i] as? NSDictionary{
                                        var reportingMark: String?
                                        reportingMark = itemDict["reportingMark"] as? String
                                        self.reportingMarkItems.append(reportingMark!)
                                
                                        
                                    }
                                    //print(rollingStockMasterItems)
                                    
                                }
                                //print(self.rollingStockMasterItems)
                                print("reportingMarkItems count: \(self.reportingMarkItems.count)")
                                print("reportingMarkItems: \(self.reportingMarkItems)")
                                self.isDirty = false
                                
                                NotificationCenter.default.post(name: Notification.Name(rawValue: "reportingMarksUpdated"), object: self)

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

