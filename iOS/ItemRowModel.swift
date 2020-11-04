//
//  MessageModel.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 04.11.2020.
//

import Foundation
import FirebaseFirestoreSwift

struct ItemRowModel: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
    var time: String
    var owner: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case time
        case owner
      }
}
