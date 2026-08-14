//
//  FriendsPage.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/9/26.
//

import SwiftData
import SwiftUI

// This view is designed to either show all available users
// OR show the friends of a specific user given the user id is provided

struct FriendsPage: View {
    var userId: UUID? = nil
    var userName: String? = nil
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationManager.self) private var navigationManager
    @State private var users = [User]()
    @State private var sortBy = SortBy.name
    @State private var orderIn = OrderIn.ascending
    
    
    var body: some View {
        @Bindable var navigationManager = self.navigationManager
        
        NavigationStack(path: $navigationManager.navigationPath) {
            ScrollView{
                LazyVStack() {
                    ForEach(users) { user in
                        ExpandabeContactView(user: user, onShowMore: navigateToProfile)
                    }
                }
                .padding()
            }
            .navigationTitle(userId != nil ? "\(userName!) Friends" : "All Users")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Order", systemImage: "arrow.up.arrow.down") {
                        ForEach(OrderIn.allCases, id: \.self) { order in
                            Button {
                                self.orderIn = order
                                let _ = fetchUsersFromDb()
                            } label: {
                                Label(order.rawValue, systemImage: order == self.orderIn ? "checkmark"  : "")
                            }
                        }
                        .menuStyle(.button)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "line.3.horizontal.decrease.circle") {
                        ForEach(SortBy.allCases, id: \.self) { sort in
                            Button {
                                self.sortBy = sort
                                let _ = fetchUsersFromDb()
                            } label: {
                                Label(sort.rawValue, systemImage: sort == self.sortBy ? "checkmark"  : "")
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Route.self, destination: { route in
                switch route {
                case .friendsPage(let userId, let userName):
                    FriendsPage(userId: userId, userName: userName)
                case .profilePage(let userId):
                    ProfilePage(userId: userId)
                }
            })
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
            var descriptor: FetchDescriptor<User>
            var fetchedUsers: [User]
            let sortOrder = self.orderIn == .ascending ? SortOrder.forward : SortOrder.reverse
            let sortDescriptor = self.sortBy == .name ? [SortDescriptor<User>(\.name, order: sortOrder)] : [SortDescriptor<User>(\.company, order: sortOrder)]
            
            if let userId = self.userId {
                predicate = #Predicate<User> { user in
                    user.id == userId
                }
                
                descriptor = FetchDescriptor<User>(predicate: predicate)
                fetchedUsers = try modelContext.fetch(descriptor)
                
                if let fetchedUser = fetchedUsers.first {
                    let friendIds = fetchedUser.friends.map(\.id)
                
                    predicate = #Predicate<User> { user in
                        friendIds.contains(user.id)
                    }
                }
            }
            
            descriptor = FetchDescriptor<User>(predicate: predicate, sortBy: sortDescriptor)
            fetchedUsers  = try modelContext.fetch(descriptor)

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
    
    private func navigateToProfile(userId: UUID, userName: String){
        self.navigationManager.push(route: .profilePage(userId: userId))
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
    
    return FriendsPage()
        .modelContainer(container)
        .environment(NavigationManager())
}
