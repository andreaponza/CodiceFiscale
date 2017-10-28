import Cocoa
import Foundation

class City{
    var province = String()
    var city = String()
    var cityCode = String()
}

class ParserBase : NSObject, XMLParserDelegate  {
    public var items = [City]()
    var city = City()
    var foundCharacters = ""
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            let temp = City();
            if let name = attributeDict["provincia"] {
                temp.province = name;
            }
            if let city = attributeDict["comune"] {
                temp.city = city;
            }
            if let codice = attributeDict["codice"] {
                temp.cityCode = codice;
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        foundCharacters += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "provincia" {
            city.province = foundCharacters
        }
        
        if elementName == "comune" {
            city.city = foundCharacters
        }
        
        if elementName == "codice" {
            city.cityCode = foundCharacters
        }
        
        if elementName == "item" {
            let tempItem = City()
            tempItem.province = city.province
            tempItem.city = city.city
            tempItem.cityCode = city.cityCode
            items.append(tempItem)
        }
        foundCharacters = ""
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        //print("Ok")
    }
    
    func itemList() -> Array<City>{
        return self.items
    }
}
