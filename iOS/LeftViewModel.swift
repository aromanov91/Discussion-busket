//
//  Left.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 18.10.2020.
//
import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import M7NativeFirebase

class LeftViewModel: ObservableObject{
    
    @Published var listName = "Default"
    
    @Published var isShowEditor = false
    
    @Published var noLists = false
    
    @Published var authService = AuthenticationService()
    
    let db = Firestore.firestore()
    
    var uid = ""
    
    @Published var userLists: [ListModel] = []
    
    var status = false
    
    init() {
        
        status = authService.status
        
        if status {
            
            self.uid = authService.uid
            
            self.getUserLists()
            
        }
        
    }
    
    func createList() {
        
        createList(ListModel(name: listName, icon: "home", owner: uid))
        
        
    }
    
    func createList(_ list: ListModel) {
        
        do {
            let doc = try db.collection("lists")
                .addDocument(from: list)
            
            let _ = try  self.db.collection("users").document(self.uid).collection("lists").document(doc.documentID)
                .setData(from: list)
            
//            let _ = try  self.db.collection("users").document(self.uid).collection("lists").document(doc.documentID)
//                .setData(from: UserListModel(name: list.name))
            
        }
        catch {
            print(error)
        }
        
        
    }
    
    func getUserLists() {
        
        db.collection("users").document(self.uid).collection("lists").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.userLists = documents.compactMap { queryDocumentSnapshot -> ListModel? in
                return try? queryDocumentSnapshot.data(as: ListModel.self)
            }
        }
        
    }
    
    
    
    func deleteUserList(_ list: ListModel) {
        
        if let documentId = list.id {
            
            db.collection("lists").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            
            db.collection("users").document(self.uid).collection("lists").document(documentId).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
    
}
