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
    let surchargesPerPerson = computeTotal(surchargeList) / Float(personList.count)
    for index in personList.indices {
        personList[index].amount += surchargesPerPerson
    }
    return personList
}

func computeSinglePayerTotalsProportional(personList: [Person], itemList: [Item], surchargeList: [Surcharge]) -> [Person] {
    var personList = personList
    itemList.forEach { item in
        let itemAmountPerPerson = item.price / Float(item.people.count)
        item.people.forEach { person in
            let personIndex = personList.firstIndex(where: {$0.id == person.id})!
            personList[personIndex].amount += itemAmountPerPerson
        }
    }
    let surchargeTotal = computeTotal(surchargeList)
    let subtotal = computeTotal(itemList)
    for index in personList.indices {
        personList[index].amount += (personList[index].amount / subtotal) * surchargeTotal
    }
    return personList
}

func computeTotal(_ itemList: [Item]) -> Float {
    var total: Float = 0
    itemList.forEach {
        total += $0.price
    }
    return total
}

func computeTotal(_ personList: [Person]) -> Float {
    var total: Float = 0
    personList.forEach {
        total += $0.amount
    }
    return total
}

func computeTotal(_ surcharges: [Surcharge]) -> Float {
    var total: Float = 0
    surcharges.forEach {
        total += $0.amount
    }
    return total
}

func sharableStringFromPersonList(personList: [Person]) -> String {
    var sharableString = "Here's what everybody owes:\n"
    personList.forEach { person in
        sharableString.append("\(person.name): \(person.amount.priceString)\n")
    }
    return sharableString
}

func isValidCurrencyString(currencyString: String) -> Bool {
    let subStrings = currencyString.split(separator: ".")
    let numericPredicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]*$")
    
    switch subStrings.count {
    case 0:
        return true
    case 1:
        return numericPredicate.evaluate(with: subStrings[0])
    case 2:
        return numericPredicate.evaluate(with: subStrings[0]) && numericPredicate.evaluate(with: subStrings[1])
    default:
        return false
    }
}

extension Float {
    var currencyRound: Float {return (self * 100).rounded() / 100}
    var priceString: String {return String(format: "$%.02f", self.currencyRound)}
    var priceStringSansSign: String {return String(format: "%.02f", self.currencyRound)}
}
