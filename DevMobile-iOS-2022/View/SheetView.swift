//
//  SheetView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

struct SheetView: View {
    @State private var searchString = ""
    @ObservedObject var viewModel: SheetListViewModel
    @StateObject var dataSheet: SheetListViewModel = SheetListViewModel()
    
    init(viewModel: SheetListViewModel){
        self.viewModel = viewModel
        //print(viewModel.idIngredientCat)
        //self.categoryId = categoryId
        //self.categoryId = categoryId
        //TrackDAO.get()
        
        }
    
    private var sheetListState : SheetListState{
           return self.viewModel.sheetListState
       }
    
    var body: some View {
       
        switch sheetListState {
        case .loading:
            Text("Chargement des fiches techniques")
                .foregroundColor(.blue)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
        case .loadingError:
            Text("erreur")
        default :
                NavigationView{
                VStack{
                    List {
                        ForEach(searchString == "" ? dataSheet.vms : dataSheet.vms.filter { $0.sheet.nomRecette.contains(searchString) }, id: \.sheet.idFiche) {
                            vm in
                            NavigationLink(destination: SheetDetailView(vm: vm)){
                                VStack(alignment: .leading) {
                                    Text(vm.sheet.nomRecette)
                                        .fontWeight(.bold)
                                        .foregroundColor(.blue)
                                    HStack{
                                    Text("Catégorie : \(vm.sheet.categorieRecette)")
                                            .fontWeight(.semibold)
                                    }
                                    Text("Couverts : \(vm.sheet.Nbre_couverts)")
                                        .italic()
                                    /*Text("Album : \(vm.track.collectionName) ")*/
                                }
                            }
                        }.navigationTitle("Fiches Techniques complètes")
                        
                        /*ForEach(searchString == "" ? dataSheet.vms : dataSheet.vms.filter { $0.sheet.nomRecette.contains(searchString) }, id: \.sheet.idFiche){
                            
                        }.navigationTitle("A remplir")*/
                        /*.onDelete{ indexSet in dataTrack.data.remove(atOffsets: indexSet)
                        }
                        .onMove {
                            indexSet, index in
                            dataTrack.data.move(fromOffsets: indexSet , toOffset: index)
                        }*/
                    }.searchable(text: $searchString)
                }
            }
    }
}}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(viewModel: SheetListViewModel())
    }
}
