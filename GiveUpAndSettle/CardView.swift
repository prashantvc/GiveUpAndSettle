//
//  CardView.swift
//  GiveUpAndSettle
//
//  Created by Prashant C on 18/03/21.
//

import SwiftUI

struct CardView: View {
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading)  {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                    .clipped()
                HStack{
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Maya, 1")
                            .font(.title)
                            .bold()
                        Text("Tabby")
                            .font(.subheadline)
                            .bold()
                        Text("13 Mutual Friends")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer() // Add a spacer to push our HStack to the left and the spacer fill the empty space
                    
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }.padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView().frame(height:400).padding()
    }
}
