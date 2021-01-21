//
//  ListItems.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/21/21.
//

import SwiftUI

struct ListItems: View {
    @State var personList: [Person]
    @State var itemList: [Item] = []
    
    @State var newItemName = ""
    @State var newItemPrice = ""
    @State var newItemPersonIndex = -1
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Add the items from your receipt!")
                List() {
                    ForEach(itemList, id: \.id) {item in
                    HStack {
                        Text(String(item.price))
                        Spacer()
                        Text(item.name)
                        Spacer()
                        Text(item.people[0].name)
                    }
                    }
                    .onDelete(){ indexSet in
                        itemList.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(PlainListStyle())
                Text(String(format: "Subtotal: $%.02f", computeTotal())).font(.title)
                Spacer().frame(height: 30)
                HStack {
                    TextField("Item",text: $newItemName)
                    TextField("Price", text: $newItemPrice)
                }
                Spacer().frame(height: 20)
                Picker(newItemPersonIndex > -1 ? personList[newItemPersonIndex].name : "Choose Person", selection: $newItemPersonIndex) { ForEach( 0 ..< personList.count) {
                    Text(personList[$0].name)
                }
                }.pickerStyle(MenuPickerStyle())
                Spacer().frame(height: 20)
                Button("Add Item") {
                    if (newItemName != "" && newItemPrice != "" && newItemPersonIndex > -1) {
                        itemList.append(Item(id: UUID(), name: newItemName, price: Float(newItemPrice) ?? 0, people: [personList[newItemPersonIndex]]))
                    newItemName = ""
                        newItemPrice = ""
                        newItemPersonIndex = -1
                    }
                    }
                }
            .navigationTitle(Text("Step Two"))
            .toolbar() {
                Button("Next") {
                    
                }
            }
            .padding()
    }
    
    func getPersonFromUUID(uuid: UUID?) -> Person? {
        if (uuid == nil) {
            return nil
        }
        return personList.first(where: {$0.id == uuid})
    }
    
    func getNameFromUUID(uuid: UUID?) -> String? {
        if (uuid == nil) {
            return nil
        }
        let person = getPersonFromUUID(uuid: uuid)
        return person?.name
    }
    
    func computeTotal() -> Float {
        var total: Float = 0
        itemList.forEach {
            total += $0.price
        }
        return total
    }
}

struct ListItems_Previews: PreviewProvider {
    static var previews: some View {
        ListItems(personList: samplePersonList)
    }
}
