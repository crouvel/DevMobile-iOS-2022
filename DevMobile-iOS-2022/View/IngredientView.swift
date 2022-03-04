//
//  trackView.swift
//  Test_Cours_listUI
//
//  Created by m1 on 08/02/2022.
//

import SwiftUI

struct IngredientView: View {
    var intent: IngredientIntent
    @ObservedObject var viewModel: IngredientViewModel
    @State var errorMessage: String = ""
    @State var showErrorMessage: Bool = false
    @State private var showingAlert = false
    @ObservedObject var dataIngredientSheet: IngredientSheetListViewModel = IngredientSheetListViewModel()
    init(vm: IngredientViewModel){
        self.viewModel = vm
        self.intent = IngredientIntent(vm: vm)
        self.intent.addObserver(vm: self.viewModel)
    }
    private var _listIngredientSheet: [String]!
    var listIngredientSheet: [String] {
        return dataIngredientSheet.vms.map{$0.libelle}
    }
    
    private var deletionState : DeleteIngredientIntentState {
        return self.viewModel.deletionState
    }
    
    var body: some View {
        ScrollView {
            VStack{
                switch deletionState {
                case .ready:
                    Divider()
                    HStack{
                        Spacer()
                        HStack{
                            Text("\(viewModel.libelle)")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                        }
                        Spacer()
                    }.background(Color.indigo)
                        .frame( alignment: .center)
                    Divider()
                    HStack{
                        VStack {
                            Text("Catégorie : ")
                                .fontWeight(.bold)
                            Divider()
                            if viewModel.quantiteStockee != nil {
                                Text("Quantite stockée : ")
                                    .fontWeight(.bold)
                                Divider()}
                            Text("Prix unitaire : ")
                                .fontWeight(.bold)
                            Divider()
                            Text("Allergène : ")
                                .fontWeight(.bold)
                            if viewModel.allergene == "Oui" {
                                Divider()
                                Text("Catégorie d'allergène : ")
                                    .fontWeight(.bold)
                            }
                            VStack{
                                Divider()
                                Text("Unité : ")
                                    .fontWeight(.bold)
                            }
                        }.foregroundColor(.indigo)
                        
                        VStack{
                            HStack {
                                Text("\(viewModel.nomCategorie)")
                                    .fontWeight(.bold)
                            }
                            if viewModel.quantiteStockee != nil {
                                Divider()
                                HStack {
                                    Text(String(format: "%.1f", viewModel.quantiteStockee! ))
                                        .fontWeight(.bold)
                                    Text("\(viewModel.unite)")
                                        .fontWeight(.bold)
                                }
                            }
                            Divider()
                            HStack {
                                Text(String(format: "%.1f", viewModel.prixUnitaire ))
                                    .fontWeight(.bold)
                                Text("€")
                                    .fontWeight(.bold)
                            }
                            Divider()
                            Text("\(viewModel.allergene)")
                                .fontWeight(.bold)
                            if viewModel.allergene == "Oui"{
                                Divider()
                                Text("\(viewModel.idCategorieAllergene ?? "")")
                                    .fontWeight(.bold)
                            }
                            VStack {
                                Divider()
                                Text(viewModel.unite)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    Divider()
                    Divider()
                    Button(action: {
                    }){
                        Text("Modifier l'ingrédient")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.blue, lineWidth: 5)
                            )
                    }
                    Divider()
                    Divider()
                    Button(action: {
                        if  listIngredientSheet.contains(where: { $0 == viewModel.libelle }){
                            print("alert : cannot be deleted")
                            showingAlert = true
                        }else {
                            IngredientDAO.deleteIngredient(idIngredient: viewModel.idIngredient, vm: viewModel)
                        }
                    }){
                        Text("Supprimer l'ingrédient")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.primary, lineWidth: 5)
                            )
                    }
                    .alert("Cet ingrédient ne peut être supprimé, il est présent dans une ou plusieurs fiche(s) technique(s).", isPresented: $showingAlert) {
                        Button("OK", role: .cancel) { }
                    }
                case .deleting(let string):
                    Text("Suppression de l'ingrédient")
                        .foregroundColor(.black)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                case .deleted:
                    Divider()
                    Text("L'ingrédient a bien été supprimé !")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                        .italic()
                        .padding()
                    Divider()
                    Text("Vous pouvez désormais retourner à la liste principale des ingrédients, et RAFRAICHIR la liste !")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .italic()
                        .padding()
                case .deletingError(let string):
                    Text("Erreur à la suppression de la fiche, veuillez réessayer ulérieurement")
                        .fontWeight(.bold)
                        .italic()
                    Divider()
                    Button(action: {
                        IngredientIntent(vm: self.viewModel).deleted()
                    }){
                        Text("Ok")
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                    }
                }
            }
        }
        .navigationTitle("\(viewModel.libelle)")
        .onChange(of: viewModel.error){ error in
            switch error {
            case .NONE:
                return
                /*case .ARTISTNAME(let reason):
                 self.errorMessage = reason
                 self.showErrorMessage = true
                 case .TRACKNAME(let reason):
                 self.errorMessage = reason
                 self.showErrorMessage = true
                 case .COLLECTIONNAME(let reason):
                 self.errorMessage = reason
                 self.showErrorMessage = true*/
            }
        }.alert("\(errorMessage)", isPresented: $showErrorMessage){
            Button("Ok", role: .cancel){
                showErrorMessage = false
            }
            
        }
    }
}


struct trackView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientView(vm: IngredientViewModel(ingredient:Ingredient(libelle: "oui", idIngredient: 8888888, nomCategorie: "test", quantite: 5, prix: 2, allergene: "Oui", idCategorie: 55, idCatAllergene: "categorie" , unite: "Kg"  )))
    }
}
