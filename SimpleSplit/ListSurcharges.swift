//
//  ListSurcharges.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/21/21.
//

import SwiftUI

struct ListSurcharges: View {
    var personList: [Person]
    var itemList: [Item]
    
    @State var surchargeList: [Surcharge] = []
    @State var newSurchargeType: SurchargeType = .tax
    @State var newSurchargeAmount: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Add tax, tip, or any other surcharges!")
            List() {
                ForEach(surchargeList, id: \.id) {surcharge in
                    HStack {
                        Text(surcharge.name.rawValue)
                        Spacer()
                        Price(amount: surcharge.amount)
                    }
                    .contextMenu {
                        Button(action: {
                            surchargeList.removeAll(where: {$0.id == surcharge.id})
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                }
                .onDelete(){ indexSet in
                    surchargeList.remove(atOffsets: indexSet)
                }
            }
            .listStyle(InsetGroupedListStyle())
            HStack {
                Image(systemName: "text.badge.plus").font(.title)
                Spacer().frame(width: 20)
                VStack(alignment: .leading){
                    HStack {
                        TextField("Amount", text: $newSurchargeAmount)
                            .keyboardType(.decimalPad)
                        Picker(newSurchargeType.rawValue, selection: $newSurchargeType) { ForEach(SurchargeType.allCases) { surchargeType in
                            Text(surchargeType.rawValue)
                        }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    Spacer().frame(height: 15)
                    Button("Add Surcharge") {
                        if (newSurchargeAmount != "") {
                            surchargeList.append(Surcharge(id: UUID(), name: newSurchargeType, amount: Float(newSurchargeAmount) ?? 0))
                            newSurchargeAmount = ""
                            newSurchargeType = .tax
                            hideKeyboard()
                        }
                    }
                }
            }.padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
            Divider()
            Spacer().frame(height: 20)
            Subtotal(items: itemList, isTitle: false)
            Total(items: itemList, surcharges: surchargeList)
            Spacer().frame(height: 20)
        }.padding()
        .navigationTitle(Text("Step Three"))
        .toolbar {
            NavigationLink("Done", destination: SinglePayerSummary(personList: computeSinglePayerTotals(personList: personList, itemList: itemList, surchargeList: surchargeList)))
        }
    }
}

struct ListSurcharges_Previews: PreviewProvider {
    static var previews: some View {
        ListSurcharges(personList: samplePersonList, itemList: sampleItemList)
    }
}
