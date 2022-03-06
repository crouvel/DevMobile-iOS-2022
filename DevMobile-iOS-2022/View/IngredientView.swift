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
    @State private var showingIncorrect = false
    @State private var modify = false
    @ObservedObject var dataIngredientSheet: IngredientSheetListViewModel = IngredientSheetListViewModel()
    @ObservedObject var dataIngredient: IngredientListViewModel = IngredientListViewModel()
    init(vm: IngredientViewModel){
        self.viewModel = vm
        self.intent = IngredientIntent(vm: vm)
        self.intent.addObserver(vm: self.viewModel)
    }
    
    private var _listIngredientLibelle: [String]!
    var listIngredientLibelle: [String] {
        return dataIngredient.datavm.map{$0.libelle}
    }
    
    private var _listIngredientSheet: [String]!
    var listIngredientSheet: [String] {
        return dataIngredientSheet.datavm.map{$0.libelle}
    }
    
    private var deletionState : DeleteIngredientIntentState {
        return self.viewModel.deletionState
    }
    
    private var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
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
                    if !modify {
                        Button(action: {
                            modify = true
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
                    }
                    // MARK: EDITION INGREDIENT
                    if modify {
                        Section {
                            VStack {
                                HStack{
                                    Text("Libellé :")
                                        .fontWeight(.bold)
                                        .padding()
                                    TextField("", text: $viewModel.libelle)
                                        .padding()
                                        .onSubmit {
                                            
                                        }
                                    Button("Modifier"){
                                        if  listIngredientSheet.contains(where: { $0.lowercased() == viewModel.libelle.lowercased() }){
                                            print("alert : libelle name cannot be used")
                                            showingIncorrect = true
                                        }else {
                                            intent.intentToChange(libelle: viewModel.libelle)
                                            modify = false
                                        }
                                    }.padding()
                                }
                                /*HStack{
                                 Text("Catégorie d'ingrédient : ")
                                 .fontWeight(.bold)
                                 Picker("Catégorie d'ingrédient", selection: $viewModel.idCategorieIngredient) {
                                 Text("Viandes / Volailles")
                                 .foregroundColor(.blue)
                                 .fontWeight(.bold)
                                 .tag(1)
                                 Text("Poisson et crustacés")
                                 .foregroundColor(.blue)
                                 .fontWeight(.bold)
                                 .tag(2)
                                 Text("Crèmerie")
                                 .foregroundColor(.blue)
                                 .fontWeight(.bold)
                                 .tag(5)
                                 Text("Epicerie")
                                 .foregroundColor(.blue)
                                 .fontWeight(.bold)
                                 .tag(9)
                                 Text("Fruits et Légumes")
                                 .foregroundColor(.blue)
                                 .fontWeight(.bold)
                                 .tag(11)
                                 }.padding()
                                 .onSubmit {
                                 //intent.intentToChange(categorie: viewModel.nomCategorie)
                                 }
                                 Button("Edit"){
                                 intent.intentToChange(categorie: viewModel.idCategorieIngredient)
                                 modify = false
                                 }.padding()
                                 }*/
                                HStack{
                                    Text("Quantité stockée :")
                                        .fontWeight(.bold)
                                        .padding()
                                    TextField("", value: $viewModel.quantiteStockee, formatter: valueFormatter)
                                    Text("\(viewModel.unite)")
                                        .fontWeight(.bold)
                                        .padding()
                                    if viewModel.quantiteStockee != nil {
                                        Button("Modifier"){
                                            intent.intentToChange(qte: viewModel.quantiteStockee ?? 0.0)
                                            modify = false
                                        }.padding()
                                    }
                                }
                                HStack{
                                    Text("Prix Unitaire :")
                                        .fontWeight(.bold)
                                        .padding()
                                    TextField("", value: $viewModel.prixUnitaire, formatter: valueFormatter)
                                    Button("Modifier"){
                                        intent.intentToChange(prix: viewModel.prixUnitaire)
                                        modify = false
                                    }.padding()
                                }
                            }.alert("Nom d'ingrédient déjà employé ou identique, veuillez changer de libellé.", isPresented: $showingIncorrect) {
                                Button("OK", role: .cancel) { }
                            }
                        }
                        Button(action: {
                            modify = false
                        }){
                            Text("Terminer")
                                .fontWeight(.bold)
                                .foregroundColor(.indigo)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.indigo, lineWidth: 5)
                                )
                        }
                    }
                    // MARK: END BLOCK EDITION
                    
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
            case .LIBELLE(let reason):
                self.errorMessage = reason
                self.showErrorMessage = true
            case .QUANTITE(let reason):
                self.errorMessage = reason
                self.showErrorMessage = true
            case .PRIX(let reason):
                self.errorMessage = reason
                self.showErrorMessage = true
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
