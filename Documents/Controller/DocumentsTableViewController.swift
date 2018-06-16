//
//  DocumentsTableViewController.swift
//  Documents
//
//  Created by Dominic Pilla on 6/13/18.
//  Copyright © 2018 Dominic Pilla. All rights reserved.
//

import UIKit

class DocumentsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dateFormatter = DateFormatter()
    var displayDateFormatter = DateFormatter()
    
    var documents = [Document]()
    
    @IBOutlet weak var documentsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        displayDateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm:ss a"
        
        documentsTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        documents.removeAll()
        
        documents = retrieveFiles()
        
        documentsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentsCell", for: indexPath)
        
        if let cell = cell as? DocumentTableViewCell {
            cell.title.text = documents[indexPath.row].title
            cell.size.text = String(format: "Size: %0.02f", documents[indexPath.row].size)
            cell.lastModified.text = "Modified: \(displayDateFormatter.string(from: documents[indexPath.row].lastModified))"
        }
        
        return cell
    }
    
    // For deleting rows
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Deleting rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            removeFile(fileName: documents[indexPath.row].title)
            documents.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createNewDocument" {
            if let destinationViewController = segue.destination as? DocumentViewController {
                destinationViewController.documents = documents
            }
        } else if segue.identifier == "viewDocument" {
            if let destinationViewController = segue.destination as? DocumentViewController, let indexPath = documentsTableView.indexPathForSelectedRow {
                destinationViewController.document = documents[indexPath.row]
            }
        }
    }

}
