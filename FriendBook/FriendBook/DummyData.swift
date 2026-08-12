//
//  DummyData.swift
//  FriendFace
//
//  Created by Sergio Rosendo on 7/31/26.
//

import Foundation

enum DummyData {
    static let users = [
        User(
            id: UUID(uuidString: "af9ebc35-fe17-4247-bedc-a8bb111d2fbd")!,
            registered: Calendar.current.date(from: DateComponents(year: 1926, month: 11, day: 5))!,
            name: "Newt Scamander",
            company: "British Ministry of Magic",
            email: "newt.scamander@magic.com",
            address: "175 East 26th Street, New York, New York, 10010",
            about: """
                Newton "Newt" Scamander is a magizoologist and author known for advancing magical creature conservation and education across the wizarding world.
                """,
            friends: [
                Friend(id: UUID(uuidString: "8b50c9fa-8eaf-4bb7-9a7d-9be90ec9c002")!, name: "Jacob Kowalski"),
                Friend(id: UUID(uuidString: "f3a7d0bb-62e2-4d5f-b173-4878f2c4a003")!, name: "Albus Dumbledore"),
                Friend(id: UUID(uuidString: "6d7baf31-7865-4d4a-a49f-e6bf8fe78004")!, name: "Leta Lestrange"),
                Friend(id: UUID(uuidString: "2c884e56-6a84-47a0-98e6-a60572e2f005")!, name: "Tina Goldstein")
            ]
        ),
        User(
            id: UUID(uuidString: "8b50c9fa-8eaf-4bb7-9a7d-9be90ec9c002")!,
            registered: Calendar.current.date(from: DateComponents(year: 1926, month: 11, day: 7))!,
            name: "Jacob Kowalski",
            company: "Kowalski Quality Bakery",
            email: "jacob.kowalski@magic.com",
            address: "443 Rivington Street, New York, New York, 10002",
            about: """
                Jacob Kowalski is a warm-hearted baker whose courage and loyalty make him an essential ally and beloved friend.
                """,
            friends: [
                Friend(id: UUID(uuidString: "af9ebc35-fe17-4247-bedc-a8bb111d2fbd")!, name: "Newt Scamander"),
                Friend(id: UUID(uuidString: "f3a7d0bb-62e2-4d5f-b173-4878f2c4a003")!, name: "Albus Dumbledore"),
                Friend(id: UUID(uuidString: "6d7baf31-7865-4d4a-a49f-e6bf8fe78004")!, name: "Leta Lestrange"),
                Friend(id: UUID(uuidString: "2c884e56-6a84-47a0-98e6-a60572e2f005")!, name: "Tina Goldstein")
            ]
        ),
        User(
            id: UUID(uuidString: "f3a7d0bb-62e2-4d5f-b173-4878f2c4a003")!,
            registered: Calendar.current.date(from: DateComponents(year: 1927, month: 3, day: 14))!,
            name: "Albus Dumbledore",
            company: "Hogwarts School of Witchcraft and Wizardry",
            email: "albus.dumbledore@magic.com",
            address: "Hogwarts Castle, Hogsmeade, Scotland, 73021",
            about: """
                Albus Dumbledore is a brilliant professor and strategist known for his wisdom, leadership, and commitment to the greater good.
                """,
            friends: [
                Friend(id: UUID(uuidString: "af9ebc35-fe17-4247-bedc-a8bb111d2fbd")!, name: "Newt Scamander"),
                Friend(id: UUID(uuidString: "8b50c9fa-8eaf-4bb7-9a7d-9be90ec9c002")!, name: "Jacob Kowalski"),
                Friend(id: UUID(uuidString: "6d7baf31-7865-4d4a-a49f-e6bf8fe78004")!, name: "Leta Lestrange"),
                Friend(id: UUID(uuidString: "2c884e56-6a84-47a0-98e6-a60572e2f005")!, name: "Tina Goldstein")
            ]
        ),
        User(
            id: UUID(uuidString: "6d7baf31-7865-4d4a-a49f-e6bf8fe78004")!,
            registered: Calendar.current.date(from: DateComponents(year: 1927, month: 5, day: 2))!,
            name: "Leta Lestrange",
            company: "French Ministry of Magic",
            email: "leta.lestrange@magic.com",
            address: "8 Place de l'Opera, Paris, Ile-de-France, 75009",
            about: """
                Leta Lestrange is an intelligent and complex witch whose decisiveness and bravery define her role in turbulent times.
                """,
            friends: [
                Friend(id: UUID(uuidString: "af9ebc35-fe17-4247-bedc-a8bb111d2fbd")!, name: "Newt Scamander"),
                Friend(id: UUID(uuidString: "8b50c9fa-8eaf-4bb7-9a7d-9be90ec9c002")!, name: "Jacob Kowalski"),
                Friend(id: UUID(uuidString: "f3a7d0bb-62e2-4d5f-b173-4878f2c4a003")!, name: "Albus Dumbledore"),
                Friend(id: UUID(uuidString: "2c884e56-6a84-47a0-98e6-a60572e2f005")!, name: "Tina Goldstein")
            ]
        ),
        User(
            id: UUID(uuidString: "2c884e56-6a84-47a0-98e6-a60572e2f005")!,
            registered: Calendar.current.date(from: DateComponents(year: 1926, month: 11, day: 6))!,
            name: "Tina Goldstein",
            company: "MACUSA",
            email: "tina.goldstein@magic.com",
            address: "233 Broadway, New York, New York, 10279",
            about: """
                Porpentina "Tina" Goldstein is a principled auror known for her sharp instincts, integrity, and steadfast dedication to justice.
                """,
            friends: [
                Friend(id: UUID(uuidString: "af9ebc35-fe17-4247-bedc-a8bb111d2fbd")!, name: "Newt Scamander"),
                Friend(id: UUID(uuidString: "8b50c9fa-8eaf-4bb7-9a7d-9be90ec9c002")!, name: "Jacob Kowalski"),
                Friend(id: UUID(uuidString: "f3a7d0bb-62e2-4d5f-b173-4878f2c4a003")!, name: "Albus Dumbledore"),
                Friend(id: UUID(uuidString: "6d7baf31-7865-4d4a-a49f-e6bf8fe78004")!, name: "Leta Lestrange")
            ]
        )
    ]
}
