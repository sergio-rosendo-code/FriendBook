//
//  ProfilePage.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/11/26.
//

import SwiftData
import SwiftUI

struct ProfilePage: View {
    let userId: UUID
    @Query private var users: [User]
    private var user: User? { users.first }
    @Environment(NavigationManager.self) private var navigationManager
    
    var body: some View {
        if let user {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("Work:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Label(user.company, systemImage: "briefcase")
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Contact Info:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Button(user.email, systemImage: "envelope"){
                            UIPasteboard.general.string = user.email
                            // TODO: Needs visual cue that value was copied to clipboard
                        }
                        
                        Button(user.addressFormatted, systemImage: "mail") {
                            UIPasteboard.general.string = user.address
                            // TODO: Needs visual cue that value was copied to clipboard
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("About:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(user.about)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Friends:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        LazyVGrid(
                            columns: [GridItem(.flexible()), GridItem(.flexible())],
                            alignment: .leading,
                            spacing: 8
                        ) {
                            ForEach(user.friends.prefix(4)) { friend in
                                Button {
                                    navigationManager.push(route: .profilePage(userId: friend.id))
                                } label: {
                                    Label(friend.name, systemImage: "person.fill")
                                }
                            }
                        }
                    }
                    
                    if (user.friends.count > 4) {
                        HStack {
                            Spacer()
                            Button("show more"){
                                navigationManager.push(route: .friendsPage(userId: self.user!.id, userName: self.user!.name))
                            }
                            .underline()
                        }
                    }
                }
                .navigationTitle("\(user.name)")
                .navigationBarTitleDisplayMode(.inline)
                .padding()
            }
            .scrollBounceBehavior(.basedOnSize)
        } else {
            ContentUnavailableView("User profile not available.", systemImage: "person.slash")
        }
    }
    
    init(userId: UUID) {
        self.userId = userId
        
        let predicate = #Predicate<User> { user in
            user.id == userId
        }
        
        _users = Query(filter: predicate)
    }
}

#Preview {
    let container = try! ModelContainer(
        for: User.self, Friend.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let context = container.mainContext
    context.insertAll(DummyData.users)
    try? context.save()

    return NavigationStack {
        if let first = DummyData.users.first {
            ProfilePage(userId: first.id)
        } else {
            ContentUnavailableView("Failed to load dummy users for preview.", systemImage: "person.slash")
        }
    }
    .modelContainer(container)
    .environment(NavigationManager())
}
