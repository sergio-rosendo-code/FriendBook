//
//  Expandable.swift
//  FriendBook
//
//  Created by Sergio Rosendo on 8/10/26.
//

import SwiftUI

struct ExpandabeContactView: View {
    let user: User
    @State private var isExpanded: Bool = false
    let onShowMore: (UUID, String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Head
            VStack(alignment: .leading) {
                HStack {
                    Text(user.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down.circle")
                        .font(.headline)
                        .rotationEffect(Angle(degrees: !isExpanded ? 0: -180))
                }
                
                Label(user.company, systemImage: "suitcase")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .contentShape(.rect)
            .onTapGesture {
                withAnimation(.spring) {
                    isExpanded.toggle()
                }
            }
            
            // Body
            if isExpanded {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Contact Info:")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.secondary)
                        Button(user.email, systemImage: "envelope") {
                            UIPasteboard.general.string = user.email
                            // TODO: Needs visual cue that value was copied to clipboard
                        }
                        .font(.subheadline)
                        Button(user.addressFormatted, systemImage: "mail") {
                            UIPasteboard.general.string = user.address
                            // TODO: Needs visual cue that value was copied to clipboard
                        }
                        .font(.subheadline)
                    }
                    
                    HStack {
                        Spacer()
                        Button("show more") {
                            onShowMore(user.id, user.name)
                        }
                    }
                }
                .transition(.opacity)
            }   
        }
        .padding()
        .background(.thickMaterial)
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let user = DummyData.users.first!

    ExpandabeContactView(user: user) { (_, _) in
        
    }
}
 
