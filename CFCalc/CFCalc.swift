//
//  CFcalc.swift
//  CFCalc
//
//  Created by Andrea De Martino on 04/12/14.
//  Copyright (c) 2014 Andrea. All rights reserved.
//

import Foundation
class CFCalc {
    var fiscalCode = "Please insert data!"
    
    
    func calc(var name:String, var surname:String, var isFemale:Int, var bornDate:NSDate, var cityCode:String) -> String
    {
        fiscalCode = elaborateSurname(surname) + " " + elaborateName(name) + " " + " " + elaborateDateString(bornDate, isFemale: isFemale) + " " + cityCode
        
        fiscalCode = fiscalCode + elaborateControlCharacter(fiscalCode)
        return fiscalCode
    }
    
    //Elaborate surname string
    func elaborateSurname(var surname:String)->String{
        surname = surname.uppercaseString
        
        var str:NSString = surname
        var consonant:NSString = str
        var vowel:NSString = str
        var result:NSString = ""
        
        for i in 0..<str.length{                                                                //remove vowel
            consonant = consonant.stringByReplacingOccurrencesOfString(" ", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("A", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("E", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("I", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("O", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("U", withString: "")
        }
        
        for i in 0..<str.length{                                                                //remove consonant
            vowel = vowel.stringByReplacingOccurrencesOfString(" ", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("B", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("C", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("D", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("F", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("G", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("H", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("J", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("K", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("L", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("M", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("N", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("P", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("Q", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("R", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("S", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("T", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("V", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("W", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("X", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("Y", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("Z", withString: "")
        }
        
        result = consonant + vowel + "XXX"
        return result.substringToIndex(3)
    }
    
    //Elaborate name string
    func elaborateName(var name:String)->String{
        name = name.uppercaseString
        
        var str:NSString = name
        var consonant:NSString = str
        var vowel:NSString = str
        var result:NSString = ""
        
        for i in 0..<str.length{                                                             //remove vowel
            consonant = consonant.stringByReplacingOccurrencesOfString(" ", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("A", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("E", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("I", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("O", withString: "")
            consonant = consonant.stringByReplacingOccurrencesOfString("U", withString: "")
        }
        
        for i in 0..<str.length{                                                            //remove consonant
            vowel = vowel.stringByReplacingOccurrencesOfString(" ", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("B", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("C", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("D", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("F", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("G", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("H", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("J", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("K", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("L", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("M", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("N", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("P", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("Q", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("R", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("S", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("T", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("V", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("W", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("X", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("Y", withString: "")
            vowel = vowel.stringByReplacingOccurrencesOfString("Z", withString: "")
        }
        
        
        if(consonant.length <= 3){
            result = consonant + vowel + "XXX"      //string < 3 character
        }
        else{
            result = consonant.substringToIndex(1)
            result = result.stringByAppendingString(consonant.substringFromIndex(2))
        }
        
        return result.substringToIndex(3)
      
    }
    
    //Elaborate date
    func elaborateDateString(date:NSDate, isFemale:Int) -> NSString{
        var dateString:NSString = NSString()
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        
        dateFormatter.dateFormat = "yy"
        var year = dateFormatter.stringFromDate(date)
        
        dateFormatter.dateFormat = "MM"                 //set month character
        var month = dateFormatter.stringFromDate(date)
        switch month {
        case "01":
            month = "A"
        case "02":
            month = "B"
        case "03":
            month = "C"
        case "04":
            month = "D"
        case "05":
            month = "E"
        case "06":
            month = "H"
        case "07":
            month = "L"
        case "08":
            month = "M"
        case "09":
            month = "P"
        case "10":
            month = "R"
        case "11":
            month = "S"
        case "12":
            month = "T"
        default:
            println("ERROR!")
        }
        
        dateFormatter.dateFormat = "dd"
        var day = dateFormatter.stringFromDate(date)
        if(Bool(isFemale))  //female case
        {
            var dayNumber = day.toInt()! + 40
            day = dayNumber.description
        }
        
        dateString = year + month + day
        return dateString
    }
    
    func elaborateControlCharacter(var code:NSString)->NSString
    {
        code = code.stringByReplacingOccurrencesOfString(" ", withString: "")
        var val = 0
        
        for var i = 0; i <= 14; i = i + 2 {                 //odd char
            switch (code.substringWithRange(NSMakeRange(i, 1))) {
            case "0":
                val = val + 1
                break;
            case "1":
                val = val + 0;
                break;
            case "2":
                val = val + 5;
                break;
            case "3":
                val = val + 7;
                break;
            case "4":
                val = val + 9;
                break;
            case "5":
                val = val + 13;
                break;
            case "6":
                val = val + 15;
                break;
            case "7":
                val = val + 17;
                break;
            case "8":
                val = val + 19;
                break;
            case "9":
                val = val + 21;
                break;
            case "A":
                val = val + 1;
                break;
            case "B":
                val = val + 0;
                break;
            case "C":
                val = val + 5;
                break;
            case "D":
                val = val + 7;
                break;
            case "E":
                val = val + 9;
                break;
            case "F":
                val = val + 13;
                break;
            case "G":
                val = val + 15;
                break;
            case "H":
                val = val + 17;
                break;
            case "I":
                val = val + 19;
                break;
            case "J":
                val = val + 21;
                break;
            case "K":
                val = val + 2;
                break;
            case "L":
                val = val + 4;
                break;
            case "M":
                val = val + 18;
                break;
            case "N":
                val = val + 20;
                break;
            case "O":
                val = val + 11;
                break;
            case "P":
                val = val + 3;
                break;
            case "Q":
                val = val + 6;
                break;
            case "R":
                val = val + 8;
                break;
            case "S":
                val = val + 12;
                break;
            case "T":
                val = val + 14;
                break;
            case "U":
                val = val + 16;
                break;
            case "V":
                val = val + 10;
                break;
            case "W":
                val = val + 22;
                break;
            case "X":
                val = val + 25;
                break;
            case "Y":
                val = val + 24;
                break;
            case "Z":
                val = val + 23;
                break;
            default:
                val = val + 0
            }
        }
        for var i = 1; i < 14; i = i + 2 {  //even char
            switch (code.substringWithRange(NSMakeRange(i, 1))) {
            case "0":
                val = val + 0;
                break;
            case "1":
                val = val + 1;
                break;
            case "2":
                val = val + 2;
                break;
            case "3":
                val = val + 3;
                break;
            case "4":
                val = val + 4;
                break;
            case "5":
                val = val + 5;
                break;
            case "6":
                val = val + 6;
                break;
            case "7":
                val = val + 7;
                break;
            case "8":
                val = val + 8;
                break;
            case "9":
                val = val + 9;
                break;
            case "A":
                val = val + 0;
                break;
            case "B":
                val = val + 1;
                break;
            case "C":
                val = val + 2;
                break;
            case "D":
                val = val + 3;
                break;
            case "E":
                val = val + 4;
                break;
            case "F":
                val = val + 5;
                break;
            case "G":
                val = val + 6;
                break;
            case "H":
                val = val + 7;
                break;
            case "I":
                val = val + 8;
                break;
            case "J":
                val = val + 9;
                break;
            case "K":
                val = val + 10;
                break;
            case "L":
                val = val + 11;
                break;
            case "M":
                val = val + 12;
                break;
            case "N":
                val = val + 13;
                break;
            case "O":
                val = val + 14;
                break;
            case "P":
                val = val + 15;
                break;
            case "Q":
                val = val + 16;
                break;
            case "R":
                val = val + 17;
                break;
            case "S":
                val = val + 18;
                break;
            case "T":
                val = val + 19;
                break;
            case "U":
                val = val + 20;
                break;
            case "V":
                val = val + 21;
                break;
            case "W":
                val = val + 22;
                break;
            case "X":
                val = val + 23;
                break;
            case "Y":
                val = val + 24;
                break;
            case "Z":
                val = val + 25;
                break;
            default:
                val = val + 0
            }
        }
        
        var result:String = ""
        var rest:Int = val % 26
        
        switch (rest) { //control char
        case 0:
            result =  "A";
        case 1:
            result =  "B";
        case 2:
            result =  "C";
        case 3:
            result =  "D";
        case 4:
            result =  "E";
        case 5:
            result =  "F";
        case 6:
            result =  "G";
        case 7:
            result =  "H";
        case 8:
            result =  "I";
        case 9:
            result =  "J";
        case 10:
            result =  "K";
        case 11:
            result =  "L";
        case 12:
            result =  "M";
        case 13:
            result =  "N";
        case 14:
            result =  "O";
        case 15:
            result =  "P";
        case 16:
            result =  "Q";
        case 17:
            result =  "R";
        case 18:
            result =  "S";
        case 19:
            result =  "T";
        case 20:
            result =  "U";
        case 21:
            result =  "V";
        case 22:
            result =  "W";
        case 23:
            result =  "X";
        case 24:
            result =  "Y";
        case 25:
            result =  "Z";
        default:
            result =  "";
        }
            return result
    }
}