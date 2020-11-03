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
    
    @Published private(set) var items = [[M7IconNames]]()
    
    init() {
        let paired = (M7IconNames.allCases).publisher.collect(5) // [1,2], [3,4], [5,6] ...
        _ = paired.collect().sink {
            self.items = $0
        }
    }
    
}


struct CrateNewListView: View {
    
    @Binding var categoryName: String
    
    @Binding var iconName: M7IconNames
    
    //let setAction: () -> Void
    
    let saveAction: () -> Void
    
    
    @ObservedObject var viewModel = CrateNewListViewModel()
    
    init(name: Binding<String>, iconName: Binding<M7IconNames>/*, setAction: @escaping () -> Void*/, saveAction: @escaping () -> Void) {
        self._iconName = iconName
        self._categoryName = name
        // self.setAction = setAction
        self.saveAction = saveAction
        
    }
    
    var body: some View {
        
        
        NavigationView {
            
            VStack {
                
                M7Icon(iconName, size: .xl)
                    .frame(width: 96, height: 96)
                    .background(M7Colors.surface.secondary)
                    .cornerRadius(24)
                    .padding(.top, M7Space.large)
                
                M7TextField("", text: ($categoryName))
                    .padding(.horizontal, M7Paddings.all.medium)
                
                if #available(iOS 14.0, *) {
                    
                    let columns =  [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: M7Space.xSmall) {
                            
                            ForEach(M7IconNames.allCases, id: \.self) { icon in
                                
                                Button(action: { setIconName(icon) } ) {
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
                                            Button(action: { setIconName(icon) } ) {
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
                                    M7Button(style: .link, size: .m, action: saveAction) {
                                        M7Text(M7Localize.button.save, style: .button, color: .primary)})
            
        }
        
    }
    
    func setIconName(_ iconName: M7IconNames) {
        
        self.iconName = iconName
        
    }
}

//struct CrateNewListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CrateNewListView(name: .constant("Folder"), iconName: .constant(.home), action: { print("") })
//    }
//}

