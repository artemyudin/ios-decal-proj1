//
//  ProgressViewController.swift
//  todoisty
//
//  Created by Artem Yudin on 9/30/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    var entries = [String]()
    var count = 0
    
    @IBOutlet weak var countDisplay: UITextField!
    
    override func viewDidLoad() {
        countDisplay.text = String(self.count)
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        if let navigationController = self.navigationController {
            navigationController.popViewControllerAnimated(true)
        }
    }
    
}