//
//  DataModel.swift
//  IFC
//
//  Created by Marco Gnecchi on 15/05/2017.
//  Copyright © 2017 Marco Gnecchi. All rights reserved.
//

import Cocoa

class Menu: NSObject {
    let name: String
    var children = [MenuItem]()
    
    init(name: String) {
        self.name = name
    }
    
    
    class func menuList(_ filename: String) -> [Menu] {
        
        var menus = [Menu]()
        
        if let menuList = NSArray(contentsOfFile: filename) as? [NSDictionary] {
            for menuItems in menuList {
                let menu = Menu(name: menuItems.object(forKey: "name") as! String)
                let items = menuItems.object(forKey: "items") as! [NSDictionary]
                
                for dict in items {
                    let item = MenuItem(dictionary: dict)
                    menu.children.append(item)
                }
                menus.append(menu)
            }
        }
        
        return menus
    }
}


class MenuItem: NSObject {
    let name: String
    
    init(dictionary: NSDictionary) {
        self.name = dictionary.object(forKey: "name") as! String
    }
}
