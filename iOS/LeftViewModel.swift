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
                .setData(from: UserListModel(name: list.name))
            
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

    
//    func getListData(userList: UserListModel) -> ListModel {
//        let docRef = db.collection("lists").document(userList.id ?? "")
//
//        docRef.getDocument { (document, error) in
//
//            guard let documents = document?.documents else {
//                print("No documents")
//                return
//            }
//
//            self.userLists = documents.compactMap { queryDocumentSnapshot -> UserListModel? in
//                return try? queryDocumentSnapshot.data(as: UserListModel.self)
//            }
//        }
//
//
//    }
//
//    func getListData(userList: UserListModel) -> ListModel {
//        let docRef = db.collection("lists").document(userList.id ?? "")
//
//        docRef.getDocument { (document, error) in
//
//            if let document = document, document.exists {
//
//                let dataDescription = document.compactMap { queryDocumentSnapshot -> ListModel? in
//                print("Document data: \(dataDescription)")
//
//
//
//                return ListModel(from: dataDescription)
//            } else {
//                return ListModel(
//            }
//        }
//
//
//    }
    
//    func  getListData(userList: UserListModel, completion: @escaping (ListModel)->()) {
//        db.collection("lists").document(userList.id ?? "").getDocument { (querySnapshot, error) in
//            guard let documents = querySnapshot?.document else {
//                print("No documents")
//                return
//            }
//
//
//
//
//
//            completion(user)
//      }
//
    
//    func getListData(userList: UserListModel, completion: @escaping (Result<ListModel, Error>) -> Void) {
//        
//        let docRef = db.collection("lists").document(userList.id ?? "")
//        
//        docRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                guard let list = ListModel(from: document) else {
//                    completion(.failure(error))
//                    return
//                }
//                self.currentUser = muser
//                completion(.success(muser))
//            } else {
//                completion(.failure(UserError.cannotGetUserInfo))
//            }
//        }
//    }
    
//    func getList(uid: String, completion: @escaping (ListModel) -> Void) {
//
//
//
//    let db = Firestore.firestore()
//    let docRef = db.collection("users")
//    dispatchGroup.enter()
//    docRef.getDocuments { (querySnapshot, err) in
//
//        for document in querySnapshot!.documents {
//            print("disp enter")
//            let dic = document.data()
//            model.append(UserModel(dictionary: dic))
//        }
//         dispatchGroup.leave()
//    }
//    dispatchGroup.notify(queue: .main) {
//        completion(model)
//        print("completion")
//    }
//    }
    
//        func getList(uid: String) {
//
//           // self.db.collection("lists").getDocuments { (snapshot, err) in
//
//                self.db.collection("users").document(self.uid).collection("lists").document(uid).getDocument { (querySnapshot, error) in
//                guard let document = querySnapshot?.document else {
//                    print("No documents")
//                    return
//                }
//
//               let list = document.compactMap { queryDocumentSnapshot -> UserListModel? in
//                    return try? queryDocumentSnapshot.data(as: UserListModel.self)
//                }
//
//            }
//
//
//
//        }
    
    
    
    
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
    
    
    
    
    
    
    //    func getLists() {
    //
    //        //for name in userListsNames {
    //
    //
    //
    ////        self.db.collection("lists").getDocuments { (snapshot, err) in
    ////                if let document = document, document.exists {
    ////                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
    ////
    ////
    ////
    ////                    self.userLists.append(ListModel(name: "", icon: "", owner: ""))
    ////
    ////                    print("Document data: \(dataDescription)")
    ////
    ////                } else {
    ////                    print("Document does not exist")
    ////                }
    ////            }
    ////
    ////
    ////        //}
    //
    //        self.db.collection("lists").getDocuments { (snapshot, err) in
    //            if let err = err {
    //                print("Error getting documents: \(err)")
    //            } else {
    //                for document in userListsNames {
    //                   let docId = document.documentID
    //                   let latMax = document.get("latMax") as! String
    //                   let latMin = document.get("latMin") as! String
    //                   let lonMax = document.get("lonMax") as! String
    //                   let lonMin = document.get("lonMin") as! String
    //                   print(docId, latMax, latMin, lonMax, lonMin)
    //                }
    //            }
    //
    //    }
    
}
