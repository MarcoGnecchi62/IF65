//
//  ViewController.swift
//  IFC
//
//  Created by Marco Gnecchi on 15/05/2017.
//  Copyright © 2017 Marco Gnecchi. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var menus = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filePath = Bundle.main.path(forResource: "Menus", ofType: "plist") {
            menus = Menu.menuList(filePath)
            print(menus)
        }
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

extension ViewController: NSOutlineViewDataSource {
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let menu = item as? Menu {
            return menu.children.count
        }
        
        return menus.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let menu = item as? Menu {
            return menu.children[index]
        }
        
        return menus[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let menu = item as? Menu {
            return menu.children.count > 0
        }
        
        return false
    }
    
}

extension ViewController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        
        var view: NSTableCellView?
        
        if let menu = item as? Menu {
            view = outlineView.make(withIdentifier: "idLivello1", owner: self) as? NSTableCellView
            if let textField = view?.textField {
                textField.stringValue = menu.name
                textField.sizeToFit()
            }
        } else if let menuItem = item as? MenuItem {
            if tableColumn?.identifier == "livello1" {
                view = outlineView.make(withIdentifier: "idLivello1", owner: self) as? NSTableCellView
                if let textField = view?.textField {
                    textField.stringValue = menuItem.name
                    textField.sizeToFit()
                }
            }
        }
        
        return view
    }
    
}
