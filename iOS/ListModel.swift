//
//  ListModel.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 18.10.2020.
//

import Foundation
import FirebaseFirestoreSwift

struct ListModel: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
    var icon: String
    var owner: String
}
