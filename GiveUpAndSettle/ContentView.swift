//
//  ContentView.swift
//  GiveUpAndSettle
//
//  Created by Prashant C on 18/03/21.
//

import SwiftUI

struct User: Hashable, CustomStringConvertible {
    var id: Int
    
    let firstName: String
    let lastName: String
    let age: Int
    let mutualFriends: Int
    let imageName: String
    let occupation: String
    
    var description: String {
        return "\(firstName), id: \(id)"
    }
}

struct ContentView: View {
    
    @State var users: [User] = [
        User(id: 0, firstName: "White", lastName: "Face", age: 4, mutualFriends: 4, imageName: "Dog", occupation: "Gaurd Dog"),
        User(id: 1, firstName: "Maya", lastName: "", age: 1, mutualFriends: 2, imageName: "Cat2", occupation: "Unemployed"),
        User(id: 2, firstName: "Maitry", lastName: "", age: 3, mutualFriends: 1, imageName: "Cat1", occupation: "Explorer"),
        User(id: 3, firstName: "Raja", lastName: "", age: 6, mutualFriends: 4, imageName: "Cat", occupation: "House Cat"),
    ]
    
    private func getCardWidth(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        let offset: CGFloat = CGFloat(users.count - 1 - id) * 10
        return geometry.size.width - offset
    }
    
    private func getCardOffset(_ geometry: GeometryProxy, id: Int) -> CGFloat {
        return  CGFloat(users.count - 1 - id) * 10
    }
    
    private var maxID: Int {
        return self.users.map { $0.id }.max() ?? 0
    }
    
    var body: some View {
        // 1
        VStack {
            GeometryReader {geometry in
                
                
                ZStack {
                    ForEach(self.users, id: \.self) { user in
                        if (self.maxID - 2)...self.maxID ~= user.id {
                            CardView(user: user, onRemove: { removedUser in
                                // Remove that user from our array
                                self.users.removeAll { $0.id == removedUser.id }
                            }).animation(.spring())
                            .frame(width: self.getCardWidth(geometry, id: user.id))
                            .offset(x:0, y: self.getCardOffset(geometry, id: user.id))
                        }
                    }
                    
                }
            }
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
