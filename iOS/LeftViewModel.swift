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
    
    var uid = Auth.auth().currentUser?.uid ?? ""
    
    @Published var userLists: [ListModel] = []
    
    public var status: Bool {
        set { UserDefaults.standard.set(newValue, forKey: "Auth.Status") }
        get { UserDefaults.standard.bool(forKey: "Auth.Status") }
    }
    
    init() {
        
        if status {
        
            self.getUserLists()
        
        }
        
            
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
        
        db.collection("users").document(self.uid).collection("lists").addSnapshotListener { querySnapshot, error in

                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }

                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {

                        let documentID = diff.document.documentID
                        let name = diff.document.get("name") as! String
                        self.userLists.append(ListModel(name: name, documentID: documentID))


                    }
                    if (diff.type == .modified) {
                      //  self.leftViewModel.userLists.remove(at: index)


                        print("Modified city: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        let id = diff.document.documentID

                        self.userLists.removeAll { (list) -> Bool in
                            return list.id == id
                        }
                    }
                }
            }


        
        

//        db.collection("users").document(self.uid).collection("lists").addSnapshotListener { (snap, err) in
//            DispatchQueue.main.async {
//                if err != nil {
//                    print((err?.localizedDescription)!)
//                    return
//                } else {
//                    print("no errors")
//                    for i in snap!.documentChanges {
//                        let documentID = i.document.documentID
//                        let name = i.document.get("name") as! String
//                        self.userLists.append(ListModel(name: name, documentID: documentID))
//                    }
//                }
//            }
//        }
    }
    

        
        func deleteUserList(id: String){
            
            db.collection("users").document(self.uid).collection("lists").document(id).delete { (err) in
                if err != nil{
                    print(err!.localizedDescription)
                    return
                }
            }
            
            db.collection("lists").document(id).delete { (err) in
                if err != nil{
                    print(err!.localizedDescription)
                    return
                }
            }
        }
        
    
    
}
