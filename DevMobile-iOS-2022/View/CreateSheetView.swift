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
    var body: some View {
        NavigationView{
            Form{
               HStack{
                  Text("Nom de la recette:");
                  TextField("nom recette", text: $nomRecette)
                     /*.onSubmit {
                        vm.intentstate.intentToChange(name: name)
                     }*/
               }
               HStack{
                  Text("Nom de l'auteur :");
                  TextField("auteur", text: $nomAuteur)
                     /*.onSubmit {
                        vm.intentstate.intentToChange(ram: vm.ram)
                     }*/
               }
                HStack{
                   Text("Nombre de couverts :");
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
                }
                Divider()
                /*Text("name: \(vm.name)")
               Text("ram : \(vm.ram)")*/
                if (nomRecette != "") && (categorieRecette != "") && (Nbre_couverts != nil) && (nomAuteur != "")  {
                    Button(action: {SheetDAO.CreateSheet(nomRecette: nomRecette, nomAuteur: nomAuteur, nombreCouverts: Nbre_couverts, categorieRecette: categorieRecette) }){
                        Text("Créer fiche technique")
                    }
                }
            }.navigationTitle("Créer une fiche")
                .foregroundColor(.blue)
            
        }
    }
}

struct CreateSheetView_Previews: PreviewProvider {
    static var previews: some View {
        CreateSheetView()
    }
}
