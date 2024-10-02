//
//  UserListView.swift
//  SwiftUI_Combine
//
//  Created by JJ on 02/10/24.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.users) { user in
                UserRow(user: user)
                    .frame(maxWidth: .infinity) // Ensures the row background spans full width
                    .padding(.vertical, 10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)) // Remove default insets
                                    
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Users")
            .background(Color(UIColor.systemGray6))
        }
    }
}

struct UserRow: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 15) {
            // Add user icon or initials
            Circle()
                .fill(Color.blue)
                .frame(width: 50, height: 50)
                .overlay(
                    Text(initials(for: user))
                        .font(.headline)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(user.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(user.email)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Makes sure the content uses full width
        .padding()
    }
    
    // Helper function to extract user initials
    private func initials(for user: User) -> String {
        let nameComponents = user.name.split(separator: " ")
        let initials = nameComponents.compactMap { $0.first }.prefix(2)
        return initials.map { String($0) }.joined().uppercased()
    }
}
