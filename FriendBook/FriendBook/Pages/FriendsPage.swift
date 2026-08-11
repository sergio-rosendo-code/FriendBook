//
//  FriendsPage.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/9/26.
//

import SwiftData
import SwiftUI

struct FriendsPage: View {
    var userId: UUID? = nil
    @Environment(\.modelContext) private var modelContext
    @State private var users = [User]()
    @State private var sortBy = SortBy.name
    @State private var orderIn = OrderIn.ascending
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    Label(user.name, systemImage: "person.circle")
                }
            }
            .navigationTitle("All Friends")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Order", systemImage: "arrow.up.arrow.down") {
                        ForEach(OrderIn.allCases, id: \.self) { order in
                            Button(order.rawValue) {
                                self.orderIn = order
                                let _ = fetchUsersFromDb()
                            }
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "line.3.horizontal.decrease.circle") {
                        ForEach(SortBy.allCases, id: \.self) { sort in
                            Button(sort.rawValue) {
                                self.sortBy = sort
                                let _ = fetchUsersFromDb()
                            }
                        }
                    }
                }
            }
            .task {
                let fetchedFromDb = fetchUsersFromDb()
                
                if !fetchedFromDb {
                    await fetchUsersFromServer()
                }
            }
        }
    }
    
    private func fetchUsersFromDb() -> Bool {
        print("Fetching users from db...")
        
        do {
            var predicate: Predicate<User>?
            
            if let userId = self.userId {
                predicate = #Predicate<User> { user in
                    user.friends.contains { friend in
                        friend.id == userId
                    }
                }
            }
            
            let sortOrder = self.orderIn == .ascending ? SortOrder.forward : SortOrder.reverse
            let sortDescriptor = self.sortBy == .name ? [SortDescriptor<User>(\.name, order: sortOrder)] : [SortDescriptor<User>(\.company, order: sortOrder)]
            let descriptor = FetchDescriptor<User>(predicate: predicate, sortBy: sortDescriptor)

            let fetchedUsers  = try modelContext.fetch(descriptor)
            
            if (!fetchedUsers.isEmpty) {
                self.users = fetchedUsers
                return true
            }
        } catch {
            print("There was an issue fetching users from local database.")
        }
        
        return false
    }
    
    private func fetchUsersFromServer() async {
        print("Fetching users from server...")
        
        guard users.isEmpty else {
            return
        }

        do {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let fetchedUsers = try decoder.decode([User].self, from: data)
            
            if !fetchedUsers.isEmpty {
                self.users = fetchedUsers
                fetchedUsers.forEach { modelContext.insert($0) }
            }
        } catch {
            print("There was an issue fetching users from server.")
        }
    }
}

#Preview {
    FriendsPage()
        .modelContainer(for: [User.self, Friend.self], inMemory: true)
}
