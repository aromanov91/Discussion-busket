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
    
    @Published var userLists: [UserListModel] = []
    
    var status = false
    
    init() {
        
        status = authService.status
            
            self.uid = authService.uid
            
            self.getUserLists()
    }
    
    func createList() {
        
        createList(ListModel(name: listName, icon: "home", owner: uid))
    }
    
    func createList(_ list: ListModel) {
        
        do {
            let doc = try db.collection("lists")
                .addDocument(from: list)
            
            let _ = try  self.db.collection("users").document(self.uid).collection("lists").document(doc.documentID)
                .setData(from: UserListModel(name: list.name))
            
        }
        catch {
            print(error)
        }
    }
    
//    func checkUserListsEmpty() {
//
//        let thisUser = db.collection("users").document(self.uid).collection("lists")
//
//        thisUser.getDocuments(completion: { snapshot, error in
//
//            if let err = error {
//                print(err.localizedDescription)
//                return
//            }
//
//            print(snapshot?.documents)
//
//            if snapshot?.documents.isEmpty {
//                self.createDefaultList()
//                print("Создать пустой спсис")
//
//            }
//
//
//        })
//
//
//    }
    
    func createDefaultList() {
        
        let defaultlist = ListModel(name: "Default", icon: "home", owner: self.uid)
        
        do {
            let doc = try db.collection("lists")
                .addDocument(from: defaultlist)
            
            let _ = try  self.db.collection("users").document(self.uid).collection("lists").document(doc.documentID)
                .setData(from: UserListModel(name: defaultlist.name))
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
            
            self.userLists = documents.compactMap { queryDocumentSnapshot -> UserListModel? in
                return try? queryDocumentSnapshot.data(as: UserListModel.self)
            }
            
            if self.userLists.isEmpty {
                
                self.createDefaultList()
                
            }
        }
    }
    
    func getListData(userList: UserListModel, completion: @escaping (ListModel)->()) {
        
        let thisUser = db.collection("lists").document(userList.id ?? "")
        
        thisUser.getDocument(completion: { snapshot, error in
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            let list = try? snapshot?.data(as: ListModel.self)
            
            completion(list ?? ListModel(name: "", icon: "", owner: ""))
        })
    }
    
    func deleteUserList(_ list: UserListModel) {
        
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
