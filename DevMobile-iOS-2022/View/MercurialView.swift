//
//  MercurialView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

struct MercurialView: View {
    @State private var searchString = ""
    @ObservedObject var viewModel: IngredientListViewModel
    @StateObject var dataIngredient: IngredientListViewModel = IngredientListViewModel()
    
    init(viewModel: IngredientListViewModel){
        self.viewModel = viewModel
        //print(viewModel.idIngredientCat)
        //self.categoryId = categoryId
        //self.categoryId = categoryId
        //TrackDAO.get()
        
        }
    
    private var ingredientState : IngredientsListState{
           return self.viewModel.ingredientListState
       }
    
    var body: some View {
        NavigationView {
            VStack{
            switch ingredientState {
        case .loading:
            Text("Chargement du mercurial")
                .foregroundColor(.purple)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                .scaleEffect(2)
        case .loadingError:
            Text("erreur")
        default :
          List {
                        ForEach(searchString == "" ? dataIngredient.vms : dataIngredient.vms.filter { $0.ingredient.libelle.contains(searchString) || $0.ingredient.nomCategorie.contains(searchString) }, id: \.ingredient.idIngredient) {
                            vm in
                            NavigationLink(destination: IngredientView(vm: vm)){
                                VStack(alignment: .leading) {
                                    Text(vm.ingredient.libelle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.purple)
                                    HStack{
                                    Text("Catégorie : \(vm.ingredient.nomCategorie)")
                                        .fontWeight(.semibold)
                                       
                                    }
                                    Text("Code : \(vm.ingredient.idIngredient)")
                                        .italic()
                                        //.foregroundColor(.purple)
                                    /*Text("Album : \(vm.track.collectionName) ")*/
                                }
                            }
                        }.navigationTitle("Mercurial")
                        
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

struct MercurialView_Previews: PreviewProvider {
    static var previews: some View {
        MercurialView(viewModel: IngredientListViewModel() )
    }
}
