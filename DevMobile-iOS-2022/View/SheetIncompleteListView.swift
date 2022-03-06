//
//  SheetIncompleteListView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

//MARK: vue liste des fiches non complètes
struct SheetIncompleteListView: View {
    @State private var searchString = ""
    @ObservedObject var viewModel: SheetIncompleteListViewModel
    @StateObject var dataSheetIncomplete: SheetIncompleteListViewModel = SheetIncompleteListViewModel()
    
    init(viewModel: SheetIncompleteListViewModel){
        self.viewModel = viewModel
    }
    
    private var sheetListState : SheetListState {
        return self.viewModel.sheetListState
    }
    
    var body: some View {
        NavigationView{
            
            VStack{
                switch sheetListState {
                case .loading, .loaded :
                    Text("Chargement des fiches vides")
                        .foregroundColor(.cyan)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .cyan))
                        .scaleEffect(2)
                    
                case .loadingError:
                    Text("erreur")
                default :
                    List {
                        ForEach(searchString == "" ? dataSheetIncomplete.datavm : dataSheetIncomplete.datavm.filter { $0.sheet.nomRecette.contains(searchString) }, id: \.sheet.idFiche) {
                            vm in
                            NavigationLink(destination: SheetDetailIncompleteView(vm: vm)){
                                VStack(alignment: .leading) {
                                    Text(vm.sheet.nomRecette)
                                        .fontWeight(.bold)
                                        .foregroundColor(.cyan)
                                    HStack{
                                        Text("Catégorie : \(vm.sheet.categorieRecette)")
                                            .fontWeight(.semibold)
                                    }
                                    Text("Couverts : \(vm.sheet.Nbre_couverts)")
                                        .italic()
                                }
                            }
                        }
                        /*.navigationBarItems(trailing:
                         
                         )*/
                        //Navigation bar Item pour accéder aux fiches techniques imcomplètes
                        
                        /*.onDelete{ indexSet in dataTrack.data.remove(atOffsets: indexSet)
                         }i
                         .onMove {
                         indexSet, index in
                         dataTrack.data.move(fromOffsets: indexSet , toOffset: index)
                         }*/
                    }.searchable(text: $searchString)
                      
                            //.navigationBarHidden(true)
                }
            
            } .navigationTitle("Fiches à compléter")
        }
    }
    
}

struct SheetIncompleteListView_Previews: PreviewProvider {
    static var previews: some View {
        SheetIncompleteListView(viewModel: SheetIncompleteListViewModel())
    }
}
