import Cocoa
import Foundation

//Comune Class

class Comune: NSObject {
    var provincia: String = ""
    var comune: String = ""
    var codice: String = ""
}

//ComuniXMLParser

class ComuniXMLParser: NSObject, NSXMLParserDelegate {
    
    var XMLfile: NSInputStream
    var parser: NSXMLParser
    var currentItem: Comune?
    var parsedItems: [Comune] = []                        // final result of parse is stored here
    var currentString: String = ""
    var storingCharacters = false
    var startTime = NSTimeInterval()
    var lastDuration = NSTimeInterval()
    var done = true
    
    subscript(i: Int) -> Comune {                         // so we can index right into the array of results
        return parsedItems[i]
    }
    
    init(fromFileAtPath path: String!) {                // initialize with path to a valid XML file
        XMLfile = NSInputStream(fileAtPath: path)!
        parser = NSXMLParser(stream: XMLfile)
        super.init()
    }
    
    func getParsedItems() -> [Comune] {
        return parsedItems
    }
    
    func getLastDuration() -> NSTimeInterval {
        return lastDuration
    }
    
    func displayItems() {
        for item in parsedItems {
            print("Provincia: \(item.provincia) ")
            print("Comune: \(item.comune) ")
            print("Codice: \(item.codice)\n")
            
        }
    }
    
    func start() {                                      // call after init with an XML file to begin parse
        currentItem = nil
        parsedItems = []
        currentString = ""
        readAndParse()
    }
    
    func readAndParse() {
        parser.delegate = self                          // make this object the delegate for the parser object
        done = false
        parser.parse()
        
        
        
    }
    
    func finishedCurrentItem() {
        parsedItems.append(currentItem!)                // keep track of parsed Comune objects
    }
    
    //NSXMLParserDelegate
    
    func parserDidStartDocument(parser: NSXMLParser) {
        startTime = NSDate.timeIntervalSinceReferenceDate()     // simple timer hack
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        done = true
        lastDuration = NSDate.timeIntervalSinceReferenceDate() - startTime
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        if elementName == "item" {
            currentItem = Comune()
            }
        else if elementName == "provincia" || elementName == "comune" || elementName == "codice" {
            currentString = ""
            storingCharacters = true
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if let item = currentItem {
            if elementName == "item" {
                finishedCurrentItem()
            } else if elementName == "provincia" {
                item.provincia = currentString
            } else if elementName == "comune" {
                item.comune = currentString
            } else if elementName == "codice" {
                item.codice = currentString
            }
            storingCharacters = false
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if storingCharacters == true {
            currentString += string
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print(parseError.localizedFailureReason)
        print(parseError.localizedDescription)
        //error handling
    }
    
  
}
