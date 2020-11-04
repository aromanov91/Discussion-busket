//
//  CrateNewListView.swift
//  Listixs (iOS)
//
//  Created by Alexander Romanov on 19.10.2020.
//

import SwiftUI
import Combine
import M7Native

final class CrateNewListViewModel: ObservableObject {
    
    @Published var listName = "Default"
    
    @Published var iconName: M7IconNames = .folder
    
    @Published private(set) var items = [[M7IconNames]]()
    
    
    @Published var firestoreService = FirestoreService()
    
    @Published var isLoad = false
    
    @Published var errorText = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        
        self.firestoreService.objectWillChange
            .sink { _ in
                self.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        let paired = (M7IconNames.allCases).publisher.collect(5) // [1,2], [3,4], [5,6] ...
        _ = paired.collect().sink {
            self.items = $0
        }
    }
    
    func createList(completeon: @escaping(Result<String, Error>) -> Void) {
        
        errorText = ""
        isLoad = true
        
        let newList = ListModel(name: listName, icon: iconName.rawValue, owner: firestoreService.authenticationService.uid)
        
        firestoreService.createList(newList) { (result) in
            
            switch result {
            
            case .success(let result):
                self.isLoad = false
                completeon(.success(result))
                
            case .failure(let error):
                self.isLoad = false
                self.errorText = error.localizedDescription
                completeon(.failure(error))
                
            }
        }
    }
    
    func setIconName(_ iconName: M7IconNames) {
        
        self.iconName = iconName
        
    }
}


struct CrateNewListView: View {
    
    @Binding var show: Bool
    
    @EnvironmentObject var viewModel: CrateNewListViewModel
    
    init(show: Binding<Bool>) {
        self._show = show
        
    }
    
    var body: some View {
        
        
        NavigationView {
            
            VStack {
                
                M7Icon(viewModel.iconName, size: .xl)
                    .frame(width: 96, height: 96)
                    .background(M7Colors.surface.secondary)
                    .cornerRadius(24)
                    .padding(.top, M7Space.large)
                
                M7TextField("", text: ($viewModel.listName))
                    .padding(.horizontal, M7Paddings.all.medium)
                
                if #available(iOS 14.0, *) {
                    
                    let columns =  [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: M7Space.xSmall) {
                            
                            ForEach(M7IconNames.allCases, id: \.self) { icon in
                                
                                Button(action: { viewModel.setIconName(icon) } ) {
                                    M7Icon(icon)
                                }.frame(height: 60)
                                
                                
                            }
                        }
                        .padding(.horizontal, M7Space.medium)
                    }
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: M7Space.xSmall)  {
                            ForEach(0..<viewModel.items.count, id: \.self) { pair in
                                // Row
                                HStack(spacing: M7Space.xSmall) {
                                    ForEach(self.viewModel.items[pair], id: \.self) { icon in
                                        ZStack {
                                            Button(action: { viewModel.setIconName(icon) } ) {
                                                M7Icon(icon)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 60)
                                    }
                                }
                            }
                        }.padding(.horizontal, M7Paddings.all.medium)
                    }
                    
                }
            }
            .navigationBarTitle("List.NewListPageTitle", displayMode: .inline)
            .navigationBarItems(trailing:
                                    M7Button(style: .link, size: .m, action: {
                                                
                                                viewModel.createList() { result in
                                                    
                                                    switch result {
                                                    
                                                    case .success(_):
                                                        self.show = false
                                                    case .failure(_):
                                                        break
                                                    }}} ) {
                                        M7Text(M7Localize.button.save, style: .button, color: .primary)})
            
        }
        
    }
    
    
}

//struct CrateNewListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CrateNewListView(name: .constant("Folder"), iconName: .constant(.home), action: { print("") })
//    }
//}

