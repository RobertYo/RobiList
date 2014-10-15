//
//  ViewController.swift
//  RobiList
//
//  Created by ROBERT YOUNAN on 07/10/14.
//  Copyright (c) 2014 Robert Younan. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    //var items: [ChecklistItem]
    var checklist: Checklist!
    
    
//    required init (coder aDecoder: NSCoder) {
//        items = [ChecklistItem]()
//        
//        super.init(coder: aDecoder)
//        loadChecklistItems()
//        
//        println("Documents folder is \(documentsDirectory())")
//        println("Data file path is \(dataFilePath())")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = 44
        title = checklist.name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as UITableViewCell
        
        let item = checklist.items[indexPath.row]
        
        configureCheckmarkForCell(cell, withChecklistItem: item)
        configureTextForCell(cell, withChecklistItem: item)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmarkForCell(cell, withChecklistItem: item)
            
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 1
        checklist.items.removeAtIndex(indexPath.row)
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        //saveCheclistItem()
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as UILabel
        
        if item.checked {
            label.text = "✔️"
        } else {
            label.text = ""
        }
        label.textColor = view.tintColor
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as UILabel
        label.text = item.text
    }
    
    // Delegate
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        
        let newRowIndex = checklist.items.count
        
        checklist.items.append(item)
        
        let indexPath = NSIndexPath(forItem: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
        //saveCheclistItem()
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem) {
        if let index = find(checklist.items, item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withChecklistItem: item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        //saveCheclistItem()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // 1
        if segue.identifier == "AddItem" {
            //2
            let navigationController = segue.destinationViewController as UINavigationController
            //3
            let controller = navigationController.topViewController as ItemDetailViewController
            // 4
            controller.delegate = self
            
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
        
    }
    
    // Documents directory
//    func documentsDirectory() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
//        return paths[0]
//        
//    }
//    
//    func dataFilePath() -> String {
//        return documentsDirectory().stringByAppendingPathComponent("RobiList.plist")
//    }
    
    // Save 
//    func saveCheclistItem() {
//        
//    let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
//        archiver.encodeObject(items, forKey: "ChecklistItems")
//        archiver.finishEncoding()
//        data.writeToFile(dataFilePath(), atomically: true)
//    }
//    
//    func loadChecklistItems() {
//        // 1
//        let path = dataFilePath()
//        // 2
//        if NSFileManager.defaultManager().fileExistsAtPath(path) {
//            // 3
//            let data = NSData(contentsOfFile: path)
//            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
//            items = unarchiver.decodeObjectForKey("ChecklistItems") as [ChecklistItem]
//            unarchiver.finishDecoding()
//        }
//    }
    
    
    
    
    
}

