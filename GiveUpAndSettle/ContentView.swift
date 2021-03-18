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
        User(id: 0, firstName: "Cindy", lastName: "Jones", age: 23, mutualFriends: 4, imageName: "person.fill", occupation: "Coach"),
        User(id: 1, firstName: "Mark", lastName: "Bennett", age: 27, mutualFriends: 0, imageName: "person.circle.fill", occupation: "Insurance Agent"),
        User(id: 2, firstName: "Clayton", lastName: "Delaney", age: 20, mutualFriends: 1, imageName: "person.fill", occupation: "Food Scientist"),
        User(id: 3, firstName: "Brittni", lastName: "Watson", age: 19, mutualFriends: 4, imageName: "person.fill", occupation: "Historian"),
        User(id: 4, firstName: "Archie", lastName: "Prater", age: 22, mutualFriends:18, imageName: "person.fill", occupation: "Substance Abuse Counselor"),
        User(id: 5, firstName: "James", lastName: "Braun", age: 24, mutualFriends: 3, imageName: "person.fill", occupation: "Marketing Manager"),
        User(id: 6, firstName: "Danny", lastName: "Savage", age: 25, mutualFriends: 16, imageName: "person.fill", occupation: "Dentist"),
        User(id: 7, firstName: "Chi", lastName: "Pollack", age: 29, mutualFriends: 9, imageName: "person.fill", occupation: "Recreational Therapist"),
        User(id: 8, firstName: "Josue", lastName: "Strange", age: 23, mutualFriends: 5, imageName: "person.fill", occupation: "HR Specialist"),
        User(id: 9, firstName: "Debra", lastName: "Weber", age: 28, mutualFriends: 13, imageName: "person.fill", occupation: "Judge")
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
