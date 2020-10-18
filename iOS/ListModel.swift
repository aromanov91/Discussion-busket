//
//  ListModel.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 18.10.2020.
//

import SwiftUI
import FirebaseFirestore

public struct ListModel: Hashable, Decodable, Identifiable {

    public var name: String
    public var id: String
//    public var lastName: String
//    public var pic: String
//    public var bio: String
//    public var uid: String
    
    public init(name: String, documentID: String/*, lastName: String, pic: String, bio: String, uid: String*/) {
        self.name = name
        self.id = documentID
//        self.lastName = lastName
//        self.pic = pic
//        self.bio = bio
//        self.uid = uid
    }
    
    public init?(document: DocumentSnapshot) {
        
        guard let data = document.data() else { return nil}
        let name = data["name"] as? String
        let id = data["documentID"] as? String
//        let lastName = data["lastName"] as? String
//        let pic = data["imageurl"] as? String
//        let bio = data["bio"] as? String
//        let uid = data["uid"] as? String
        
        self.name = name ?? ""
        self.id = id ?? ""
//        self.lastName = lastName ?? ""
//        self.pic = pic ?? ""
//        self.bio = bio ?? ""
//        self.uid = uid ?? ""
    }
}
