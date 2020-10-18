//
//  Left.swift
//  Listixs (iOS)
//
//  Created by 18391981 on 18.10.2020.
//
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class LeftViewModel: ObservableObject{

    @Published var listName = "Default"
    
    @Published var isShowEditor = false
    
    @Published var noLists = false
    
    let db = Firestore.firestore()
    
    let uid = Auth.auth().currentUser?.uid ?? ""
    
    @Published var userLists: [ListModel] = []
    
    init() {
        self.getUserLists()
    }
//    
    func createList() {
        
        var ref: DocumentReference? = nil
        ref = db.collection("lists").addDocument(data: [
            "name": listName,
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
               self.db.collection("lists").document(ref!.documentID).setData( ["documentID": ref!.documentID], merge: true)
                
                self.db.collection("users").document(self.uid).collection("lists").document(ref!.documentID).setData([
                    "name": self.listName,
                    "documentID": ref!.documentID,
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
                
                
            }
        }
    }
    
    func getUserLists() {
        
        db.collection("lists").addSnapshotListener { (snap, err) in
            DispatchQueue.main.async {
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                } else {
                    print("no errors")
                    for i in snap!.documentChanges {
                        let documentID = i.document.documentID
                        let name = i.document.get("name") as! String
                        self.userLists.append(ListModel(name: name, documentID: documentID))
                    }
                }
            }
        }
    }
    

        
        func deleteUserList(id: String){
            
            db.collection("lists").document(id).delete { (err) in
                if err != nil{
                    print(err!.localizedDescription)
                    return
                }
            }
        }
        
    
    
}
