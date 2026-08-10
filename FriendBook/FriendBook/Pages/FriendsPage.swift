//
//  FriendsPage.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/9/26.
//

import SwiftData
import SwiftUI

struct FriendsPage: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @State private var fetchedFromServer: Int = 0
    @State private var fetchedFromDb: Int = 0
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    Label(user.name, systemImage: "person.circle")
                }
                VStack(alignment: .leading) {
                    Text("Fetched from server: \(fetchedFromServer)")
                    Text("Fetched from db: \(fetchedFromDb)")
                }
            }
            .toolbar {
                Button("delete all data", systemImage: "cpu", role: .destructive, action: deleteAllData)
            }
            .task {
                await fetchUsers()
            }
        }
    }
    
    private func fetchUsers() async {
        guard users.isEmpty else {
            fetchedFromDb = users.count
            return
        }
        
        var fetchedUsers: [User] = []

        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            fetchedUsers = try decoder.decode([User].self, from: data)
            
            fetchedFromServer = fetchedUsers.count
            
            fetchedUsers.forEach { modelContext.insert($0) }
        } catch {
            print("There was an issue fetching users from server.")
        }
    }
    
    private func deleteAllData() {
        do {
            try modelContext.delete(model: User.self)
            try modelContext.delete(model:  Friend.self)
        } catch {
            print("There was an issue deleting all data from database.")
        }
    }
}

#Preview {
    FriendsPage()
        .modelContainer(for: [User.self, Friend.self], inMemory: true)
}
