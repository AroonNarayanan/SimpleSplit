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
            Text("Add the items from your receipt!").padding()
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
                HStack {
                    HStack {
                        TextField("Item",text: $newItemName)
                        TextField("Price", text: $newItemPrice)
                            .keyboardType(.decimalPad)
                    }
                    Spacer().frame(width: 10)
                    Picker(selection: $newItemPersonIndex, label: Image(systemName: "person.crop.circle.badge.plus")) { ForEach( 0 ..< personList.count) {
                        Text(personList[$0].name)
                    }
                    }.pickerStyle(MenuPickerStyle())
                    Spacer().frame(width: 15)
                    Button("Add") {
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
            .padding()
            Divider()
            Subtotal(items: itemList)
                .padding()
            Spacer().frame(height: 10)
                .navigationTitle(Text("Step Two"))
                .toolbar {
                    if (itemList.count > 0) {
                        NavigationLink("Next", destination: ListSurcharges(personList: personList, itemList: itemList))
                    }
                }
        }
    }
}

struct ListItems_Previews: PreviewProvider {
    static var previews: some View {
        ListItems(personList: samplePersonList)
    }
}
