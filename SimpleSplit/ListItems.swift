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
    @State var newItem: Item = Item(id: UUID(), name: "", price: 0, people: [])
    
    @State var showPeoplePicker = false
    @State var didClickDone = false
    
    var body: some View {
        let canAddItem = newItem.name != "" && newItemPrice != ""
        
        let newItemPriceProxy = Binding<String>(
            get: { newItemPrice },
            set: {
                newItemPrice = $0
            }
        )
        
        VStack(alignment: .leading) {
            Text("Add the items from your receipt!").padding()
            List() {
                ForEach(itemList, id: \.id) {item in
                    ItemRow(item: item)
                        .contextMenu {
                            ForEach(item.people, id: \.id) {person in
                                Label(person.name, systemImage: "person.fill")
                            }
                            Divider()
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
                        TextField("Item",text: $newItem.name)
                        TextField("Price", text: newItemPriceProxy)
                            .keyboardType(.decimalPad)
                    }
                    Spacer().frame(width: 15)
                    Button("Add") {
                        if (canAddItem) {
                            newItem.price = Float(newItemPrice) ?? 0
                            hideKeyboard()
                            showPeoplePicker.toggle()
                        }
                    }.disabled(!canAddItem)
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
        }.sheet(isPresented: $showPeoplePicker, content: {
            PeoplePicker(item: $newItem, didClickDone: $didClickDone, showingPeoplePicker: $showPeoplePicker, personList: personList).onDisappear() {
                if (didClickDone) {
                    itemList.append(newItem)
                    newItemPrice = ""
                    newItem = Item(id: UUID(), name: "", price: 0, people: [])
                    didClickDone = false
                }
            }
        })
    }
}

struct ListItems_Previews: PreviewProvider {
    static var previews: some View {
        ListItems(personList: samplePersonList)
    }
}
