//
//  ViewController.swift
//  ArchiveWebView
//
//  Created by sungyoungPark on 06/26/2024.
//  Copyright (c) 2024 sungyoungPark. All rights reserved.
//

import UIKit
import ArchiveWebView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let archiveWebView = ArchiveWebView()
        archiveWebView.loadRequest(webUrl: "https://m.naver.com/", saveName: "naver")
        
        self.view.addSubview(archiveWebView)
        
        archiveWebView.translatesAutoresizingMaskIntoConstraints = false
        
        archiveWebView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        archiveWebView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        archiveWebView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        archiveWebView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

