//
//  SheetIncompleteListView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 23/02/2022.
//

import SwiftUI

struct SheetIncompleteListView: View {
    @State private var searchString = ""
    @ObservedObject var viewModel: SheetIncompleteListViewModel
    @StateObject var dataSheetIncomplete: SheetIncompleteListViewModel = SheetIncompleteListViewModel()
    
    init(viewModel: SheetIncompleteListViewModel){
        //self.viewModel = viewModel
        self.viewModel = viewModel
        //print(viewModel.idIngredientCat)
        //self.categoryId = categoryId
        //self.categoryId = categoryId
        //TrackDAO.get()
        }
    
    private var sheetListState : SheetListState {
        return self.viewModel.sheetListState
    }
    
    var body: some View {
                NavigationView{
                    /*VStack{
                        Text("Sélectionnez une fiche technique et ajoutez-y une progression")                        }*/
                    VStack{
                     switch sheetListState {
                     case .loading :
                         Text("Chargement des fiches à compléter")
                             .foregroundColor(.blue)
                         
                         ProgressView()
                             .progressViewStyle(CircularProgressViewStyle(tint: .cyan))
                             .scaleEffect(2)
                         
                     case .loadingError:
                         Text("erreur")
                     default :
                         List {
                        ForEach(searchString == "" ? dataSheetIncomplete.vms : dataSheetIncomplete.vms.filter { $0.sheet.nomRecette.contains(searchString) }, id: \.sheet.idFiche) {
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
                        }.navigationTitle("Fiches Incomplètes")
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
                     }
                    /*switch sheetListState {
                         case .loading:
                             Text("Chargement des fiches techniques")
                                 .foregroundColor(.blue)
                             
                             ProgressView()
                                 .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                 .scaleEffect(2)
                             
                         case .loadingError:
                             Text("erreur")
                         default :
                             List {
                            ForEach(searchString == "" ? dataSheet.vms : dataSheet.vms.filter { $0.sheet.nomRecette.contains(searchString) }, id: \.sheet.idFiche) {
                                vm in
                                //NavigationLink(destination: SheetDetailView(vm: vm)){
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
                                   // }
                                }
                            }.navigationTitle("Fiches Incomplètes")
                            
                            /*.onDelete{ indexSet in dataTrack.data.remove(atOffsets: indexSet)
                            }
                            .onMove {
                                indexSet, index in
                                dataTrack.data.move(fromOffsets: indexSet , toOffset: index)
                            }*/
                        }.searchable(text: $searchString)*/
                     /*HStack{
                         NavigationLink(destination: CreateSheetView()){
                             Text("CREER FICHE +")
                                 .fontWeight(.bold)
                                 .foregroundColor(.cyan)
                             EmptyView()
                         }.padding()
                         NavigationLink(destination: SheetIncompleteListView()){
                             Text("Fiches vides>>")
                                 .fontWeight(.bold)
                                 .foregroundColor(.cyan)
                             EmptyView()
                         }
                     }*/
                }
            }
        }}

struct SheetIncompleteListView_Previews: PreviewProvider {
    static var previews: some View {
        SheetIncompleteListView(viewModel: SheetIncompleteListViewModel())
    }
}
