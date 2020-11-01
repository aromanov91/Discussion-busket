//
//  ListModel.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 18.10.2020.
//

import Foundation
import FirebaseFirestoreSwift

struct ListModel: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
    var icon: String
    var owner: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case icon
        case owner
      }
}
