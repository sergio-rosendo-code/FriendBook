//
//  Extensions.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/13/26.
//

import SwiftData

extension ModelContext {
    func insertAll(_ models: [any PersistentModel]) {
        for model in models {
            insert(model)
        }
    }
}
