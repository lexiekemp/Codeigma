//
//  ChecklistViewController.swift
//  Codeigma
//
//  Created by Lexie Kemp on 10/5/18.
//  Copyright © 2018 Lexie Kemp. All rights reserved.
//

import UIKit
import CoreData

class ChecklistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var checkListTableView: UITableView!
    @IBOutlet weak var callNumberButton: UIButton!
    
    var bill: Bill!
    var codes = [Code]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        checkListTableView.delegate = self
        checkListTableView.dataSource = self
        callNumberButton.layer.cornerRadius = callNumberButton.frame.height/2
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked(_:)))
        if self.navigationController == nil {
            print("nil")
        }
        callNumberButton.addTarget(self, action: #selector(doneClicked(_:)), for: .touchUpInside)
        self.navigationController?.navigationItem.rightBarButtonItem = doneButton
        // Do any additional setup after loading the view.
    }
    
    @objc func doneClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToDashboard", sender: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTable()
    }
    func updateTable() {
        if let newCodes = bill.codes?.allObjects as? [Code] {
            self.codes = newCodes
            self.checkListTableView.reloadData()
        }
    }
    
    // MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "codeCell", for: indexPath) as! CodeTableViewCell
        cell.selectionStyle = .none;
        let code = codes[indexPath.row]
        cell.inflate(code: code)

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
