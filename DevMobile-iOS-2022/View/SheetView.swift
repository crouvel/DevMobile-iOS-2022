//
//  SheetView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

struct SheetView: View {
    @State private var searchString = ""
    /*@ObservedObject var viewModel: SheetListViewModel
    @StateObject var dataSheet: SheetListViewModel = SheetListViewModel()*/
    @ObservedObject var viewModel2: SheetCompleteListViewModel
    @StateObject var dataSheetComplete: SheetCompleteListViewModel = SheetCompleteListViewModel()
    
    init(viewModel2: SheetCompleteListViewModel){
        //self.viewModel = viewModel
        self.viewModel2 = viewModel2
        //print(viewModel.idIngredientCat)
        //self.categoryId = categoryId
        //self.categoryId = categoryId
        //TrackDAO.get()
        
        }
    
    /*private var sheetListState : SheetListState{
           return self.viewModel.sheetListState
       }*/
    private var sheetCompleteListState : SheetCompleteListState {
        return self.viewModel2.sheetListState
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
                     default :
                         List {
                        ForEach(searchString == "" ? dataSheetComplete.vms : dataSheetComplete.vms.filter { $0.sheet.nomRecette.contains(searchString) }, id: \.sheet.idFiche) {
                            vm in
                            NavigationLink(destination: SheetCompleteDetailView(vm: vm)){
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
                               }
                            }
                        }.navigationTitle("Fiches Complètes")
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
                     HStack{
                         NavigationLink(destination: CreateSheetView()){
                             Text("Créer une fiche")
                                 .fontWeight(.bold)
                                 .foregroundColor(.cyan)
                             EmptyView()
                         }.padding()
                         NavigationLink(destination: SheetIncompleteListView(viewModel: SheetIncompleteListViewModel())){
                             Text("Liste Fiches vides")
                                 .fontWeight(.bold)
                                 .foregroundColor(.cyan)
                             EmptyView()
                         }
                         
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
