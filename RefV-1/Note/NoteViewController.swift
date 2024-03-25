//
//  NoteViewController.swift
//  RefV-1
//
//  Created by АХМЕДОВ НИКОЛАЙ on 15/09/2023.
//  Copyright © 2023 Ahmedov Nikolay. All rights reserved.
//

import Foundation

protocol NoteViewProtocol: AnyObject {
    func showError(title:String, message:String)
    func showLoading()
    func hideLoading()
    func reloadRow(at index: Int)
    func reloadData()
    func didInsertRow(at index: Int)
    func didDeleteRow(at index: Int)
}
class NoteViewController: FirstTableViewController {
    
}
