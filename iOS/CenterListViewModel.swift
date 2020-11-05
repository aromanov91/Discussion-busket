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
        
        self.getRows()
    }
    
    func getRows() {
        
        
        firestoreService.getItemRows()
        
    }
    
    func getListData(userList: UserListModel, completion: @escaping (ListModel)->()) {
        
        firestoreService.getListData(userList: userList) { (result) in
            
            switch result {
            case .success(let list):
                completion(list)
            case .failure(_):
                break
            }
 
        }
        
    }
    
    func setDefaultList(_ list: UserListModel) {
        
        firestoreService.setDefaultList(list) { (result) in
            
            switch result {
            
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
    func deleteUserList(_ list: UserListModel) {
        
        firestoreService.deleteUserList(list) { (result) in
            
            switch result {
            
            case .success(_):
                break
            case .failure(_):
                break
            }
        }
    }
    
//    func setIconName(_ iconName: M7IconNames) {
//
//        self.iconName = iconName
//
//    }
    
}
