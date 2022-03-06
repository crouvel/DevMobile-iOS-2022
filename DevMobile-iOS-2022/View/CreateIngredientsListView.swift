//
//  CreateIngredientsListView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 01/03/2022.
//

import SwiftUI

//MARK: vue creer liste ingrédients
struct CreateIngredientsListView: View {
    var nomProgression: String
    @ObservedObject var viewModel: SheetCompleteViewModel
    @State var nomListe: String = ""
    @State var libelle: String = ""
    @State var quantite: Double = 0
    @StateObject var dataIngredient: IngredientListViewModel = IngredientListViewModel()
    
    init(nomProgression: String, vm: SheetCompleteViewModel){
        self.nomProgression = nomProgression
        self.viewModel = vm
    }
    
    private var creationIngredientListState : IngredientListCreationIntentState {
        return self.viewModel.creationStateIngredientList
    }
    
    private var addIngredientState : AddIngredientToListIntentState {
        return self.viewModel.addStateIngredientList
    }
    
    private var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        NavigationView{
            VStack {
                switch creationIngredientListState {
                case .ready:
                    Form{
                        Section(header: Text("Créer une Liste d'ingrédients 📝")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)){
                            HStack{
                                Text("Nom de liste : ");
                                TextField("Nom de la liste", text: $nomListe)
                                /*.onSubmit {
                                 vm.intentstate.intentToChange(name: name)
                                 }*/
                            }.padding()
                            if (nomListe != "") {
                                Button(action: {
                                    //print(self.intent.creationState.description)
                                    IngredientsListStepDAO.CreateIngredientList(nomListe: nomListe, nomProgression: nomProgression, vm: self.viewModel)
                                    /*ProgressionDAO.addProgressionSheet(nomProgression: referenceProgression, nomRecette: self.viewModel.nomRecette)*/
                                }){
                                    Text("Créer liste d'ingrédients")
                                        .fontWeight(.bold)
                                        .foregroundColor(.cyan)
                                        .frame(alignment: .center)
                                }
                            }
                        }
                    }
                    
                case .creating:
                    Text("Création de la liste d'ingrédients")
                        .foregroundColor(.black)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                    
                case .created:
                    switch addIngredientState {
                    case .ready:
                        Text("Liste \(nomListe) créée !")
                            .fontWeight(.bold)
                            .padding()
                        Divider()
                        Form{
                            Section(header: Text("Ajoutez un ingrédient 🥑")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)){
                                VStack{
                                    Picker("Choisissez un ingrédient", selection: $libelle){
                                        ForEach(dataIngredient.datavm, id : \.ingredient.idIngredient) { vm in
                                            Text("\(vm.ingredient.libelle)").tag("\(vm.ingredient.libelle)")
                                        }
                                    }
                                    
                                    VStack{
                                        Text("Quantité : ");
                                        TextField("Quantité de l'ingrédient", value: $quantite, formatter: valueFormatter)
                                    }
                                    
                                }.padding()
                                if (libelle != "") {
                                    Button(action: {
                                        
                                        IngredientsListStepDAO.AddIngredientList(nomListe: nomListe, libelleIngredient: libelle, quantite: quantite, nomProgression: self.nomProgression, vm: self.viewModel )                                    /*ProgressionDAO.addProgressionSheet(nomProgression: referenceProgression, nomRecette: self.viewModel.nomRecette)*/
                                    }){
                                        Text("Ajouter l'ingrédient")
                                            .fontWeight(.bold)
                                            .foregroundColor(.cyan)
                                            .frame(alignment: .center)
                                    }
                                }
                            }
                        }
                    case .adding:
                        Text("Ajout de l'ingrédient")
                            .foregroundColor(.black)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(2)
                    case .added:
                        Text("Ingrédient Ajouté ! Voulez-vous ajouter un autre ingrédient à la liste \(nomListe) ?")
                            .fontWeight(.bold)
                            .padding()
                        Divider()
                        HStack{
                            Button(action: {
                                libelle = ""
                                quantite = 0
                                //print(self.intent.creationState.description)
                                self.viewModel.addStateIngredientList = .ready
                                /*ProgressionDAO.addProgressionSheet(nomProgression: referenceProgression, nomRecette: self.viewModel.nomRecette)*/
                            }){
                                Text("Oui")
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .frame(alignment: .center)
                            }
                            Button(action: {
                                /*libelle = ""
                                 quantite = 0*/
                                //print(self.intent.creationState.description)
                                self.viewModel.addStateIngredientList = .addMoreList
                                /*ProgressionDAO.addProgressionSheet(nomProgression: referenceProgression, nomRecette: self.viewModel.nomRecette)*/
                            }){
                                Text("Non, terminer")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .frame(alignment: .center)
                            }
                        }
                    case .addingError(let string):
                        Text(string)
                            .italic()
                            .fontWeight(.bold)
                    case .addMoreList:
                        Text("Voulez-vous ajouter une autre liste d'ingrédients ? ")
                            .fontWeight(.bold)
                            .padding()
                        Divider()
                        HStack{
                            Button(action: {
                                //print(self.intent.creationState.description)
                                self.viewModel.creationStateIngredientList = .ready
                                /*ProgressionDAO.addProgressionSheet(nomProgression: referenceProgression, nomRecette: self.viewModel.nomRecette)*/
                            }){
                                Text("Oui")
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .frame(alignment: .center)
                            }
                            NavigationLink(destination: FinishSheetCreationView(viewModel: self.viewModel)){
                                Text("Non, terminer")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                EmptyView()
                            }.padding()
                        }
                    }
                    /*NavigationLink(destination: AddIngredientStepView(nomProgression: nomProgression, viewModel: self.viewModel)){
                     Text("Ajouter liste(s) d'ingrédient(s) >")
                     .fontWeight(.bold)
                     .foregroundColor(.black)
                     EmptyView()
                     }.padding()*/
                    
                case .creatingError(let string):
                    Text(string)
                    Text("Erreur à la création de la liste d'ingrédients.")
                        .fontWeight(.bold)
                        .italic()
                        .padding()
                    Divider()
                }
            }
        }.navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct CreateIngredientsListView_Previews: PreviewProvider {
    static var previews: some View {
        CreateIngredientsListView(nomProgression: "ok", vm: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "")))
    }
}
