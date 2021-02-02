//
//  SinglePayerSummary.swift
//  SimpleSplit
//
//  Created by Aroon Narayanan on 1/21/21.
//

import SwiftUI

struct SinglePayerSummary: View {
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
                    }
                }
            }.padding(0)
            .listStyle(InsetGroupedListStyle())
            Total(personList: personList).padding()
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
        }
    }
}

struct SinglePayerSummary_Previews: PreviewProvider {
    static var previews: some View {
        SinglePayerSummary(personList: samplePersonList)
    }
}
