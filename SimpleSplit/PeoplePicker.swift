//
//  PeoplePicker.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/28/21.
//

import SwiftUI

struct PeoplePicker: View {
    @Binding var item: Item
    @Binding var didClickDone: Bool
    @Binding var showingPeoplePicker: Bool
    
    @State var personList: [Person]
    
    var body: some View {
        NavigationView {
        VStack(alignment: .leading) {
            Text("Select anyone you want to contribute to this item:")
            Spacer().frame(height: 10)
            Text(item.name).font(.title)
            Text(formatPrice(amount: item.price))
            Spacer().frame(height: 10)
            Button("Select All") {
                item.people.append(contentsOf: personList)
            }
            Spacer().frame(height: 15)
            VStack(alignment: .leading) {
                List () {
                    ForEach(personList, id: \.id) { person in
                        HStack {
                            getCheckImage(person: person)
                            Text(person.name)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            toggleSelection(person: person)
                        }
                    }
                }
            }
        }.padding()
        .toolbar {
            Button("Done") {
                didClickDone = true
                showingPeoplePicker = false
            }.disabled(item.people.count == 0)
        }
        .navigationTitle("Contributors")
        }
    }
    
    func getCheckImage(person: Person) -> some View {
        return item.people.contains(where: {$0.id == person.id}) ? Image(systemName: "checkmark.circle.fill").foregroundColor(.green) : Image(systemName: "checkmark.circle").foregroundColor(.blue)
    }
    
    func toggleSelection(person: Person) {
        if let personIndex = item.people.firstIndex(where: {$0.id == person.id}) {
            item.people.remove(at: personIndex)
        } else {
            item.people.append(person)
        }
    }
}

struct PeoplePicker_Previews: PreviewProvider {
    static var previews: some View {
        PeoplePicker(item: sampleItemOnePersonBinding, didClickDone: .constant(false), showingPeoplePicker: .constant(true), personList: samplePersonList)
    }
}
