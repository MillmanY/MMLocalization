//
//  ViewController.swift
//  MMLocalization
//
//  Created by Millman on 08/15/2016.
//  Copyright (c) 2016 Millman. All rights reserved.
//

import UIKit
import MMLocalization
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue,
                                                  .font: UIFont.systemFont(ofSize: 17)]

        self.title = "log_in".localize(arg: "123")
        
        // Arguement demo
        let a = "arg_demo".localize(arg: "10",2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    @IBAction func chooseLanguage() {
        self.performSegue(withIdentifier: "SelectLanguage", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
