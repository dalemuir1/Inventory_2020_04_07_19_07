//
//  RollingStockMasterViewController.swift
//  Inventory
//
//  Created by Dale Muir on 10/3/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

class RollingStockMasterViewController: UITableViewController {
    
    @IBAction func refreshAction(_ sender: AnyObject) {
        loadData()
    }
 
    
    var detailViewController: RSDetailViewController? = nil
    var detailNavController: UINavigationController? = nil
    var masterNavController: UINavigationController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search(_:)))
//        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reload(_:)))
//        let rightbuttons = [addButton, searchButton, refreshButton]
//        
//        //self.navigationItem.rightBarButtonItem = addButton
//        self.navigationItem.rightBarButtonItems = rightbuttons
        
        
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? RSDetailViewController
            self.detailNavController = self.detailViewController?.navigationController
        }
        
        self.masterNavController = self.navigationController
        
        RollingStockMasterFilter.sharedInstance.tableViewToBlock = self.tableView
        
        tableView.allowsSelectionDuringEditing = true
        
        //loadData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        let filter = RollingStockMasterFilter.sharedInstance
        
        if filter.rollingStockMasterItems.count == 0 {
            loadData()
        }
        if filter.rollingStockMasterItems.count > 0 {
            let indexPath = NSIndexPath(row: filter.selectedItemIndex, section: 0)
            tableView.selectRow(at: indexPath as IndexPath, animated: true, scrollPosition: .middle)
        }
    }
    
    func loadData() {
        if let ip = selectedIndexPath {
            tableView.deselectRow(at: ip, animated: true)
        }
        let filter = RollingStockMasterFilter.sharedInstance
        filter.getRollingStockMasterItems()
        
        BrandDataSource.sharedInstance.getBrandItems()
        ReportingMarkDataSource.sharedInstance.getReportingMarkItems()
        
        showDetail()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let  cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        
        let filter = RollingStockMasterFilter.sharedInstance
        let item = filter.rollingStockMasterItems[(indexPath as NSIndexPath).row]
        var rm: String = "N/A"
        if let rmtmp :String = item.reportingMark {
            rm = rmtmp
        }
        var roadNumString: String = "N/A"
        if let n: Int = item.roadNumber {
            roadNumString = String(n)
        }
        
        let title: String = "\(item.id) \(rm) \(roadNumString)"
        cell!.textLabel!.text = title
        
        var brand: String = ""
        if let b: String = item.brand {
            brand = b
        }
        
        var brandCatNum = ""
        if let bcn: String = item.brandCatalogNumber {
            brandCatNum = bcn
        }
        
        var ownerClass: String = ""
        if let oc: String = item.ownerClass {
            ownerClass = oc
        }
        
        var AARClass: String = ""
        if let ac: String = item.AARClass {
            AARClass = ac
        }
        
        if let _: UILabel = cell!.detailTextLabel {
            cell!.detailTextLabel!.text = "\(brand) \(brandCatNum) \(ownerClass) \(AARClass)"
            return cell!
            
        }
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filter = RollingStockMasterFilter.sharedInstance
        return filter.rollingStockMasterItems.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let filter = RollingStockMasterFilter.sharedInstance
            filter.deleteItemAt(row: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadData()
            showDetail()
        } else if editingStyle == .none {
            print("none editing style")
        }
        
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if let ip: IndexPath = selectedIndexPath {
            tableView.selectRow(at: ip, animated: true, scrollPosition: .none)
            showDetail()
        }
    }
    
    var selectedIndexPath: IndexPath?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        RollingStockMasterFilter.sharedInstance.selectedItemIndex = (self.selectedIndexPath?.row)!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showDetail" {
            tableView.allowsSelection = true
            if let indexPath = self.tableView.indexPathForSelectedRow {
                //let object = self.fetchedResultsController.objectAtIndexPath(indexPath)
                let controller = (segue.destination as! UINavigationController).topViewController as! RSDetailViewController
                controller.masterViewController = self
                if tableView.isEditing {
                    controller.mode = .update
                } else {
                    controller.mode = .showDetail
                }
                
                controller.detailItem = RollingStockMasterFilter.sharedInstance.rollingStockMasterItems[(indexPath as NSIndexPath).row]
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "showAdd" {
            let controller = (segue.destination as! UINavigationController).topViewController as! RSDetailViewController
            controller.mode = .add
            controller.masterViewController = self
            controller.navigationItem.title = "Add"
            tableView.allowsSelection = false
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true

       } else if segue.identifier == "search" {
            tableView.allowsSelection = true
            let controller = (segue.destination as! UINavigationController).topViewController as! RollingStockSearchViewController
            controller.masterViewController = self
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
        
        
    }
    
    var firstTime = true
    
//    func insertNewObject(_ sender: AnyObject) {
//        print("Insert")
//        if firstTime {
//            showDetail()
//            firstTime = false
//        }
//        detailViewController?.mode = .add
//        detailViewController?.masterViewController = self
//        tableView.allowsSelection = false
//        
//        if detailNavController != nil {
//            splitViewController?.showDetailViewController(detailNavController!, sender: nil)
//            //detailViewController?.view.setNeedsDisplay()
//        } else {
//            splitViewController?.showDetailViewController(detailViewController!, sender: nil)
//        }
//        
//    }
    
    func showDetail(){
        tableView.allowsSelection = true
        performSegue(withIdentifier: "showDetail", sender: nil)
        
    }
    
    
    
}
