//
//  UserListModel.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 22.10.2020.
//

import Foundation
import FirebaseFirestoreSwift

struct UserListModel: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
      }
}
