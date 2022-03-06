//
//  EtiquetteSansVenteView.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import SwiftUI

struct EtiquetteVenteView: View {
    @ObservedObject var viewModel: SheetCompleteViewModel
    private var _listvm: IngredientVenteListViewModel!
    var listvm: IngredientVenteListViewModel {
        return _listvm
    }
    
    init(viewModel: SheetCompleteViewModel){
        self.viewModel = viewModel
        self._listvm = IngredientVenteListViewModel(idFiche: self.viewModel.idFiche)
    }
    var body: some View {
        HStack{
            Spacer()
            HStack{
                Text("Vente : \(viewModel.nomRecette)")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .font(.system(size: 25))
            }
            Spacer()
        }.background(Color.blue)
        VStack{
           
            VStack{
                /*Text("Ingrédients")
                    .fontWeight(.bold)
                    .font(.system(size: 20))*/
                Divider()
                ForEach( _listvm.vms,id: \.ingredient.libelleCategorie) {
                    vm in
                    HStack{
                        VStack{
                            ForEach(vm.ingredients.split(separator: ";"), id: \.self){ ingredient in
                                HStack{
                                    if ingredient.components(separatedBy: ":").last == "Oui" {
                                        HStack {
                                            Text(ingredient.components(separatedBy: ":").first ?? "")
                                                .fontWeight(.bold)
                                            Text("(Allergène)")
                                                .fontWeight(.semibold)
                                            Image(systemName: "allergens")
                                                .foregroundColor(.red)
                                        }
                                    } else {
                                        Text(ingredient.components(separatedBy: ":").first ?? "")
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }.navigationTitle("Etiquette de vente 📄")
    }
}

struct EtiquetteVenteView_Previews: PreviewProvider {
    static var previews: some View {
        EtiquetteVenteView(viewModel: SheetCompleteViewModel(sheet:SheetComplete(nomRecette:"oui", idFiche: 555555, nomAuteur: "test", Nbre_couverts: 8, categorieRecette: "categorie", nomProgression: "ok")))
    }
}
