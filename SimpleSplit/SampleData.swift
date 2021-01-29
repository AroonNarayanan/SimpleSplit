//
//  SampleData.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/21/21.
//

import Foundation
import SwiftUI

var samplePersonList = [Person(id: UUID(), name: "Aroon Narayanan", amount: 0), Person(id: UUID(), name: "Vijay Narayanan", amount: 0)]

var sampleItemOnePerson = Item(id: UUID(), name: "Raspberry Pi", price: 9.99, people: [samplePersonList[0]])

var sampleItemOnePersonBinding: Binding<Item> = .constant(sampleItemOnePerson)

var sampleItemManyPeople = Item(id: UUID(), name: "Raspberry Pi", price: 9.99, people: samplePersonList)

var sampleItemList = [sampleItemOnePerson]
