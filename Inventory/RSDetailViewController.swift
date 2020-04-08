
//  RSDetailViewController.swift
//  Inventory
//
//  Created by dalemuir on 10/25/16.
//  Copyright © 2016 Dale Muir. All rights reserved.
//

import UIKit


enum EditMode { case initialize, showDetail, add, update }

var buildStatusData = [String](arrayLiteral: "","KIT", "RTR","BUILT", "IN PROGRESS","READY" )

class RSDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var reportingMarkField: UITextField!
    @IBOutlet weak var carNumberPrefixField: UITextField!
    @IBOutlet weak var carNumberField: UITextField!
    @IBOutlet weak var carNumberPostfixField: UITextField!
    @IBOutlet weak var ownerClassField: UITextField!
    @IBOutlet weak var AARClassField: UITextField!
    @IBOutlet weak var carNameField: UITextField!
    @IBOutlet weak var lengthField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var wheelArrangementField: UITextField!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var catalogNumberField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBAction func clearDescription(_ sender: AnyObject) {
        descriptionField.text = ""
    }
    @IBOutlet weak var boxField: UITextField!
    @IBOutlet weak var paintField: UITextField!
    @IBOutlet weak var buildStatusField: UITextField!
    @IBOutlet weak var wheelTypeField: UITextField!
    @IBOutlet weak var frontCouplerField: UITextField!
    @IBOutlet weak var rearCouplerField: UITextField!
    
    @IBOutlet weak var purchaseDateField: UITextField!
    @IBOutlet weak var purchaseCostField: UITextField!
    @IBOutlet weak var purchasedFromField: UITextField!
    @IBOutlet weak var storageContainerField: UITextField!
    @IBOutlet weak var verifiedField: UITextField!
    @IBOutlet weak var taggedField: UITextField!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var modifiedLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dispositionField: UITextField!
    
    @IBOutlet weak var cloneButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var clearDescriptionButton: UIButton!
    
    @IBAction func reportingMarkEditBegin(_ sender: Any) {
        reportingMarkData = reporingMarkDataSourceInstance.reportingMarkItems
        pickerOrKeyboardFieldEditBegin(textFieldIn: reportingMarkField, pickerDataIn: reportingMarkData)
    }
    
    
    
    
    @IBAction func brandEditBegin(_ sender: Any) {
        brandData = brandDataSourceInstance.brandItems
        pickerOrKeyboardFieldEditBegin(textFieldIn: brandField, pickerDataIn: brandData)
    }
    
    func pickerOrKeyboardFieldEditBegin(textFieldIn: UITextField, pickerDataIn: [String]) {
        thePickerData = pickerDataIn
        //keyboardMode = true
        previousFieldValue = textFieldIn.text!
        pickerOrKeyboardField = textFieldIn
        togglePickerAndKeyboard()
    }

    
    @IBAction func clone(_ sender: Any) {
        self.mode = .add
        let nextId = RollingStockMasterFilter.sharedInstance.nextId()
        IDField.text = String(nextId)

        enableFieldEditing(isEnabled: true)
        configureView()
    }
    
    
    @IBAction func save(_ sender: AnyObject) {
 
        let filter = RollingStockMasterFilter.sharedInstance
        filter.selectedItemId = Int(IDField.text!)
        
        switch mode {
        case .add:
            addItem()
        case .update:
            updateItem()
        default:
            print("save should not be here")
        }
        
        if pickerDataMayBeDirty {
            brandDataSourceInstance.isDirty = true
            reporingMarkDataSourceInstance.isDirty = true
            reporingMarkDataSourceInstance.getReportingMarkItems()
        }
        
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
                
        // go back to the normal detail view
        
        if let vc: RollingStockMasterViewController = masterViewController {
            vc.showDetail()
        }
        
        
        switch mode {
        case .add:
            if let vc: RollingStockMasterViewController = masterViewController {
                vc.showDetail()
            }
        case .update:
            configureView()
        default:
            print("save should not be here")
        }
        
    }
    
    var currentDateField: UITextField?
    
    @IBAction func purchaseDateDidBeginEditing(_ sender: UITextField) {
        configureDatePickerForTextField(sender: sender)
    }
    
    @IBAction func verifiedDidBeginEditing(_ sender: UITextField) {
        configureDatePickerForTextField(sender: sender)
    }
    
    //var thePickerTextField = UITextField()
    let thePicker = UIPickerView()
    var thePickerData = [String]()
    
    var reporingMarkDataSourceInstance = ReportingMarkDataSource.sharedInstance
    let brandDataSourceInstance = BrandDataSource.sharedInstance

    var reportingMarkData: [String] = []
    var brandData: [String] = []
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        if let textField: UITextField = currentDateField {
           textField.text = sender.date.sqlDateFormat()
        }
    }

 
    
    func configureDatePickerForTextField(sender: UITextField){
        
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(RSDetailViewController.datePickerValueChanged), for: UIControl.Event.valueChanged)
        
        currentDateField = sender
        
        sender.text = datePickerView.date.sqlDateFormat()
        
    }
    
    @IBAction func frontCouplerEditingDidEnd(_ sender: UITextField) {
        let fcoupler = frontCouplerField.text
        let rcoupler = rearCouplerField.text
        
        if rcoupler == "" && fcoupler != "" {
            rearCouplerField.text = frontCouplerField.text
        }
    }
    
    @IBAction func buildStatusEditBegin(_ sender: Any) {
        thePickerData = buildStatusData
        pickerOrKeyboardField = buildStatusField
        thePicker.reloadAllComponents()
        selectPickerRow()
        
    }
    
    
    var mode: EditMode =  EditMode.initialize
    var masterViewController: RollingStockMasterViewController?
    var buttonArray: [UIButton] = []
    var numberFieldArray:[UITextField] = []
    var textFieldArray:[UITextField] = []

    
    var detailItem: RollingStockMasterItem?
    
    // inputToolbar
    let inputToolbar = UIToolbar()
    
    // inputToolbar buttons
    let inputToolbarSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let inputToolvarCancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(RSDetailViewController.cancelClick))
    let inputToolbarResetButton = UIBarButtonItem(title: "Reset Value", style: .plain, target: self, action: #selector(RSDetailViewController.resetValueClick))
    let inputToolbarUseKeyboardButton = UIBarButtonItem(title: "Use Keyboard", style: .plain, target: self, action: #selector(RSDetailViewController.useKeyboardButtonClick))
    let inputToolbarUsePickerButton = UIBarButtonItem(title: "Use Picker", style: .plain, target: self, action: #selector(RSDetailViewController.usePickerButtonClick))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        buttonArray.append(saveButton)
        buttonArray.append(cancelButton)
        buttonArray.append(clearDescriptionButton)
        buttonArray.append(cloneButton)
        
        configureNumberFieldArray()
        configureNumberFields()
        
        configureTextFieldArray()
        configureTextFields()
        
        registerForKeyboardNotifications()
        
        // begin picker section
        thePicker.delegate = self
        
        // end picker section

        
        configurePickerFields()
        
        
        // Toolbar configuration
        
        inputToolbar.barStyle = .default
        inputToolbar.isTranslucent = true
        inputToolbar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        inputToolbar.sizeToFit()
        
        inputToolbar.isUserInteractionEnabled = true
        reportingMarkField.inputAccessoryView = inputToolbar
        brandField.inputAccessoryView = inputToolbar
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshReportingMarks), name: NSNotification.Name(rawValue: "reportingMarksUpdated"), object: nil)
        
        keyboardMode = false
        togglePickerAndKeyboard()

    }
    
    @objc func refreshReportingMarks(){
        reportingMarkData = reporingMarkDataSourceInstance.reportingMarkItems
    }
    
    @objc func useKeyboardButtonClick() {
        keyboardMode = true
        togglePickerAndKeyboard()
    }
    
    @objc func usePickerButtonClick() {
        keyboardMode = false
        togglePickerAndKeyboard()
    }
    
    @objc func cancelClick() {
        pickerOrKeyboardField.resignFirstResponder()
    }
    @objc func resetValueClick() {
        pickerOrKeyboardField.text = previousFieldValue
        if !keyboardMode {
            selectPickerRow()
        }
    }

    var keyboardMode = false
    var previousKeyboardMode = true
    var pickerOrKeyboardField: UITextField = UITextField()
    var previousFieldValue: String = ""
    var pickerDataMayBeDirty = false
    
    func togglePickerAndKeyboard() {
        
        // Do not re-execute if keyboard mode did not change.
        //         Otherwise the stack is blown because the function is called multiple times
        if previousKeyboardMode == keyboardMode {
            return
        } else {
            previousKeyboardMode = keyboardMode
        }
        
        
        if keyboardMode {
            inputToolbar.setItems([inputToolvarCancelButton,inputToolbarSpaceButton, inputToolbarResetButton,inputToolbarSpaceButton, inputToolbarUsePickerButton], animated: false)
            pickerOrKeyboardField.inputView = nil
            thePicker.resignFirstResponder()

        } else {
            inputToolbar.setItems([inputToolvarCancelButton,inputToolbarSpaceButton, inputToolbarResetButton,inputToolbarSpaceButton, inputToolbarUseKeyboardButton], animated: false)

            let index = thePickerData.firstIndex(of: (pickerOrKeyboardField.text?.uppercased())!)
            if nil == index {
                thePickerData.append((pickerOrKeyboardField.text?.uppercased())!)
                thePickerData.sort()
                pickerDataMayBeDirty = true
            }
            thePicker.reloadAllComponents()
            pickerOrKeyboardField.inputView = thePicker
            selectPickerRow()

        }
        
        // Change input: keyboard or picker
        pickerOrKeyboardField.resignFirstResponder()
        pickerOrKeyboardField.becomeFirstResponder()
    }

    func configurePickerFields() {
        buildStatusField.inputView = thePicker
        buildStatusField.clearButtonMode = .always
        
        brandField.inputView = thePicker
        brandField.clearButtonMode = .always
        
        reportingMarkField.inputView = thePicker
        reportingMarkField.clearButtonMode = .always

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureView()
        configurePickerFields()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureNumberFieldArray(){
        numberFieldArray.append(IDField)
        numberFieldArray.append(carNumberField)
        numberFieldArray.append(lengthField)
        numberFieldArray.append(wheelArrangementField)
        numberFieldArray.append(purchaseCostField)
        numberFieldArray.append(storageContainerField)
        numberFieldArray.append(purchaseDateField)
        numberFieldArray.append(frontCouplerField)
        numberFieldArray.append(rearCouplerField)
    }
    
    
    func configureTextFieldArray(){
        textFieldArray.append(reportingMarkField)
        textFieldArray.append(carNumberPrefixField)
        textFieldArray.append(carNumberPostfixField)
        textFieldArray.append(ownerClassField)
        textFieldArray.append(AARClassField)
        textFieldArray.append(carNameField)
        textFieldArray.append(categoryField)
        textFieldArray.append(colorField)
        textFieldArray.append(brandField)
        textFieldArray.append(catalogNumberField)
        textFieldArray.append(paintField)
        textFieldArray.append(buildStatusField)
        textFieldArray.append(wheelTypeField)
        textFieldArray.append(purchasedFromField)
        textFieldArray.append(verifiedField)
        textFieldArray.append(taggedField)
        textFieldArray.append(boxField)
        textFieldArray.append(dispositionField)
    }
    
    
    
    
    func enableFieldEditing(isEnabled: Bool){
        
        var fieldArray: [UITextField] = []
        fieldArray.append(contentsOf: numberFieldArray)
        fieldArray.append(contentsOf: textFieldArray)
        
        for field in fieldArray{
            field.isEnabled = isEnabled
            if isEnabled{
                field.clearButtonMode = .never
            } else {
                field.clearButtonMode = .never
                field.placeholder = nil
            }
        }
        
        descriptionField.isEditable = isEnabled
        
    }
    
    func addItem(){
        
        let item = populateItemFromUI()
        
        RollingStockMasterFilter.sharedInstance.addItem(item: item)
        
        showAddUpdateCompleteAlert(addOrUpdate: "Add")
        
        // sleep(5)
        //let newid = item.id + 1
        //IDField.text = String(newid)
        
    }
    
    func showAddUpdateCompleteAlert(addOrUpdate: String ) {

        var alertMessage = addOrUpdate + " item " + IDField.text! + " "
        alertMessage = alertMessage + reportingMarkField.text! + " " + carNumberField.text! + " Complete"
        let alert = UIAlertController(title: addOrUpdate, message: alertMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
        alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func configureNumberFields(){
        for field in numberFieldArray {
            configureNumberField(textField: field)
        }
    }
    
    func configureTextFields(){
        for field in textFieldArray {
            configureTextField(textField: field)
        }
    }
    
    func configureNumberField(textField: UITextField){
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = UIKeyboardType.decimalPad
    }
    
    func configureTextField(textField: UITextField)  {
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .alphabet
        textField.autocapitalizationType = .allCharacters
        
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        switch  mode {
        case .showDetail:
            view.isHidden = false
            enableFieldEditing(isEnabled: false)
            ButtonUtil.configureButtonArray(buttonArray: buttonArray, isEnabled: false, isHidden: true)
            
            populateUIFromItem()
            
        case .add:
            view.isHidden = false
            enableFieldEditing(isEnabled: true)
            
            ButtonUtil.configureButtonArray(buttonArray: buttonArray, isEnabled: true, isHidden: false)
            cancelButton.setTitle("Cancel", for: .normal)

            let id = RollingStockMasterFilter.sharedInstance.nextId()
            IDField.text = String(id)
            
            purchaseDateField.clearButtonMode = .whileEditing
            verifiedField.clearButtonMode = .whileEditing
            
            // Syc picker items
            
            
        case .update:
            
            enableFieldEditing(isEnabled: true)
            IDField.isEnabled = false // Override, can't update id
            
            ButtonUtil.configureButtonArray(buttonArray: buttonArray, isEnabled: true, isHidden: false)
            cancelButton.setTitle("Reset", for: .normal)

            purchaseDateField.clearButtonMode = .whileEditing
            verifiedField.clearButtonMode = .whileEditing
            populateUIFromItem()
            
        default:
            print("default")
            //view.isHidden = true
            view.isHidden = false
            enableFieldEditing(isEnabled: false)
            ButtonUtil.configureButtonArray(buttonArray: buttonArray, isEnabled: false, isHidden: true)
            
            // populateUIFromItem()

        }
    }
    
    func populateUIFromItem(){
        if let detail: RollingStockMasterItem = self.detailItem {
            
            IDField.text = String( detail.id )
            
            reportingMarkField.text = detail.reportingMark
            carNumberPrefixField.text = detail.roadNumberPrefix
            if let n: Int = detail.roadNumber {
                carNumberField.text = String(n)
            }
            carNumberPostfixField.text = detail.roadNumberSuffix
            ownerClassField.text = detail.ownerClass
            AARClassField.text = detail.AARClass
            carNameField.text = detail.carName
            lengthField.text = detail.length
            categoryField.text = detail.category
            wheelArrangementField.text = detail.wheelArrangement
            colorField.text = detail.color
            brandField.text = detail.brand
            catalogNumberField.text = detail.brandCatalogNumber
            if let temp: String = detail.descriptionx{
            descriptionField.text = temp.URLDecode()
            }
            boxField.text = detail.box
            paintField.text = detail.paint
            buildStatusField.text = detail.buildStatus
            wheelTypeField.text = detail.wheelType
            frontCouplerField.text = detail.frontCoupler
            rearCouplerField.text = detail.rearCoupler
            purchaseDateField.text = detail.purchaseDate
            if let n: Double = detail.purchaseCost {
                purchaseCostField.text = String(n)
            }
            purchasedFromField.text = detail.purchasedFrom
            if let n: Int = detail.storageContainer {
                storageContainerField.text = String(n)
            }
            verifiedField.text = detail.verified
            taggedField.text = detail.tagged
            dispositionField.text = detail.disposition
            
            createdLabel.text = detail.created
            modifiedLabel.text = detail.modified
            
            if detail.state == "A" {
                statusLabel.text = "Active"
            } else if detail.state == "D"{
                statusLabel.text = "Deleted"
            } else {
                statusLabel.text = detail.state
            }
            
        }
    }
    
    func populateItemFromUI() -> RollingStockMasterItem{
        
        let id: Int = Int( IDField.text! )!
        
        var roadNumber: Int? = nil
        if let r: Int = Int( carNumberField.text!) {
            roadNumber = r
        }
        var purchaseCost: Double? = nil
        if let x: Double = Double (purchaseCostField.text!){
            purchaseCost = x
        }
        var storageContainer: Int? = nil
        if let x: Int = Int( storageContainerField.text!) {
            storageContainer = x
        }
        
        let item = RollingStockMasterItem(id: id, reportingMark: reportingMarkField.text, roadNumberPrefix: carNumberPrefixField.text, roadNumber: roadNumber, roadNumberSuffix: carNumberPostfixField.text, brand: brandField.text, brandCatalogNumber: catalogNumberField.text, ownerClass: ownerClassField.text, AARClass: AARClassField.text, color: colorField.text, modified: nil, carName: carNameField.text, state: nil, created: nil, purchaseDate: purchaseDateField.text, purchaseCost: purchaseCost, purchasedFrom: purchasedFromField.text, descriptionx: descriptionField.text, wheelArrangement: wheelArrangementField.text, length: lengthField.text, category: categoryField.text, box: boxField.text, storageContainer: storageContainer, buildStatus: buildStatusField.text, verified: verifiedField.text, tagged: taggedField.text, disposition: dispositionField.text, paint: paintField.text, wheelType: wheelTypeField.text, frontCoupler: frontCouplerField.text, rearCoupler: rearCouplerField.text)
        
        
        
        return item
        
    }
    
    func updateItem() {
        
        let item = populateItemFromUI()
        
        RollingStockMasterFilter.sharedInstance.updateItem(item: item)
        
        showAddUpdateCompleteAlert(addOrUpdate: "Update")

    }
    
    // Begin keyboard scrolling section
    
    func registerForKeyboardNotifications()
    {
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(self, selector: #selector(RSDetailViewController.UIKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RSDetailViewController.UIKeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var isAdjusted = false
    
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        //print(notification)
        let keyboardFrame = value.cgRectValue
        if (show == true && isAdjusted == false ) || show == false && isAdjusted == true {
            isAdjusted = !isAdjusted
            let adjustmentHeight = (keyboardFrame.height + 60) * (show ? 1 : -1)
            scrollView.contentInset.bottom += adjustmentHeight
            scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
            
            if !show {
                scrollView.contentInset.bottom = 0.0
                scrollView.scrollIndicatorInsets.bottom = 0.0
                scrollView.frame.origin.y = 0.0
                
                //                let contentInsets : UIEdgeInsets = UIEdgeInsets.zero
                //                scrollView.contentInset = contentInsets
                //                scrollView.scrollIndicatorInsets = contentInsets
                
            }
        }
    }
    
    @objc func UIKeyboardWillShow(notification: NSNotification) {
        adjustInsetForKeyboardShow(show: true, notification: notification)
    }
    
    @objc func UIKeyboardWillHide(notification: NSNotification) {
        adjustInsetForKeyboardShow(show: false, notification: notification)
    }
    
    
    // End keyboard scrolling section
    
    // Begin UIPickerView section
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return thePickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return thePickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerOrKeyboardField.text = thePickerData[row]
    }
    
    // End UIPickerView section

    func selectPickerRow() {
        let index = thePickerData.firstIndex(of: (pickerOrKeyboardField.text?.uppercased())!)
        if nil == index{
            thePicker.selectRow(0, inComponent: 0, animated: true)
        } else {
            thePicker.selectRow(index!, inComponent: 0, animated: true)
        }
    }


}
