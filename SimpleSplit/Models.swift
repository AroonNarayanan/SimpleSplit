//
//  Models.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/20/21.
//

import Foundation

struct Person {
    var id: UUID
    var name: String
}

struct Item {
    var id: UUID
    var name: String
    var price: Float
    var people: [Person]
}
