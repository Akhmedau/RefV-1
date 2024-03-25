//
//  ThirtViewController.swift
//  RefV-1
//
//  Created by АХМЕДОВ НИКОЛАЙ on 01/08/2023.
//  Copyright © 2023 Ahmedov Nikolay. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
        lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.text = "RefV-1"
        text.font = .systemFont(ofSize: 20)
        text.textColor = .black
        text.frame = CGRect(x: 10, y: 10, width: Int(view.frame.width), height: 150)
        text.numberOfLines = 0
        
        return text
    }()
        lazy var listLabel: UILabel = {
        let text = UILabel()
        text.text = "List of saves"
        text.font = .systemFont(ofSize: 15)
        text.textColor = .black
        text.frame = CGRect(x: 10, y: 40, width: Int(view.frame.width), height: 150)
        text.numberOfLines = 0
        
        return text
    }()
        lazy var text: UITextView = {
        let text = UITextView()
        text.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem"
        text.font = .systemFont(ofSize: 10)
        text.textColor = .black
        text.frame = CGRect(x: 10, y: 180, width: Int(view.frame.width - 50), height: 100)
        
        return text
    }()
    
        lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBgColor
        button.setTitleColor(.viewBgColor, for: .highlighted)
        button.layer.cornerRadius = 9
        button.setTitle("Next", for: .normal)
        button.frame = CGRect(x: (view.bounds.width - 200) / 2, y:view.bounds.height - 200, width: 200, height: 50)
        button.addTarget(self, action: #selector(didTapTwo), for: .touchUpInside)
        
        return button
    }()
    @objc func didTapTwo() {
     let vc = FirstTableViewController()
        self.present(vc, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(listLabel)
        view.addSubview(text)
        view.addSubview(nextButton)
        view.backgroundColor = .white
        }
    }

