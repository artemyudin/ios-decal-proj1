//
//  ViewController.swift
//  todoisty
//
//  Created by Artem Yudin on 9/28/15.
//  Copyright © 2015 Artem Yudin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    class TableEntry {
        var text: String
        var completed: Bool
        var dateCompleted: NSDate?
        var hourCompleted: Int?
        
        init(content: String) {
            text = content
            completed = false
        }
        
    }
    
    var entries = [TableEntry]()
    
    
    func addEntry(content: String) {
        entries.append(TableEntry(content: content))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.debug()
    }
    
    //Used to test implementation by populating the table beforehand (Currently disabled)
    func debug() {
        entries.append(TableEntry(content: "First"))
        entries.append(TableEntry(content: "Second"))
        entries.append(TableEntry(content: "Third"))
        entries[2].completed = true
        entries[2].dateCompleted = NSDate(timeIntervalSinceNow: -1*25*60*60)
        entries[2].hourCompleted = 2
        entries.append(TableEntry(content: "Fourth"))
        entries[3].completed = true
        entries[3].dateCompleted = NSDate(timeIntervalSinceNow: -1*25*60*60)
        entries[3].hourCompleted = 24

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath)
        if entries[indexPath.item].completed {
            cell.textLabel?.text = "DONE: " +  entries[indexPath.item].text.lowercaseString
        } else {
            cell.textLabel?.text = entries[indexPath.item].text
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case "progress"?:
            let nav = segue.destinationViewController as! ProgressViewController
            nav.count = countTasksCompleted()
        default:
            return
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        updateTable()
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            entries.removeAtIndex(indexPath.indexAtPosition(1))
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.indexAtPosition(1)
        //print("Touched at \(index)")
        entries[index].completed = !(entries[index].completed)
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Hour, .Minute], fromDate: date)
        entries[index].dateCompleted = date
        entries[index].hourCompleted = components.hour
        self.tableView.reloadData()
    }
    
    func countTasksCompleted() -> Int {
        updateTable()
        var count = 0
        for entry in entries {
            if entry.completed == true {
                count++
            }
        }
        return count
    }
    
    func updateTable() {
        for var index = entries.count - 1; index >= 0; index-- {
            let currentEntry = entries[index]
            if currentEntry.completed == true {
                let date = NSDate()
                let comparison = date.compare(currentEntry.dateCompleted!)
                if comparison == NSComparisonResult.OrderedDescending {
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Hour, .Minute], fromDate: date)
                    if currentEntry.hourCompleted < components.hour {
                        entries.removeAtIndex(index)
                    }
                }
            }
        }
    }


}

