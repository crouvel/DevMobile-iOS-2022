//
//  MercurialView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 14/02/2022.
//

import SwiftUI

//MARK: Vue Mercurial
struct MercurialView: View {
    @State private var searchString = ""
    @ObservedObject var viewModel: IngredientListViewModel
    @StateObject var dataIngredient: IngredientListViewModel = IngredientListViewModel()
    
    init(viewModel: IngredientListViewModel){
        self.viewModel = viewModel
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
                        ForEach(searchString == "" ? dataIngredient.datavm : dataIngredient.datavm.filter { $0.libelle.contains(searchString) || $0.nomCategorie.contains(searchString) }, id: \.ingredient.idIngredient) {
                            vm in
                            NavigationLink(destination: IngredientView(vm: vm)){
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(vm.libelle)
                                            .fontWeight(.bold)
                                            .foregroundColor(.purple)
                                        if vm.allergene == "Oui" {
                                            Text("(Allergene)")
                                                .fontWeight(.bold)
                                                .italic()
                                                .foregroundColor(.indigo)
                                        }
                                    }
                                    HStack{
                                        Text("Catégorie : \(vm.nomCategorie)")
                                            .fontWeight(.semibold)
                                        
                                    }
                                    Text("Code : \(vm.idIngredient)")
                                        .italic()
                                    
                                }
                            }
                        }.navigationTitle("Mercurial 🌶️")
                    }.searchable(text: $searchString)
                        .onAppear{
                            dataIngredient.fetchData()
                        }

                }
                
                VStack {
                    NavigationLink(destination: CreateIngredientView()){
                        Text("Créer un ingrédient +")
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.purple, lineWidth: 5)
                            )
                        EmptyView()
                    }
                    
                    Button(action: {
                        dataIngredient.fetchData()
                    }){
                        Text("Rafraîchir la liste")
                            .fontWeight(.bold)
                            .foregroundColor(.indigo)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.indigo, lineWidth: 5)
                            )
                    }.padding()
                }
            }
        }
    }
}

struct MercurialView_Previews: PreviewProvider {
    static var previews: some View {
        MercurialView(viewModel: IngredientListViewModel() )
    }
}
