//
//  ContentView.swift
//  GiveUpAndSettle
//
//  Created by Prashant C on 18/03/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // 1
        VStack {
            DateView()
        }.padding()
    }
}

struct DateView: View {
    var body: some View{
        VStack() {
            HStack{
                VStack(alignment: .leading) {
                    Text("Friday, 10th January")
                        .font(.title)
                        .bold()
                    Text("Today")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }.padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
