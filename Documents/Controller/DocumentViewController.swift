//
//  DocumentViewController.swift
//  Documents
//
//  Created by Dominic Pilla on 6/14/18.
//  Copyright © 2018 Dominic Pilla. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    // Used for adding new document
    var documents: [Document] = []
    
    // Used for editing document
    var document: Document?
    
    var fileManager = FileManager.default
    var dataFile = ""

    @IBOutlet weak var documentTitle: UITextField!
    @IBOutlet weak var documentContents: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let document = document {
            documentTitle.text = document.title
            documentContents.text = document.contents
            
            self.title = document.title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        guard let documentTitle = documentTitle.text, let documentContents = documentContents.text, !documentTitle.isEmpty || !documentContents.isEmpty else {
            print("Document title or contents are empty")
            return
        }
        
        let directoryPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        dataFile = directoryPaths[0].appendingPathComponent(documentTitle).path
        
        fileManager.createFile(atPath: dataFile, contents: documentContents.data(using: .utf8), attributes: nil)
        
        do {
            let attributes = try fileManager.attributesOfItem(atPath: dataFile)
            
            let size = attributes[FileAttributeKey.size] as! Double
            let lastModified = attributes[FileAttributeKey.modificationDate] as! Date
            
            // Add document to documents list
            documents.append(Document(title: documentTitle, size: size, lastModified: lastModified, contents: documentContents))
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textFieldEdited(_ sender: Any) {
        self.title = documentTitle.text
    }
}
