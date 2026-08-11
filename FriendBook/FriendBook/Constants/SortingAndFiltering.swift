//
//  SortingAndFiltering.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/10/26.
//

enum SortBy: String, CaseIterable {
    case name = "Name"
    case company = "Company"
}

enum OrderIn: String, CaseIterable {
    case ascending = "A-Z"
    case descending = "Z-A"
}
