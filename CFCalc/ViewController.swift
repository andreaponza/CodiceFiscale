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
    
    var cityCodeList:[String] = []
    var cityCode:String = ""
    var comuniList:[Comune] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start fill provBox
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
        //end fill provBox
    }

    //Calcolate Fiscal Code
    @IBAction func calcCF(sender: AnyObject) {
        var fiscalCode:CFCalc = CFCalc()
        
        
        cfTextField.stringValue = fiscalCode.calc(nameBox.stringValue, surname: surnameBox.stringValue, isFemale:femaleButton.state, bornDate:bornDateBox.dateValue, cityCode:cityCode)
        
        }
    
    
    //Fill city Box
    @IBAction func fillCityBox(sender: AnyObject) {
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
    
    //City code
    @IBAction func selectCityCode(sender: AnyObject) {
        for i in 0..<comuniList.count{
            if(comuniList[i].comune == cityBox.selectedCell()?.stringValue){
               cityCode = comuniList[i].codice
            }
        }
    }
    
   

}

