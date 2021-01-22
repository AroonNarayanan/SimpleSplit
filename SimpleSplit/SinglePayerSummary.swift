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
            Text("Here's what everyone owes:")
            List() {
                ForEach(personList, id: \.id) {person in
                    HStack {
                        Text(person.name)
                        Spacer()
                        Price(amount: person.amount)
                    }
                }
            }.padding(0)
            Total(personList: personList)
        }
        .padding()
        .navigationTitle(Text("All Done!"))
    }
}

struct SinglePayerSummary_Previews: PreviewProvider {
    static var previews: some View {
        SinglePayerSummary(personList: samplePersonList)
    }
}
