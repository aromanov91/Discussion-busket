//
//  Left.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 18.10.2020.
//
import Foundation
import Combine
import M7Native

class LeftViewModel: ObservableObject {
    
    @Published var listName = "Default"
    
    @Published var iconName: M7IconNames = .folder

    @Published var isShowEditor = false
    
    @Published var noLists = false
    
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
        
        self.getUserLists()
    }
    
    
    func createList() {
        
        errorText = ""
        isLoad = true
        
        let newList = ListModel(name: listName, icon: iconName.rawValue, owner: firestoreService.authenticationService.uid)
        
        firestoreService.createList(newList) { (result) in

            switch result {
        
            case .success(_):
                self.isLoad = false
                
            case .failure(let error):
                self.isLoad = false
                self.errorText = error.localizedDescription
                
            }
        }
    }
    
    func getUserLists() {
        
        
        firestoreService.updateUserLists()
        
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
