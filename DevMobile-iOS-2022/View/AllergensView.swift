//
//  AllergensView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 05/03/2022.
//

import SwiftUI

//MARK: vue liste allergènes
struct AllergensView: View {
    @State private var searchString = ""
    @ObservedObject var viewModel: IngredientListViewModel
    @ObservedObject var dataIngredient: IngredientListViewModel = IngredientListViewModel()
    private var _listIngredient: [IngredientViewModel]!
    var listIngredient: [IngredientViewModel] {
        return dataIngredient.datavm.filter{ $0.idCategorieAllergene != ""}
    }
    
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
                    Text("Chargement des allergènes")
                        .foregroundColor(.mint)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .mint))
                        .scaleEffect(2)
                case .loadingError:
                    Text("erreur")
                default :
                    List {
                        ForEach(searchString == "" ? listIngredient : listIngredient.filter { $0.libelle.contains(searchString) }, id: \.ingredient.idIngredient) {
                            allergenIngredient in
                            //NavigationLink(destination: IngredientView(vm: vm)){
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(allergenIngredient.libelle)
                                        .fontWeight(.bold)
                                        .foregroundColor(.mint)
                                }
                                HStack{
                                    Text("Catégorie : ")
                                        .fontWeight(.semibold)
                                        .italic()
                                        .foregroundColor(.mint)
                                    Text(allergenIngredient.idCategorieAllergene ?? "")
                                        .italic()
                                        .fontWeight(.bold)
                                }
                                Text("Code : \(allergenIngredient.idIngredient)")
                                    .italic()
                            }
                            //}
                        }.navigationTitle("Allergènes 🦠")
                    }.searchable(text: $searchString)
                }
                
                VStack {
                    Button(action: {
                        dataIngredient.fetchData()
                    }){
                        Text("Rafraîchir la liste")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.green, lineWidth: 5)
                            )
                    }.padding()
                }
            }
        }
    }
}

struct AllergensView_Previews: PreviewProvider {
    static var previews: some View {
        AllergensView(viewModel: IngredientListViewModel())
    }
}
