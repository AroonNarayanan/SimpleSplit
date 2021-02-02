//
//  SinglePayerSummary.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/21/21.
//

import SwiftUI

struct SinglePayerSummary: View {
    @State var showTotalHelpModal = false
    
    var personList: [Person]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Here's what everyone owes:").padding()
            List() {
                ForEach(personList, id: \.id) {person in
                    HStack {
                        Text(person.name)
                        Spacer()
                        Price(for: person.amount)
                        if (hasVenmo(person)) {
                            venmoButton(person)
                        }
                    }
                }
            }.padding(0)
            .listStyle(InsetGroupedListStyle())
            HStack {
                Total(personList: personList)
                Spacer().frame(width:15)
                Button(action: {
                    showTotalHelpModal = true
                }) {
                    Image(systemName: "questionmark.circle")
                }
            }.padding()
            Spacer().frame(height: 10)
        }
        .navigationTitle(Text("All Done!"))
        .toolbar {
            Button(action: {
                let sharableString = sharableStringFromPersonList(personList: personList)
                let shareSheet = UIActivityViewController(activityItems: [sharableString], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(shareSheet, animated: true, completion: nil)
            }) {
                Image(systemName: "square.and.arrow.up")
            }
        }.alert(isPresented: $showTotalHelpModal, content: {
            Alert(title: Text("Understanding Your Total"), message: Text("When we split the total, we round each person's share to the nearest cent. The total you see on this page the sum of those shares."), dismissButton: .default(Text("Close")))
        })
    }
    
    func venmoButton(_ person: Person) -> some View {
        return HStack {
            Spacer().frame(width: 15)
            Button(action: {
                launchVenmo(person)
            }) {
                Image(systemName: "dollarsign.circle")
            }
        }
    }
}

struct SinglePayerSummary_Previews: PreviewProvider {
    static var previews: some View {
        SinglePayerSummary(personList: samplePersonList)
    }
}
