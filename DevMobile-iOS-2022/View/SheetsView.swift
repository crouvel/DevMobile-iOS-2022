//
//  SheetView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

//MARK: vue Fiches complètes
struct SheetView: View {
    @State private var searchString = ""
    /*@ObservedObject var viewModel: SheetListViewModel
     @StateObject var dataSheet: SheetListViewModel = SheetListViewModel()*/
    @ObservedObject var viewModel2: SheetCompleteListViewModel
    @StateObject var dataSheetComplete: SheetCompleteListViewModel = SheetCompleteListViewModel()
    
    init(viewModel2: SheetCompleteListViewModel){
        //self.viewModel = viewModel
        self.viewModel2 = viewModel2
    }
    
    private var sheetCompleteListState : SheetCompleteListState {
        return self.viewModel2.sheetListState
    }
    
    func deleteItems(at offsets: IndexSet) {
        dataSheetComplete.datavm.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                switch sheetCompleteListState {
                case .loading, .loaded:
                    Text("Chargement des fiches techniques")
                        .foregroundColor(.blue)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2)
                case .loadingError:
                    Text("erreur")
                case .ready:
                    List {
                        ForEach(searchString == "" ? dataSheetComplete.datavm : dataSheetComplete.datavm.filter { $0.sheet.nomRecette.contains(searchString) }, id: \.sheet.idFiche) {
                            vm in
                            NavigationLink(destination: SheetCompleteDetailView(vm: vm)){
                                VStack(alignment: .leading) {
                                    Text(vm.nomRecette)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                    HStack{
                                        Text("Catégorie : \(vm.categorieRecette)")
                                            .fontWeight(.semibold)
                                    }
                                    Text("Couverts : \(vm.Nbre_couverts)")
                                        .italic()
                                }
                            }
                        }.navigationTitle("Fiches Complètes 🍱")
                        
                    }
                    .overlay {
                        if dataSheetComplete.fetching {
                            Text("Chargement des fiches techniques")
                                .foregroundColor(.blue)
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                .scaleEffect(2)
                        }
                    }
                    .searchable(text: $searchString)
                    .onAppear{
                        dataSheetComplete.fetchData()
                    }
                }
                VStack {
                    HStack{
                        NavigationLink(destination: CreateSheetView()){
                            Text("Créer une fiche +")
                                .fontWeight(.bold)
                                .foregroundColor(.cyan)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.cyan, lineWidth: 5)
                                )
                            EmptyView()
                        }
                        NavigationLink(destination: SheetIncompleteListView(viewModel: SheetIncompleteListViewModel())){
                            Text("Liste Fiches vides")
                                .fontWeight(.bold)
                                .foregroundColor(.cyan)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.cyan, lineWidth: 5)
                                )
                            EmptyView()
                        }
                    }
                    
                    Button(action: {
                        SheetDAO.fetchSheet(list: dataSheetComplete)
                    }){
                        Text("Rafraîchir la liste")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth: 5)
                            )
                    }.padding()
                }
            }
        }
    }
}


struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(/*viewModel: SheetListViewModel(),*/ viewModel2: SheetCompleteListViewModel())
    }
}
