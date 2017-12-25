//
//  Items.swift
//  Tewdew
//
//  Created by David Davidov on 12/23/17.
//  Copyright © 2017 David Davidov. All rights reserved.
//

import Foundation

class Items: Codable //it is now encodable, and Decodable (Must have standard data types
{
    var title : String = ""
    var done : Bool = false
}
