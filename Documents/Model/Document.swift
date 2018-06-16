//
//  Document.swift
//  Documents
//
//  Created by Dominic Pilla on 6/13/18.
//  Copyright © 2018 Dominic Pilla. All rights reserved.
//

import Foundation

class Document {
    let title: String
    let size: Double
    let lastModified: Date
    let contents: String
    
    init(title: String, size: Double, lastModified: Date, contents: String) {
        self.title = title
        self.size = size
        self.lastModified = lastModified
        self.contents = contents
    }
}
