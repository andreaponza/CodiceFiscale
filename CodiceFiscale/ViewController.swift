//
//  ViewController.swift
//  CodiceFiscale
//
//  Created by Andrea De Martino on 01/01/16.
//  Copyright © 2016 Andrea. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var nameTextBox: NSTextField!
    @IBOutlet weak var surnameTextBox: NSTextField!
    @IBOutlet weak var dateTextBox: NSDatePicker!
    @IBOutlet weak var provTextBox: NSComboBox!
    @IBOutlet weak var cityTextBox: NSComboBox!
    @IBOutlet weak var femaleButton: NSButtonCell!
    @IBOutlet weak var foreingButton: NSButtonCell!
    @IBOutlet weak var fiscalCodeTextBox: NSTextField!
    @IBOutlet weak var pasteButton: NSButton!
    
    var cityCodeList:[String] = []
    var cityCode:String = ""
    var comuniList:[Comune] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fiscalCodeTextBox.selectable = true
        let comuni = ComuniXMLParser(fromFileAtPath: NSBundle.mainBundle().pathForResource("comuni", ofType: "xml"))
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
        provTextBox.addItemsWithObjectValues(provinceList)
        cityTextBox.removeItemWithObjectValue("EE")
        //end fill provBox
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
   
    @IBAction func calcolate(sender: AnyObject) {
        let fiscalCode:CFCalc = CFCalc()
        
        
        fiscalCodeTextBox.stringValue = fiscalCode.calc(nameTextBox.stringValue, surname: surnameTextBox.stringValue, isFemale:femaleButton.state, bornDate:dateTextBox.dateValue, cityCode:cityCode)
        
        pasteButton.enabled = true
    }
    
    @IBAction func fillCityBox(sender: AnyObject) {
        city()
    }
    
    //City code
    @IBAction func selectCityCode(sender: AnyObject) {
        cityCodeFunc()
    }
    
    //Italy foreing
    @IBAction func italy(sender: AnyObject) {
        provTextBox.enabled = true
        provTextBox.selectItemAtIndex(0)
        provTextBox.removeItemWithObjectValue("EE")
        city()
        cityCodeFunc()
    }
    @IBAction func foreing(sender: AnyObject) {
        provTextBox.addItemWithObjectValue("EE")
        provTextBox.selectItemWithObjectValue("EE")
        city()
        provTextBox.enabled = false
        //provTextBox.enabled = true
        provTextBox.selectItemAtIndex(98)
    }
    //Function
    func city(){
        cityTextBox.enabled = true
        cityCode = ""
        cityTextBox.removeAllItems()
        
        var comuniListString:[String] = []
        
        for i in 0..<comuniList.count{
            if(comuniList[i].provincia == provTextBox.selectedCell()?.stringValue){
                comuniListString.append(comuniList[i].comune)
                cityCodeList.append(comuniList[i].codice)
            }
        }
        cityTextBox.addItemsWithObjectValues(comuniListString)
        cityTextBox.selectItemAtIndex(0)
        
        for i in 0..<comuniList.count{
            if(comuniList[i].comune == cityTextBox.selectedCell()?.stringValue){
                cityCode = comuniList[i].codice
            }
        }
    }
    
    func cityCodeFunc(){
        for i in 0..<comuniList.count{
            if(comuniList[i].comune == cityTextBox.selectedCell()?.stringValue){
                cityCode = comuniList[i].codice
            }
        }
    }

    @IBAction func code2cliboard(sender: AnyObject) {
        NSPasteboard.generalPasteboard().clearContents()
        let pasteboardString:NSString = fiscalCodeTextBox.stringValue.stringByReplacingOccurrencesOfString(" ", withString: "", options: [])
        
        NSPasteboard.generalPasteboard().setString(pasteboardString as String, forType: NSPasteboardTypeString)
    }

}

