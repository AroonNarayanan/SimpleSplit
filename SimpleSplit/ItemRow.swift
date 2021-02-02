//
//  ItemRow.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/21/21.
//

import SwiftUI

struct ItemRow: View {
    var item: Item
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                item.people.count > 1 ? Text("\(item.people.count) people")
                    .font(.caption) : Text(item.people[0].name)
                    .font(.caption)
            }
            Spacer()
            Price(for: item.price)
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(item: sampleItemOnePerson)
        ItemRow(item: sampleItemManyPeople)
    }
}
