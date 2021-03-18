//
//  CardView.swift
//  GiveUpAndSettle
//
//  Created by Prashant C on 18/03/21.
//

import SwiftUI

struct CardView: View {
    @State var translation: CGSize = .zero
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.75) // 3
                    .clipped()
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Debra Weber, 28")
                            .font(.title)
                            .foregroundColor(.primary)
                        Text("Judge")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Text("Last seen today")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer() // Add a spacer to push our HStack to the left and the spacer fill the empty space
                    
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                }.padding(.horizontal)
            }
            // Add padding, corner radius and shadow with blur radius
            .padding(.bottom)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)
            .animation(.interactiveSpring())
            .offset(x: self.translation.width, y: 0)
            .rotationEffect(.degrees(Double(self.translation.width / geometry.size.width) * 25), anchor: .bottom)
            .gesture(
                DragGesture()
                    .onChanged{ value in
                        self.translation = value.translation
                    }.onEnded{ value in
                        self.translation = .zero
                    }
            )
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView().frame(height:400).padding()
    }
}
