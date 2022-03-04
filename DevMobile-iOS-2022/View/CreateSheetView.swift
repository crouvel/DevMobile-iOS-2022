//
//  CreateSheetView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

struct CreateSheetView: View {
    @State var nomRecette: String = ""
    @State var nomAuteur: String = ""
    @State var Nbre_couverts: Int = 1
    @State var categorieRecette: String = ""
    @ObservedObject var viewModelCreation: SheetCompleteViewModel = SheetCompleteViewModel(sheet: SheetComplete(nomRecette: "recette", idFiche: 4444, nomAuteur: "auteur", Nbre_couverts: 2, categorieRecette: "categorie", nomProgression: "testtt"))
    
    private var creationState : CreateSheetIntentState {
        return viewModelCreation.enteteCreationState
    }
    
    var body: some View {
        NavigationView{
            
            VStack{
                switch creationState {
                case .ready:
                    Text("Créer l'entête d'une fiche technique. Vous pourrez finir de la compléter plus tard 🍳.")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                    Divider()
                    Form{
                        Section(header: Text("Création fiche technique")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)){
                            HStack{
                                Text("Nom de la recette :")
                                    .fontWeight(.bold)
                                TextField("nom recette", text: $nomRecette)
                                /*.onSubmit {
                                 vm.intentstate.intentToChange(name: name)
                                 }*/
                            }
                            HStack{
                                Text("Nom de l'auteur :")
                                    .fontWeight(.bold)
                                TextField("auteur", text: $nomAuteur)
                                /*.onSubmit {
                                 vm.intentstate.intentToChange(ram: vm.ram)
                                 }*/
                            }
                            HStack{
                                Text("Nombre de couverts :")
                                    .fontWeight(.bold)
                                TextField("couverts", value: $Nbre_couverts, formatter: NumberFormatter())
                                /*.onSubmit {
                                 vm.intentstate.intentToChange(ram: vm.ram)
                                 }*/
                            }
                            HStack{
                                Picker("Catégorie de recette", selection: $categorieRecette) {
                                    Text("Entrée").tag("Entrée")
                                    Text("Plat").tag("Plat")
                                    Text("Dessert").tag("Dessert")
                                    Text("Autre").tag("Autre")
                                }
                                Text("\(categorieRecette)")
                                    .fontWeight(.bold)
                            }
                            if (nomRecette != "") && (categorieRecette != "") && (Nbre_couverts != nil) && (nomAuteur != "")  {
                                Divider()
                                Button(action: {SheetDAO.CreateSheet(nomRecette: nomRecette, nomAuteur: nomAuteur, nombreCouverts: Nbre_couverts, categorieRecette: categorieRecette, vm:viewModelCreation) }){
                                    Text("Créer fiche technique")
                                        .fontWeight(.bold)
                                        .frame(alignment: .center)
                                }
                            }
                        }
                    }
                case .creating:
                    Text("Création de l'entête de la fiche")
                        .foregroundColor(.black)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
                case .created:
                    Text("La fiche \(nomRecette) a bien été créée ! Vous pouvez la retrouver dans la liste des fiches vides ✨." )
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding()
                    Divider()
                    Button(action: {
                        nomRecette = ""
                        nomAuteur = ""
                        Nbre_couverts = 1
                        categorieRecette = ""
                        SheetCompleteIntent(vm: viewModelCreation).created()
                    }){
                        Text("Compris !")
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                        Text("Vous allez être redirigé(e) sur la page de création en appuyant.")
                            .italic()
                    }
                case .creatingError(let string):
                    Text("Erreur à la création de la fiche, veuillez réessayer ulérieurement")
                        .fontWeight(.bold)
                        .italic()
                    Divider()
                    Button(action: {
                        nomRecette = ""
                        nomAuteur = ""
                        Nbre_couverts = 1
                        categorieRecette = ""
                        SheetCompleteIntent(vm: viewModelCreation).created()
                    }){
                        Text("Ok")
                            .fontWeight(.bold)
                            .frame(alignment: .center)
                    }
                }
            }
        }
        .navigationTitle("Créer une fiche")
        .foregroundColor(.blue)
    }
}

struct CreateSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSheetView()
    }
}
