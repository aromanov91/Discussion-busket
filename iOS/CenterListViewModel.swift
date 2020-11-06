//
//  CenterViewModel.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 18.10.2020.
//

import Foundation
import Combine
import M7Native

class CenterListViewModel : ObservableObject {
    
    @Published var itemRowText = ""
    
    @Published var isLoad = false
    
    @Published var errorText = ""
    
    @Published var firestoreService = FirestoreService()
    
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        self.firestoreService.objectWillChange
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func createRow(/*completeon: @escaping(Result<String, Error>) -> Void*/) {
        
        errorText = ""
        isLoad = true
        
        let newRow = ItemRowModel(text: itemRowText, time: "", owner: firestoreService.authenticationService.uid)
        
        print(newRow)
        
        firestoreService.createItemRow(list: firestoreService.defaultListUID, row: newRow) { (result) in
            
            switch result {
            
            case .success(_):
                self.isLoad = false
                //completeon(.success(result))
                
            case .failure(let error):
                self.isLoad = false
                self.errorText = error.localizedDescription
                //completeon(.failure(error))
                
            }
        }
    }
    
//    func getRowsItem() {
//
//
//        firestoreService.getItemRows()
//
//    }
//
//    func getRowsData(userList: UserListModel, completion: @escaping (ListModel)->()) {
//
//        firestoreService.getListData(userList: userList) { (result) in
//
//            switch result {
//            case .success(let list):
//                completion(list)
//            case .failure(_):
//                break
//            }
//
//        }
//
//    }
    
    func deleteUserList(row: ItemRowModel) {
        
        firestoreService.deleteItemRows(list: firestoreService.defaultListUID, row: row) { (result) in
            
            switch result {
            
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
}
