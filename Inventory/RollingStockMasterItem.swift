//
//  RollingStockMasterItem.swift
//  Inventory
//
//  Created by Dale Muir on 10/3/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit

class RollingStockMasterItem: NSObject {
    let id:Int
    var reportingMark: String?
    var roadNumberPrefix: String?
    var roadNumber: Int?
    var roadNumberSuffix: String?
    var brand: String?
    var brandCatalogNumber: String?
    var ownerClass: String?
    var AARClass: String?
    var color: String?
    var modified: String?
    var carName: String?
    var state: String?
    var created: String?
    var purchaseDate: String?
    var purchaseCost: Double?
    var purchasedFrom: String?
    var descriptionx: String?
    var wheelArrangement: String?
    var length: String?
    var category: String?
    var box: String?
    var storageContainer: Int?
    var buildStatus: String?
    var verified: String?
    var tagged: String?
    var disposition: String?
    var paint: String?
    var wheelType: String?
    var frontCoupler: String?
    var rearCoupler: String?
    
    init(
        id: Int,
        reportingMark: String?,
        roadNumberPrefix: String?,
        roadNumber: Int?,
        roadNumberSuffix: String?,
        brand: String?,
        brandCatalogNumber: String?,
        ownerClass: String?,
        AARClass: String?,
        color: String?,
        modified: String?,
        carName: String?,
        state: String?,
        created: String?,
        purchaseDate: String?,
        purchaseCost: Double?,
        purchasedFrom: String?,
        descriptionx: String?,
        wheelArrangement: String?,
        length: String?,
        category: String?,
        box: String?,
        storageContainer: Int?,
        buildStatus: String?,
        verified: String?,
        tagged: String?,
        disposition: String?,
        paint: String?,
        wheelType: String?,
    frontCoupler: String?,
    rearCoupler: String?
        ){
        self.id = id
        self.reportingMark = reportingMark
        self.roadNumberPrefix = roadNumberPrefix
        self.roadNumber = roadNumber
        self.roadNumberSuffix = roadNumberSuffix
        self.brand = brand
        self.brandCatalogNumber = brandCatalogNumber
        self.ownerClass = ownerClass
        self.AARClass = AARClass
        self.color = color
        self.modified = modified
        self.carName = carName
        self.state = state
        self.created = created
        self.purchaseDate = purchaseDate
        self.purchaseCost = purchaseCost
        self.purchasedFrom = purchasedFrom
        self.descriptionx = descriptionx
        self.wheelArrangement = wheelArrangement
        self.length = length
        self.category = category
        self.box = box
        self.storageContainer = storageContainer
        self.buildStatus = buildStatus
        self.verified = verified
        self.tagged = tagged
        self.disposition = disposition
        self.paint = paint
        self.wheelType = wheelType
        self.frontCoupler = frontCoupler
        self.rearCoupler = rearCoupler
        
        super.init()
        
    }
    
    convenience init(otherItem: RollingStockMasterItem) {
        self.init(id: otherItem.id,
                  reportingMark: otherItem.reportingMark,
                  roadNumberPrefix: otherItem.roadNumberPrefix,
                  roadNumber: otherItem.roadNumber,
                  roadNumberSuffix: otherItem.roadNumberSuffix,
                  brand: otherItem.brand,
                  brandCatalogNumber: otherItem.brandCatalogNumber,
                  ownerClass: otherItem.ownerClass,
                  AARClass: otherItem.AARClass,
                  color: otherItem.color,
                  modified: otherItem.modified,
                  carName: otherItem.carName,
                  state: otherItem.state,
                  created: otherItem.created,
                  purchaseDate: otherItem.purchaseDate,
                  purchaseCost: otherItem.purchaseCost,
                  purchasedFrom: otherItem.purchasedFrom,
                  descriptionx: otherItem.descriptionx,
                  wheelArrangement: otherItem.wheelArrangement,
                  length: otherItem.length,
                  category: otherItem.category,
                  box: otherItem.box,
                  storageContainer: otherItem.storageContainer,
                  buildStatus: otherItem.buildStatus,
                  verified: nil, //otherItem.verified,
                  tagged: otherItem.tagged,
                  disposition: otherItem.disposition,
                  paint: otherItem.paint,
                  wheelType: otherItem.wheelType,
                  frontCoupler: otherItem.frontCoupler,
                  rearCoupler: otherItem.rearCoupler
        )
    }
    
    override var description: String { get {
        let localReportingMark = reportingMark ?? ""
        let localRoadNumber:String = roadNumber == nil ? "": String(describing: roadNumber)
        return "\(id) \(localReportingMark) \(localRoadNumber)\n"
        }
    }
    
    func addItemURLParameters() -> String{
        
        var s = "?ID=\(id)"
        if var temp: String = reportingMark{
            temp = temp.URLEncode()
            s.append("&reportingMark=\(temp)")
        }
        if var temp: String = roadNumberPrefix {
            temp = temp.URLEncode()
            s.append("&roadNumberPrefix=\(temp)")
        }
        if let temp: Int = roadNumber {
            s.append("&roadNumber=\(temp)")
        }
        if var temp: String = roadNumberSuffix {
            temp = temp.URLEncode()
            s.append("&roadNumberSuffix=\(temp)")
        }
        if var temp: String = brand{
            temp = temp.URLEncode()
            s.append("&brand=\(temp)")
        }
        if var temp: String = ownerClass {
            temp = temp.URLEncode()
            s.append("&ownerClass=\(temp)")
        }
        if var temp: String = brandCatalogNumber{
            temp = temp.URLEncode()
            s.append("&brandCatalogNumber=\(temp)")
        }
        if var temp: String = AARClass {
            temp = temp.URLEncode()
            s.append("&AARClass=\(temp)")
        }
        if var temp: String = color {
            temp = temp.URLEncode()
            s.append("&color=\(temp)")
        }
        if var temp: String = carName {
            temp = temp.URLEncode()
            s.append("&carName=\(temp)")
        }
        if var temp: String = purchaseDate {
            temp = temp.URLEncode()
            s.append("&purchaseDate=\(temp)")
        }
        if let temp: Double = purchaseCost {
            s.append("&purchaseCost=\(temp)")
        }
        if var temp: String = purchasedFrom {
            temp = temp.URLEncode()
            s.append("&purchasedFrom=\(temp)")
        }
        if var temp: String = descriptionx {
            temp = temp.URLEncode()
            s.append("&description=\(temp)")
        }
        if var temp: String = wheelArrangement {
            temp = temp.URLEncode()
            s.append("&wheelArrangement=\(temp)")
        }
        if var temp: String = length {
            temp = temp.URLEncode()
            s.append("&length=\(temp)")
        }
        if var temp: String = category {
            temp = temp.URLEncode()
            s.append("&category=\(temp)")
        }
        if var temp: String = box {
            temp = temp.URLEncode()
            s.append("&box=\(temp)")
        }
        if var temp: String = paint {
            temp = temp.URLEncode()
            s.append("&paint=\(temp)")
        }
        if let temp: Int = storageContainer {
            s.append("&storageContainer=\(temp)")
        }
        if var temp: String = buildStatus {
            temp = temp.URLEncode()
            s.append("&buildStatus=\(temp)")
        }

        if var temp: String = wheelType {
            temp = temp.URLEncode()
            s.append("&wheelType=\(temp)")
        }
        if var temp: String = frontCoupler {
            temp = temp.URLEncode()
            s.append("&frontCoupler=\(temp)")
        }
        if var temp: String = rearCoupler {
            temp = temp.URLEncode()
            s.append("&rearCoupler=\(temp)")
        }
        

        
        if let temp: String = verified {
            s.append("&verified=\(temp)")
        }
        if var temp: String = tagged {
            temp = temp.URLEncode()
            s.append("&tagged=\(temp)")
        }
        if var temp: String = disposition {
            temp = temp.URLEncode()
            s.append("&disposition=\(temp)")
        }
        
        return s
    }
    
}
