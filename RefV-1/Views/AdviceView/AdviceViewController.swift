//
//  SecondViewController.swift
//  RefV-1
//
//  Created by АХМЕДОВ НИКОЛАЙ on 07/07/2023.
//  Copyright © 2023 Ahmedov Nikolay. All rights reserved.
//

import UIKit

class AdviceViewController: UIViewController {
    
    let model = Advice()
    
    lazy var titleLabel: UILabel = {
        let text = UILabel()
        text.text = "Good Advice"
        text.font = .systemFont(ofSize: 20)
        text.textColor = .fontColor
        text.frame = CGRect(x: 0, y: 60, width: Int(view.frame.width), height: 150)
        text.textAlignment = .center
        text.numberOfLines = 0
        
        return text
    }()
    lazy var adviceLabel: UILabel = {
       let text = UILabel()
        text.text = model.getRandomAdvice()
        text.font = .systemFont(ofSize: 15)
        text.textColor = .viewBgColor
        text.frame = CGRect(x: 0, y: 0, width: 350, height: 250)
        text.center = view.center
        text.textAlignment = .justified
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 0
        
        return text
    }()
    lazy var adviceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBgColor
        button.setTitleColor(.viewBgColor, for: .highlighted)
        button.layer.cornerRadius = 9
        button.setTitle("Show me", for: .normal)
        button.frame = CGRect(x: (view.bounds.width - 200) / 2, y:view.bounds.height - 200, width: 200, height: 50)
        button.addTarget(self, action: #selector(pushAdviceButton), for: .touchUpInside)
        
        return button
    }()
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .buttonBgColor
        button.layer.cornerRadius = 9
        button.setTitle("Open", for: .normal)
        button.frame = CGRect(x: (view.bounds.width - 200) / 2, y:view.bounds.height - 145, width: 200, height: 50)
        button.addTarget(self, action: #selector(didTapOpen), for: .touchUpInside)
        return button
    }()
    @objc func didTapOpen() {
     let vc = EntryViewController()
        self.present(vc, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
        setupViews()
    }
    @objc func pushAdviceButton() {
        adviceLabel.text = model.getRandomAdvice()
    }
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(adviceLabel)
        view.addSubview(adviceButton)
        view.addSubview(addButton)
    }
}

extension UIColor {
    static var fontColor: UIColor {
        return UIColor(red: 0.803, green: 0.803, blue: 0.803, alpha: 1.0)
    }
    static var viewBgColor: UIColor {
        return UIColor(red: 0.803, green: 0.209, blue: 0.209, alpha: 1.0)
    }
    static var buttonBgColor: UIColor {
        return UIColor(red: 0.408, green: 0.661, blue: 0.336, alpha: 1.0)
    }
}
