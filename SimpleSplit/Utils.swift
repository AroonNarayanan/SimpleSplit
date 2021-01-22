//
//  Utils.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/21/21.
//

import Foundation
import SwiftUI

func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

func computeSinglePayerTotals(personList: [Person], itemList: [Item], surchargeList: [Surcharge]) -> [Person] {
    var personList = personList
    itemList.forEach { item in
        let itemAmountPerPerson = item.price / Float(item.people.count)
        item.people.forEach { person in
            let personIndex = personList.firstIndex(where: {$0.id == person.id})!
            personList[personIndex].amount += itemAmountPerPerson
        }
    }
    let surchargesPerPerson = computeTotal(surcharges: surchargeList) / Float(personList.count)
    for index in personList.indices {
        personList[index].amount += surchargesPerPerson
    }
    return personList
}

func computeTotal(itemList: [Item]) -> Float {
    var total: Float = 0
    itemList.forEach {
        total += $0.price
    }
    return total
}

func computeTotal(personList: [Person]) -> Float {
    var total: Float = 0
    personList.forEach {
        total += $0.amount
    }
    return total
}

func computeTotal(surcharges: [Surcharge]) -> Float {
    var total: Float = 0
    surcharges.forEach {
        total += $0.amount
    }
    return total
}
