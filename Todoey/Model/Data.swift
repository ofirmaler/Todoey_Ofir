//
//  Data.swift
//  Todoey
//
//  Created by SL on 21/12/2017.
//  Copyright © 2017 Ofir Maler. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    
    @objc dynamic var name : String =  ""
    @objc dynamic  var age : Int = 0
    
}
