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
                    ItemRow(item: item)
                        .contextMenu {
                            Button(action: {
                                itemList.removeAll(where: {$0.id == item.id})
                            }) {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                        }
                }
                .onDelete(){ indexSet in
                    itemList.remove(atOffsets: indexSet)
                }
            }
            .listStyle(InsetGroupedListStyle())
            HStack {
                Image(systemName: "text.badge.plus").font(.title)
                Spacer().frame(width: 20)
                VStack(alignment: .leading) {
                    HStack {
                        TextField("Item",text: $newItemName)
                        TextField("Price", text: $newItemPrice)
                            .keyboardType(.decimalPad)
                    }
                    Spacer().frame(height: 15)
                    Picker(newItemPersonIndex > -1 ? personList[newItemPersonIndex].name : "Choose Person", selection: $newItemPersonIndex) { ForEach( 0 ..< personList.count) {
                        Text(personList[$0].name)
                    }
                    }.pickerStyle(MenuPickerStyle())
                    Spacer().frame(height: 15)
                    Button("Add Item") {
                        if (newItemName != "" && newItemPrice != "" && newItemPersonIndex > -1) {
                            itemList.append(Item(id: UUID(), name: newItemName, price: Float(newItemPrice) ?? 0, people: [personList[newItemPersonIndex]]))
                            newItemName = ""
                            newItemPrice = ""
                            newItemPersonIndex = -1
                            hideKeyboard()
                        }
                    }
                }
            }
            .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
            Divider()
            Subtotal(items: itemList)
                .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                .navigationTitle(Text("Step Two"))
                .toolbar {
                    if (itemList.count > 0) {
                        NavigationLink("Next", destination: ListSurcharges(personList: personList, itemList: itemList))
                    }
                }
        }
        .padding()
    }
}

struct ListItems_Previews: PreviewProvider {
    static var previews: some View {
        ListItems(personList: samplePersonList)
    }
}
