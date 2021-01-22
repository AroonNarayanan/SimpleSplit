//
//  ContentView.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/20/21.
//

import SwiftUI

struct ListPeople: View {
    @State var personList: [Person] = []
    @State var newPersonName = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Add everyone at your table!")
                List() {
                    ForEach(personList, id: \.id) {person in
                        Text(person.name)
                            .contextMenu {
                                Button(action: {
                                    personList.removeAll(where: {$0.id == person.id})
                                }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                }
                            }
                    }
                    .onDelete(){ indexSet in
                        personList.remove(atOffsets: indexSet)
                    }
                }.padding(0)
                .listStyle(PlainListStyle())
                TextField("Name",text: $newPersonName)
                    .textContentType(.name)
                Spacer().frame(height: 15)
                Button("Add Person") {
                    if (newPersonName != "") {
                        personList.append(Person(id: UUID(), name: newPersonName, amount: 0))
                        newPersonName = ""
                    }
                }
            }
            .navigationTitle(Text("Step One"))
            .toolbar() {
                if (personList.count > 0) {
                    NavigationLink("Next", destination: ListItems(personList: personList))
                }
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListPeople()
    }
}
