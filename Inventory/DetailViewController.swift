//
//  DetailViewController.swift
//  Inventory
//
//  Created by Dale Muir on 8/29/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: RollingStockMasterItem?
//        {
//        didSet {
//            // Update the view.
//            self.configureView()
//        }
//    }
    

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: RollingStockMasterItem = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.description
//            }
            detailDescriptionLabel.text = detail.description
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

