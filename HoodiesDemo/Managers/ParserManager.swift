//
//  ParserManager.swift
//  HoodiesDemo
//
//  Created by Sergey Monastyrskiy on 14.05.2020.
//  Copyright © 2020 Sergey Monastyrskiy. All rights reserved.
//

import UIKit

class ParserManager: XMLParser {
    // MARK: - Properties
    var itemCD: CD!
    var catalog: [CD]!
    var completed: (([CD]) -> Void)?
    private var elementName: String!
}


// MARK: - XMLParserDelegate
extension ParserManager: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        catalog = [CD]()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "CD" {
            self.itemCD = CD()
        }

        self.elementName = elementName.lowercased()
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "CD" {
            self.catalog.append(self.itemCD)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let dataCD = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!dataCD.isEmpty) {
            switch elementName {
            case "title":
                self.itemCD.title += dataCD

            case "artist":
                self.itemCD.artist += dataCD

            case "country":
                self.itemCD.country += dataCD

            case "company":
                self.itemCD.company += dataCD

            case "price":
                self.itemCD.price += dataCD

            case "year":
                self.itemCD.year += dataCD

            default:
                break
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print(catalog ?? "XXX")
        self.completed!(catalog)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError)

        self.elementName = nil
        self.itemCD = nil
        self.catalog = nil

    }
}
