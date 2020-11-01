//
//  Left.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 18.10.2020.
//
import Foundation
import Combine

class LeftViewModel: ObservableObject {
    
    @Published var listName = "Default"

    
    @Published var isShowEditor = false
    
    @Published var noLists = false
    
    @Published var firestoreService = FirestoreService()
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        self.firestoreService.objectWillChange
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        self.getUserLists()
    }
    
    
    func createList() {
        
        //createList(ListModel(name: listName, icon: "home", owner: authenticationService.uid))
    }
    
    
    
    func createDefaultList() {
        
//        let defaultlist = ListModel(name: "Default", icon: "home", owner: self.authenticationService.uid)
//
//        do {
//            let doc = try db.collection("lists")
//                .addDocument(from: defaultlist)
//
//            let _ = try  self.db.collection("users").document(self.authenticationService.uid).collection("lists").document(doc.documentID)
//                .setData(from: UserListModel(name: defaultlist.name))
//        }
//        catch {
//            print(error)
//        }
    }
    
    func getUserLists() {
        
//        if authenticationService.currentUser != nil {
//
//        }
//
//        db.collection("users").document(self.authenticationService.uid).collection("lists").addSnapshotListener { (querySnapshot, error) in
//
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//
//            self.userLists = documents.compactMap { queryDocumentSnapshot -> UserListModel? in
//                return try? queryDocumentSnapshot.data(as: UserListModel.self)
//            }
//
//            if self.userLists.isEmpty {
//
//                self.createDefaultList()
//
//            }
        
    }
    
    func getListData(userList: UserListModel, completion: @escaping (ListModel)->()) {
        
//        let thisUser = db.collection("lists").document(userList.id ?? "")
//
//        thisUser.getDocument(completion: { snapshot, error in
//
//            if let err = error {
//                print(err.localizedDescription)
//                return
//            }
//            let list = try? snapshot?.data(as: ListModel.self)
//
//            completion(list ?? ListModel(name: "", icon: "", owner: ""))
//        })
    }
    
    func deleteUserList(_ list: UserListModel) {
        
//        if let documentId = list.id {
//
//            db.collection("lists").document(documentId).delete { error in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//
//            db.collection("users").document(self.authenticationService.uid).collection("lists").document(documentId).delete { error in
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//            }
//        }
    }
    
}
