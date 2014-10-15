//
//  ChecklistItem.swift
//  RobiList
//
//  Created by ROBERT YOUNAN on 08/10/14.
//  Copyright (c) 2014 Robert Younan. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
    // NSCodin protocol
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    override init() {
        super.init()
    }

}