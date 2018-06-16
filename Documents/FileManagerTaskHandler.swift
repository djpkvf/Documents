//
//  FileManagerTaskHandler.swift
//  Documents
//
//  Created by Dominic Pilla on 6/15/18.
//  Copyright © 2018 Dominic Pilla. All rights reserved.
//

import Foundation

func retrieveFiles() -> [Document] {
    
    var documents = [Document]()
    
    let fileManager = FileManager.default
    
    let directoryPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].path
    
    // Change the fileManager directory to the directory that holds all related files
    if !fileManager.changeCurrentDirectoryPath(directoryPaths) {
        print("Could not change directory")
    }
    
    do {
        // Iterate through all files created on here
        for fileName in try fileManager.contentsOfDirectory(atPath: ".") {
            guard let databuffer = fileManager.contents(atPath: fileName), let datastring = String(data: databuffer, encoding: .utf8) else {
                break
            }
            
            let attributes = try fileManager.attributesOfItem(atPath: fileName)
            
            documents.append(Document(title: fileName,
                                      size: attributes[FileAttributeKey.size] as! Double,
                                      lastModified: attributes[FileAttributeKey.modificationDate] as! Date,
                                      contents: datastring))
        }
    } catch {
        print(error.localizedDescription)
    }
    
    return documents
}

func removeFile(fileName: String) {
    let fileManager = FileManager.default
    
    let directoryPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    
    let dataFile = directoryPaths[0].appendingPathComponent(fileName).path
    do {
        try fileManager.removeItem(atPath: dataFile)
    } catch let error {
        print(error.localizedDescription)
    }
}
