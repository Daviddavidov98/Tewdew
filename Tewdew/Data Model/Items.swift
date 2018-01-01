//
//  Item.swift
//  Tewdew
//
//  Created by David Davidov on 12/28/17.
//  Copyright © 2017 David Davidov. All rights reserved.
//

import Foundation
import RealmSwift

class Items: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
