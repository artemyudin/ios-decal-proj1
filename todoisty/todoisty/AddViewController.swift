//
//  ProgressViewController.swift
//  todoisty
//
//  Created by Artem Yudin on 9/30/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet weak var newTask: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        if let content = newTask.text {
            if let navigationController = self.navigationController
            {
                let nav = navigationController.viewControllers[navigationController.viewControllers.count-2] as! TableViewController
                nav.addEntry(content)
                navigationController.popViewControllerAnimated(true)
            }
        }
    }
    
}