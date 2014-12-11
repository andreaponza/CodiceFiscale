//
//  ViewController.swift
//  CFCalc
//
//  Created by Andrea De Martino on 03/12/14.
//  Copyright (c) 2014 Andrea. All rights reserved.
//

import Cocoa




class ViewController: NSViewController {

    @IBOutlet weak var nameBox: NSTextField!
    @IBOutlet weak var surnameBox: NSTextField!
    @IBOutlet weak var femaleButton: NSButtonCell!
    @IBOutlet weak var bornDateBox: NSDatePicker!
    @IBOutlet weak var provBox: NSComboBox!
    @IBOutlet weak var cityBox: NSComboBox!
    @IBOutlet weak var cfTextField: NSTextField!
    @IBOutlet weak var copyPbButton: NSButton!
    
    @IBOutlet weak var barCodeImage: NSImageView!
    
    var cityCodeList:[String] = []
    var cityCode:String = ""
    var comuniList:[Comune] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start fill provBox
        cfTextField.selectable = true
        var comuni = ComuniXMLParser(fromFileAtPath: NSBundle.mainBundle().pathForResource("comuni", ofType: "xml"))
        comuni.start()
        comuniList = comuni.getParsedItems()
        var provinceList:[String] = []
        
        for i in 0..<comuniList.count{
            if(i==0){
                provinceList.append(comuni[i].provincia)
            }
            else{
                if(provinceList.last != comuni[i].provincia){
                    provinceList.append(comuni[i].provincia)
                }
            }
        }
        provBox.addItemsWithObjectValues(provinceList)
        provBox.removeItemWithObjectValue("EE")
        //end fill provBox
    }

    //Calcolate Fiscal Code
    @IBAction func calcCF(sender: AnyObject) {
        var fiscalCode:CFCalc = CFCalc()
        
        
        cfTextField.stringValue = fiscalCode.calc(nameBox.stringValue, surname: surnameBox.stringValue, isFemale:femaleButton.state, bornDate:bornDateBox.dateValue, cityCode:cityCode)
        //bar code
        var error:NSError = NSError()
        var writer:ZXMultiFormatWriter = ZXMultiFormatWriter.writer() as ZXMultiFormatWriter
        var result:ZXBitMatrix = writer.encode(cfTextField.stringValue, format: kBarcodeFormatCode128, width: 282, height: 48, error: nil)
        var image:NSImage = NSImage(CGImage: (ZXImage(matrix: result).cgimage), size: NSZeroSize)
        barCodeImage.image = image
        
        copyPbButton.enabled = true
        }
    
    
    //Fill city Box
    @IBAction func fillCityBox(sender: AnyObject) {
        city()
    }
    
    //City code
    @IBAction func selectCityCode(sender: AnyObject) {
        cityCodeFunc()
    }
    
    //Italy foreing
    @IBAction func italy(sender: AnyObject) {
        provBox.enabled = true
        provBox.selectItemAtIndex(1)
        provBox.removeItemWithObjectValue("EE")
        city()
        cityCodeFunc()
    }
    @IBAction func foreing(sender: AnyObject) {
        provBox.addItemWithObjectValue("EE")
        provBox.selectItemWithObjectValue("EE")
        city()
        provBox.enabled = false
        cityBox.enabled = true
        cityBox.selectItemAtIndex(1)
    }
    //Function
    func city(){
        cityBox.enabled = true
        cityCode = ""
        cityBox.removeAllItems()
        
        var comuniListString:[String] = []
        
        for i in 0..<comuniList.count{
            if(comuniList[i].provincia == provBox.selectedCell()?.stringValue){
                comuniListString.append(comuniList[i].comune)
                cityCodeList.append(comuniList[i].codice)
            }
        }
        cityBox.addItemsWithObjectValues(comuniListString)
        cityBox.selectItemAtIndex(0)
        
        for i in 0..<comuniList.count{
            if(comuniList[i].comune == cityBox.selectedCell()?.stringValue){
                cityCode = comuniList[i].codice
            }
        }
    }
    
    func cityCodeFunc(){
        for i in 0..<comuniList.count{
            if(comuniList[i].comune == cityBox.selectedCell()?.stringValue){
                cityCode = comuniList[i].codice
            }
        }
    }
   
    @IBAction func copyPasteBoard(sender: AnyObject) {
        NSPasteboard.generalPasteboard().clearContents()
        var pasteboardString:NSString = cfTextField.stringValue.stringByReplacingOccurrencesOfString(" ", withString: "", options: nil)
        
        NSPasteboard.generalPasteboard().setString(pasteboardString, forType: NSPasteboardTypeString)
    }
    

}

