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
    var amount: Float
}

struct Item {
    var id: UUID
    var name: String
    var price: Float
    var people: [Person]
}

enum SurchargeType: String, Equatable, CaseIterable, Identifiable {
    case tax = "Tax"
    case tip = "Tip"
    case deliveryfee = "Delivery Fee"
    case servicecharge = "Service Charge"
    case other = "Other"
    
    var id: SurchargeType {self}
}

struct Surcharge {
    var id: UUID
    var name: SurchargeType
    var amount: Float
}
