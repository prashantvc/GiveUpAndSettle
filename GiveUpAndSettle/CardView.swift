//
//  CardView.swift
//  GiveUpAndSettle
//
//  Created by Prashant C on 18/03/21.
//

import SwiftUI

struct CardView: View {
    @State var translation: CGSize = .zero
    @State private var swipeStatus: LikeDislike = .none
    
    private var user: User
    private var onRemove: (_ user: User) -> Void
    
    private var thresholdPercentage: CGFloat = 0.25
    
    init (user: User, onRemove: @escaping (_ user: User) -> Void){
        self.user = user
        self.onRemove = onRemove
    }
    
    private func getGesturePercentage(_ geometry: GeometryProxy, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / geometry.size.width
    }
    
    private enum LikeDislike: Int {
        case like, dislike, none
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack(alignment: self.swipeStatus == .like ? .topLeading : .topTrailing) {
                    Image(systemName: self.user.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75) // 3
                        .clipped()
                    
                    if self.swipeStatus == .like {
                        Text("😻 LIKE").font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .cornerRadius(10)
                            .foregroundColor(Color.green)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 4.0)
                            ).padding(45)
                            .rotationEffect(Angle.degrees(-45))
                    }else if self.swipeStatus == .dislike {
                        Text("😿 NO").font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(Color.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 4.0)
                            ).padding(.top, 45)
                            .rotationEffect(Angle.degrees(45))
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(self.user.firstName) \(self.user.lastName), \(self.user.age)")
                            .font(.title)
                            .foregroundColor(.primary)
                        Text("\(self.user.occupation)")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                        Text("\(self.user.mutualFriends) Mutual Friends")
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
                        
                        if (self.getGesturePercentage(geometry, from: value)) >= self.thresholdPercentage {
                            self.swipeStatus = .like
                        } else if self.getGesturePercentage(geometry, from: value) <= -self.thresholdPercentage {
                            self.swipeStatus = .dislike
                        } else {
                            self.swipeStatus = .none
                        }
                        
                    }.onEnded{ value in
                        if abs(self.getGesturePercentage(geometry, from: value)) > self.thresholdPercentage {
                            self.onRemove(self.user)
                        } else {
                            self.translation = .zero
                        }
                    }
            )
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(user: User(id: 1, firstName: "Mark", lastName: "Bennett", age: 27, mutualFriends: 0, imageName: "person.circle.fill", occupation: "Insurance Agent"),
                 onRemove: { _ in
                    // do nothing
                 }).frame(height:400).padding()
    }
}
