//
//  SmallViews.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/21/21.
//

import Foundation
import SwiftUI

func Subtotal(items: [Item], isTitle: Bool = true) -> some View {
    let font: Font = isTitle ? .title : .body
    return Text(String(format: "Subtotal: $%.02f",
                       computeTotal(itemList: items))).font(font)
}

func Total(items: [Item], surcharges: [Surcharge]) -> some View {
    return Text(String(format: "Total: $%.02f",
                       computeTotal(itemList: items) + computeTotal(surcharges: surcharges))).font(.title)
}

func Total(personList: [Person]) -> some View {
    return Text(String(format: "Total: $%.02f",
                       computeTotal(personList: personList))).font(.title)
}

func Price(amount: Float) -> some View {
    return Text(String(format: "$%.02f", amount))
}
