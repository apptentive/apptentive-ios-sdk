//
//  ViewController.swift
//  ApptentiveUITestsApp
//
//  Created by Apptentive on 3/3/20.
//  Copyright © 2020 Frank Schmitt. All rights reserved.
//

import UIKit
import Apptentive


struct TestRow {
    var label: String
    var action: ()->()
}

class ViewController: UITableViewController {
    private var rows = [TestRow]()
    
    init() {
        super.init(style: .plain)
        
        self.rows = [
            TestRow(label: "Present Love Dialog with Configuration", action: self.presentLoveDialogWithConfiguration),
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = self.rows[indexPath.row].label
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.rows[indexPath.row].action()
    }
}

extension ViewController {
    
    fileprivate func presentLoveDialogWithConfiguration() {
        
        let apptentive = Apptentive()
        let configuration = LoveDialogConfiguration(affirmativeText: "Yup", negativeText: "")
        apptentive.presentLoveDialog(from: self, with: configuration)
    }
}