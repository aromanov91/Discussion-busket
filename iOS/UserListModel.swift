//
//  UserListModel.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 22.10.2020.
//

import Foundation
import FirebaseFirestoreSwift

struct UserListModel: Identifiable, Codable {
    
    @DocumentID var id: String?
    var name: String
}
