//
//  DataSource.swift
//  News
//
//  Created by Marcelo on 25/7/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class Parser: NSObject {
    
    var totalNews: [News] = []
    var news = News()
    var foundCharacters = ""

    func parseFromURL(url: URL, completion: @escaping ([News]) -> ()) {
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self

        if parser?.parse() != nil {
            completion(totalNews)
        }
    }
    
}

extension Parser: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.foundCharacters += string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "media:thumbnail" {
            news.imageURL = attributeDict["url"]
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "title" {
            news.title = foundCharacters
        }
        
        if elementName == "description" {
            news.newsDescription = foundCharacters
        }
        
        if elementName == "link" {
            news.newsURL = foundCharacters
        }

        if elementName == "pubDate" {
            news.publicationDate = foundCharacters
        }
        
        if elementName == "item" {
            let tempNews = News(title: news.title,
                                publicationDate: news.publicationDate,
                                imageURL: news.imageURL,
                                newsURL: news.newsURL,
                                newsDescription: news.newsDescription)
            
            self.totalNews.append(tempNews);
        }
        
        self.foundCharacters = ""
    }
}
