//
//  ViewController.swift
//  kugimSQLiteProject
//
//  Created by ST13 on 26.10.2017.
//  Copyright © 2017 Kugim. All rights reserved.
//

import UIKit
import SQLite


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Step 1
    var database: Connection!
    
    // Step 3
    let contactTable = Table("contacts")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let email = Expression<String>("email")
    
    
    // Step 4
    func createTable() {
        let createTable = self.contactTable.create {
            (table) in
            table.column(self.id, primaryKey: true)
            table.column(name)
            table.column(email)
        }
        
        do {
            try self.database.run(createTable)
            print("Contact Table Created")
        } catch {
            print(error)
        }
        
    }
    
    var contactListArray = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellItem = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cellItem.textLabel!.text = contactListArray[indexPath.row]
        return cellItem
    }
    
    @IBOutlet weak var nameFieldOutlet: UITextField!
    @IBOutlet weak var emailFieldOutlet: UITextField!
    @IBOutlet weak var contactTableOutlet: UITableView!
    
    @IBAction func insertButtonAction(_ sender: UIButton) {
        let nameField = nameFieldOutlet.text
        let emailField = emailFieldOutlet.text
        
        let insertContact = self.contactTable.insert(
            name <- nameField!,
            email <- emailField!
        )
        
        do {
            try self.database.run(insertContact)
        } catch {
            print(error)
        }
        
        print("Insert Islemi Yapildi")
    }
    
    @IBAction func updateButtonAction(_ sender: UIButton) {
        print("Update Islemi Yapildi")
    }
    
    
    @IBAction func deleteActionButton(_ sender: UIButton) {
        print("Delete Islemi Yapildi")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Step 2 -> Create DB
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("contact").appendingPathExtension("sqlite3")
            let db = try Connection(fileUrl.path)
            self.database = db
        } catch {
            print(error)
        }
        
        // Step 5 -> Create Table
        createTable()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

