//
//  Category.swift
//  Tewdew
//
//  Created by David Davidov on 12/28/17.
//  Copyright © 2017 David Davidov. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object{
    @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    let items = List<Items>()
}
