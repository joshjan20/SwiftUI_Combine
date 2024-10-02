//
//  UserViewModel.swift
//  SwiftUI_Combine
//
//  Created by JJ on 02/10/24.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    // Published property to notify the SwiftUI view about data changes
    @Published var users: [User] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchUsers()
    }

    func fetchUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }

        // Combine network request
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)  // Ensure that updates happen on the main thread
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching users: \(error)")
                }
            }, receiveValue: { [weak self] users in
                self?.users = users
            })
            .store(in: &cancellables)
    }
}

