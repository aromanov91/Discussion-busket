//
//  File.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 01.11.2020.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestoreSwift
import M7Native
import M7NativeFirebase

class FirestoreService: ObservableObject {
    
    @Published var authenticationService = AuthenticationService()
    
    let db = Firestore.firestore()
    
    @Published var defaultListUID: String = ""
    
    @Published var userLists: [UserListModel] = []
    
    @Published var itemRows: [ItemRowModel] = []
    
    @Published var isLoadData = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        
        self.authenticationService.objectWillChange
            .sink { _ in
                self.objectWillChange.send() }
            .store(in: &cancellables)
        
        getStartData { (result) in }
    }
    
    func getStartData(complition: @escaping(Result<UserData, Error>) -> Void) {
        
        authenticationService.run { (data) in
            switch data {
            
            case .success(let userData):
                
                self.defaultListUID = userData.defaultList
                
                self.getUserLists()
                
                self.getItemRows()
                
                self.isLoadData = false
                
            case .failure(_):
                
                self.isLoadData = false
            }
        }
        
    }
    
    // MARK:- List
    
    func createList(_ list: ListModel, complition: @escaping(Result<String, Error>) -> Void ) {
        
        do {
            let doc = try db.collection("lists")
                .addDocument(from: list)
            
            let _ = try self.db.collection("users").document(self.authenticationService.uid).collection("lists").document(doc.documentID)
                .setData(from: UserListModel(name: list.name, icon: list.icon))
            
            complition(.success(doc.documentID))
        }
        catch {
            print(error)
            complition(.failure(error))
        }
    }
    
    func setDefaultList(_ list: UserListModel, complition: @escaping(Result<String, Error>) -> Void ) {
        
        do {
            
            var userData = authenticationService.userData
            
            userData.defaultList = list.id ?? ""
            
            let _ = try self.db.collection("users").document(self.authenticationService.uid)
                .setData(from: userData)
            
            complition(.success(list.id ?? ""))
        }
        catch {
            print(error)
            complition(.failure(error))
        }
    }
    
    
    
    func createDefaultList(complition: @escaping(Result<String, Error>) -> Void ) {
        
        let defaultlist = ListModel(name: "Default", icon: "home", owner: self.authenticationService.uid)
        
        createList(defaultlist) { (result) in
            
            switch result {
            
            case .success(let id):
                complition(.success(id))
            case .failure(let error):
                complition(.failure(error))
            }
            
        }
    }
    
    func getUserLists() {
        
        db.collection("users").document(self.authenticationService.uid).collection("lists")
            .addSnapshotListener { (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.userLists = documents.compactMap { queryDocumentSnapshot -> UserListModel? in
                    return try? queryDocumentSnapshot.data(as: UserListModel.self)
                }
                
                if self.userLists.isEmpty {
                    
                    self.createDefaultList { (result) in
                        
                        switch result {
                        case .success(_): break
                        case .failure(_): break
                        }
                    }
                }
            }
    }
    
    
    
    func getListData(userList: UserListModel, completion: @escaping (Result<ListModel, Error>)->()) {
        
        let thisUser = db.collection("lists").document(userList.id ?? "")
        
        thisUser.getDocument(completion: { snapshot, error in
            
            if let err = error {
                print(err.localizedDescription)
                completion(.failure(err))
            }
            let list = try? snapshot?.data(as: ListModel.self)
            
            completion(.success(list ?? ListModel(name: "", icon: "", owner: "")))
        })
    }
    
    func deleteUserList(_ list: UserListModel, complition: @escaping(Result<Void, Error>) -> Void ) {
        
        if let documentId = list.id {
            
            db.collection("lists").document(documentId)
                .delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                        complition(.failure(error))
                    }
                }
            
            db.collection("users").document(self.authenticationService.uid).collection("lists").document(documentId)
                .delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                        complition(.failure(error))
                    }
                    complition(.success(()))
                }
        }
    }
    
    // MARK:- Row Item
    
    func createItemRow(list: ListModel, row: ItemRowModel, complition: @escaping(Result<String, Error>) -> Void ) {
        
        do {
            let _ = try db.collection("lists").document(authenticationService.userData.defaultList).collection("rows")
                .addDocument(from: row)
            
            complition(.success(""))
        }
        catch {
            print(error)
            complition(.failure(error))
        }
    }
    
    func createItemRow(list: String, row: ItemRowModel, complition: @escaping(Result<String, Error>) -> Void ) {
        
        print("List" + list)
        
        print(row)
        
        do {
            let item = try db.collection("lists").document(authenticationService.userData.defaultList).collection("rows")
                .addDocument(from: row)
            
            print(item)
            
            complition(.success(""))
        }
        catch {
            print(error)
            complition(.failure(error))
        }
    }
    
    func getItemRows() {
        
        db.collection("lists").document(authenticationService.userData.defaultList).collection("rows")
            .addSnapshotListener { (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.itemRows = documents.compactMap { queryDocumentSnapshot -> ItemRowModel? in
                    return try? queryDocumentSnapshot.data(as: ItemRowModel.self)
                }
            }
    }
    
    func  deleteItemRows(list: String, row: ItemRowModel, complition: @escaping(Result<Void, Error>) -> Void ) {
        
        if let documentId = row.id {
            
            db.collection("lists").document(list).collection("rows").document(documentId)
                .delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                        complition(.failure(error))
                    }
                    complition(.success(()))
                }
        }
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





//    func updateUserLists(complition: @escaping(Result<Bool, Error>) -> Void) {
//
//        db.collection("users").document(self.authenticationService.uid).collection("lists").addSnapshotListener { (querySnapshot, error) in
//
//            if let err = error {
//                print(err.localizedDescription)
//                complition(.failure(err))
//            }
//
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//
//                return
//
//            }
//
//            self.userLists = documents.compactMap { queryDocumentSnapshot -> UserListModel? in
//
//                complition(.success(true))
//
//                return try? queryDocumentSnapshot.data(as: UserListModel.self)
//
//            }
//
//            if self.userLists.isEmpty {
//
//                self.createDefaultList { (result) in
//
//                    switch result {
//
//                    case .success(_):
//                        complition(.success(false))
//
//
//                    case .failure(let error):
//
//                        complition(.failure(error))
//
//                    }
//
//                }
//
//            }
//        }
//    }
