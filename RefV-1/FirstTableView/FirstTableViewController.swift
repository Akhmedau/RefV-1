//
//  FirstTableViewController.swift
//  RefV-1
//
//  Created by АХМЕДОВ НИКОЛАЙ on 01/08/2023.
//  Copyright © 2023 Ahmedov Nikolay. All rights reserved.
//

import UIKit

class FirstTableViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
 
    
    
    var tableView : UITableView!
    var textField : UITextField!
    var tableViewData = ["Design", "OS by device", "OS by usage", "Hardware", "Swift", "Swift guides", "Guides", "Tools", "Xcode", "Apple docs", "App Store"]
    
    public let noteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapNote), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapNote() {
     let vc = AdviceViewController()
        self.present(vc, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.textField = UITextField(frame: CGRect(x:0, y:0, width:self.view.bounds.size.width, height:100))
        self.textField.backgroundColor = .white
        self.view.addSubview(self.textField)

        self.tableView = UITableView(frame: CGRect(x:0, y:100, width:self.view.bounds.size.width, height:self.view.bounds.size.height-100), style: .plain)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

     return tableViewData.count
 }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let myNewCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath) as UITableViewCell
    
    myNewCell.textLabel?.text = self.tableViewData[indexPath.row]

    
return myNewCell
    
    }
}
