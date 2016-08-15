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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = localString("log_in")
    }
    @IBAction func chooseLanguage() {
        self.performSegueWithIdentifier("SelectLanguage", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

