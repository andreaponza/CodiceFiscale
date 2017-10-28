//
//  ViewController.swift
//  CodiceFiscale
//
//  Created by Andrea De Martino on 01/01/16.
//  Copyright © 2016 Andrea. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate, NSComboBoxDelegate {

    @IBOutlet weak var foreingButton: NSButtonCell!
    @IBOutlet weak var italyButton: NSButtonCell!
    @IBOutlet weak var nameBox: NSTextField!
    @IBOutlet weak var surnameBox: NSTextField!
    @IBOutlet weak var femaleButton: NSButtonCell!
    @IBOutlet weak var dateBox: NSDatePicker!
    @IBOutlet weak var cFTextBox: NSTextField!
    @IBOutlet weak var cityMenu: NSComboBox!
    @IBOutlet weak var provMenu: NSComboBox!
    
    let cfCalc = CFCalc()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var temp = String()
        for item in cfCalc.placeList() {
            item.province.removeFirst()
            if item.province != temp && item.province != "EE" {
                provMenu.addItem(withObjectValue: item.province)
            }
            temp = item.province
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
// My function
    @IBAction func calcolate(_ sender: Any) {
        var state = false
        if femaleButton.state.rawValue != 0 {
            state = true
        }
        if cityMenu.isEnabled {
            cFTextBox.stringValue = cfCalc.CFCalc(name: nameBox.stringValue, surname: surnameBox.stringValue, female: state, date: dateBox.dateValue, province: provMenu.stringValue, city: cityMenu.stringValue)
        }
        
    }
    
    @IBAction func fillCityMenu(_ sender: Any) {
        cityMenu.removeAllItems()
        for item in cfCalc.placeList(){
            if item.province == provMenu.selectedCell()?.stringValue{
                cityMenu.addItem(withObjectValue: item.city)
            }
        }
        cityMenu.isEnabled = true
        cityMenu.selectItem(at: 0)
    }
    
    @IBAction func foreingButtonSelected(_ sender: Any) {
        provMenu.isEnabled = false
        cityMenu.removeAllItems()
        provMenu.removeAllItems()
        provMenu.addItem(withObjectValue: "EE")
        provMenu.selectItem(at: 0)
        for item in cfCalc.placeList(){
            if item.province == provMenu.selectedCell()?.stringValue{
                cityMenu.addItem(withObjectValue: item.city)
            }
        }
        cityMenu.isEnabled = true
        cityMenu.selectItem(at: 0)
    }
    
    @IBAction func italianButtonSelected(_ sender: Any){
        provMenu.isEnabled = true
        provMenu.removeAllItems()
        cityMenu.removeAllItems()
        var temp = String()
        for item in cfCalc.placeList() {
            if item.province != temp && item.province != "EE" {
                provMenu.addItem(withObjectValue: item.province)
            }
            temp = item.province
        }
        provMenu.selectItem(at: 0)
        
        for item in cfCalc.placeList(){
            if item.province == provMenu.selectedCell()?.stringValue{
                cityMenu.addItem(withObjectValue: item.city)
            }
        }
        cityMenu.isEnabled = true
        cityMenu.selectItem(at: 0)
    }
}

/*extension ViewController: NSControlTextEditingDelegate {
    override func controlTextDidChange(_ notification: Notification) {
        if let textField = notification.object as? NSTextField {
            textField.stringValue.uppercased()
        }
    }
}*/



