//
//  CFcalc.swift
//  CFCalc
//
//  Created by Andrea De Martino on 04/12/14.
//  Copyright (c) 2014 Andrea. All rights reserved.
//

import Foundation
import Cocoa

class CFCalc: NSObject {
    var fiscalCode = "Please insert data!"
    let parserBase = ParserBase()
    
    override init() {
        let xml = try? String(contentsOfFile: Bundle.main.path(forResource: "comuni", ofType: "xml")!)
        let xmlData = xml?.data(using: .utf8)!
        let parser = XMLParser(data: xmlData!)
        parser.delegate = parserBase
        parser.parse()
    }
    
    func CFCalc(name: String, surname: String, female: Bool, date: Date, province: String, city: String) -> String {
        
        var fiscalCode = String()
        var tmpString = String()
        
        //Calculate surname string
        tmpString = vowelToEnd(string: surname)
        if tmpString.count < 3 {tmpString.append("XXX")}
        fiscalCode.append(Array(tmpString)[0])
        fiscalCode.append(Array(tmpString)[1])
        fiscalCode.append(Array(tmpString)[2])
        tmpString = ""
        
        //Calculate name string
        tmpString = vowelToEnd(string: name)
        let vowel = CharacterSet.init(charactersIn: "AaEeIiOoUu")
        
        if tmpString.count < 3 {tmpString.append("XXX")}
        
        if (tmpString.components(separatedBy: vowel)[0].count <= 3){
            fiscalCode.append(Array(tmpString)[0])
            fiscalCode.append(Array(tmpString)[1])
            fiscalCode.append(Array(tmpString)[2])
            tmpString = ""
        }
        else {
            fiscalCode.append(Array(tmpString)[0])
            fiscalCode.append(Array(tmpString)[2])
            fiscalCode.append(Array(tmpString)[3])
            tmpString = ""
        }
        
        //Check gender and calculate date string
        let mounthChar = "XABCDEHLMPRST"
        let day = DateFormatter()
        let mounth = DateFormatter()
        let year = DateFormatter()
        day.setLocalizedDateFormatFromTemplate("dd")
        mounth.setLocalizedDateFormatFromTemplate("MM")
        year.setLocalizedDateFormatFromTemplate("yy")
        
        fiscalCode.append(year.string(from: date)) //Year Value
        
        fiscalCode.append(Array(mounthChar)[Int(mounth.string(from: date))!])//Mounth Value
        
        if female{
            let dayNumber = Int(day.string(from: date))! + 40
            fiscalCode.append(String(dayNumber))
        }
        else{
            fiscalCode.append(day.string(from: date))
        }
        
        //Calculate city code
        
        
        for element in parserBase.items{
            if element.city == city.uppercased(){
                fiscalCode.append(element.cityCode)
                break
            }
        }
        
        //Calculate control char
        let evens = ["0":0, "1":1, "2":2, "3":3, "4":4, "5":5, "6":6, "7":7, "8":8, "9":9, "A":0, "B":1, "C":2, "D":3, "E":4, "F":5, "G":6, "H":7, "I":8, "J":9, "K":10, "L":11, "M":12, "N":13, "O":14, "P":15, "Q":16, "R":17, "S":18, "T":19, "U":20, "V":21, "W":22, "X":23, "Y":24, "Z":23]
        
        let odds = ["0":1, "1":0, "2":5, "3":7, "4":9, "5":13, "6":15, "7":17, "8":19, "9":21, "A":1, "B":0, "C":5, "D":7, "E":9, "F":13, "G":15, "H":17, "I":19, "J":21, "K":2, "L":4, "M":18, "N":20, "O":11, "P":3, "Q":6, "R":8, "S":12, "T":14, "U":16, "V":10, "W":22, "X":25, "Y":24, "Z":23]
        
        let ctrlChar = [0:"A", 1:"B", 2:"C", 3:"D", 4:"E", 5:"F", 6:"G", 7:"H", 8:"I", 9:"J", 10:"K", 11:"L", 12:"M", 13:"N", 14:"O", 15:"P", 16:"Q", 17:"R", 18:"S", 19:"T", 20:"U", 21:"V", 22:"W", 23:"X", 24:"Y", 25:"Z"]
        
        let cfarray = Array(fiscalCode)
        
        let i:Int = odds[String(cfarray[0])]! + evens[String(cfarray[1])]! + odds[String(cfarray[2])]! + evens[String(cfarray[3])]! + odds[String(cfarray[4])]! + evens[String(cfarray[5])]! + odds[String(cfarray[6])]! + evens[String(cfarray[7])]! + odds[String(cfarray[8])]! + evens[String(cfarray[9])]! + odds[String(cfarray[10])]! + evens[String(cfarray[11])]! + odds[String(cfarray[12])]! + evens[String(cfarray[13])]! + odds[String(cfarray[14])]!
        
        fiscalCode.append(ctrlChar[i%26]!)
        
        return fiscalCode
        
    }
    
    func vowelToEnd(string:String) -> String {
        var consonantsString = String()
        var vowelsString = String()
        let vowel = CharacterSet.init(charactersIn: "AaEeIiOoUu")
        for char in string{
            if (String(char).rangeOfCharacter(from: vowel) != nil){
                vowelsString.append(char)
            }
            else{
                consonantsString.append(char)
            }
        }
        return (consonantsString + vowelsString).uppercased().replacingOccurrences(of: " ", with: "")
    }
    
    func placeList() -> Array<City>{
        return parserBase.itemList()
    }
    
}
